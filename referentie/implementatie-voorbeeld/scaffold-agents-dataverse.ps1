<#
.SYNOPSIS
  Zet de Dataverse-tabellen klaar voor de overige automate-agents van het
  Werkvoorbereider Agent Team: Planning, Mensen, Oplever & Kwaliteit en
  Meer-/minderwerk. Plat model (tekst/getal/memo), idempotent, met fictieve
  seed-data (project "De Beemster").

.DESCRIPTION
  Complement op scaffold-inkoop-dataverse.ps1. Zelfde patroon: Dataverse Web API,
  publisher `wvb`, en veilige (her)uitvoering.

  Auth: log met Azure CLI in op de TENANT van je omgeving:
      az login --tenant <jouw-tenant>.onmicrosoft.com --allow-no-subscriptions

.PARAMETER OrgUrl
  De org-URL van je Dataverse-omgeving, bv. https://contoso.crm.dynamics.com/

.EXAMPLE
  ./scaffold-agents-dataverse.ps1 -OrgUrl https://contoso.crm.dynamics.com/

.NOTES
  Data is FICTIEF. Gebruik een demo-/test-omgeving.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)] [string] $OrgUrl,
  [string] $Prefix = 'wvb',
  [switch] $SkipSeed
)

$ErrorActionPreference = 'Stop'
$OrgUrl = $OrgUrl.TrimEnd('/')
$Api = "$OrgUrl/api/data/v9.2"
$p = $Prefix.ToLower()

Write-Host "Token ophalen voor $OrgUrl ..." -ForegroundColor Cyan
$token = az account get-access-token --resource $OrgUrl --query accessToken -o tsv 2>$null
if (-not $token) { throw 'Geen token. Log eerst in: az login --tenant <jouw-tenant>.onmicrosoft.com --allow-no-subscriptions' }

$H = @{ Authorization = "Bearer $token"; 'OData-MaxVersion' = '4.0'; 'OData-Version' = '4.0'; Accept = 'application/json'; 'Content-Type' = 'application/json; charset=utf-8'; Prefer = 'return=representation' }

function Invoke-Dv {
  param([string]$Method, [string]$Path, $Body)
  $uri = if ($Path -match '^https?://') { $Path } else { "$Api/$Path" }
  $json = $null
  if ($null -ne $Body) { $json = ($Body | ConvertTo-Json -Depth 20) }
  try {
    if ($json) { return Invoke-RestMethod -Method $Method -Uri $uri -Headers $H -Body ([System.Text.Encoding]::UTF8.GetBytes($json)) }
    else { return Invoke-RestMethod -Method $Method -Uri $uri -Headers $H }
  } catch {
    $msg = $_.ErrorDetails.Message; if (-not $msg) { $msg = $_.Exception.Message }
    throw "$Method $uri`n$msg"
  }
}
function Test-Dv { param([string]$Path) try { Invoke-Dv -Method Get -Path $Path | Out-Null; return $true } catch { return $false } }

$org = Invoke-Dv -Method Get -Path 'organizations?$select=languagecode'
$Lcid = [int]$org.value[0].languagecode
function New-Label($text) { @{ '@odata.type' = 'Microsoft.Dynamics.CRM.Label'; LocalizedLabels = @(@{ '@odata.type' = 'Microsoft.Dynamics.CRM.LocalizedLabel'; Label = $text; LanguageCode = $Lcid }) } }

Write-Host "Publisher '$p' controleren ..." -ForegroundColor Cyan
$pub = Invoke-Dv -Method Get -Path "publishers?`$select=publisherid&`$filter=customizationprefix eq '$p'"
if ($pub.value.Count -eq 0) {
  Invoke-Dv -Method Post -Path 'publishers' -Body @{ uniquename = "${p}publisher"; friendlyname = "Werkvoorbereider ($p)"; customizationprefix = $p; customizationoptionvalueprefix = 32100 } | Out-Null
  Write-Host '  + publisher aangemaakt'
} else { Write-Host '  = publisher bestaat' }

function Ensure-Table {
  param([string]$Name, [string]$Singular, [string]$Plural, [string]$PrimaryLabel = 'Naam')
  $logical = $Name.ToLower()
  if (Test-Dv "EntityDefinitions(LogicalName='$logical')?`$select=LogicalName") { Write-Host "  = tabel $Name" }
  else {
    Write-Host "  + tabel $Name"
    $body = @{
      '@odata.type' = 'Microsoft.Dynamics.CRM.EntityMetadata'; SchemaName = $Name
      DisplayName = (New-Label $Singular); DisplayCollectionName = (New-Label $Plural)
      OwnershipType = 'UserOwned'; HasActivities = $false; HasNotes = $false; IsActivity = $false
      Attributes = @(@{ '@odata.type' = 'Microsoft.Dynamics.CRM.StringAttributeMetadata'; SchemaName = "${p}_naam"; IsPrimaryName = $true; MaxLength = 200; FormatName = @{ Value = 'Text' }; RequiredLevel = @{ Value = 'None' }; DisplayName = (New-Label $PrimaryLabel) })
    }
    Invoke-Dv -Method Post -Path 'EntityDefinitions' -Body $body | Out-Null
  }
  (Invoke-Dv -Method Get -Path "EntityDefinitions(LogicalName='$logical')?`$select=EntitySetName").EntitySetName
}
function Ensure-Attr { param([string]$Table, [string]$Schema, [hashtable]$Payload)
  $tl = $Table.ToLower(); $al = $Schema.ToLower()
  if (Test-Dv "EntityDefinitions(LogicalName='$tl')/Attributes(LogicalName='$al')?`$select=LogicalName") { return }
  Write-Host "    + $Schema"; $Payload.SchemaName = $Schema
  Invoke-Dv -Method Post -Path "EntityDefinitions(LogicalName='$tl')/Attributes" -Body $Payload | Out-Null
}
function Ensure-Str  { param($T,$S,$L,$Max=200) Ensure-Attr $T $S @{ '@odata.type'='Microsoft.Dynamics.CRM.StringAttributeMetadata'; MaxLength=$Max; FormatName=@{Value='Text'}; RequiredLevel=@{Value='None'}; DisplayName=(New-Label $L) } }
function Ensure-Int  { param($T,$S,$L) Ensure-Attr $T $S @{ '@odata.type'='Microsoft.Dynamics.CRM.IntegerAttributeMetadata'; Format='None'; MinValue=-2147483648; MaxValue=2147483647; RequiredLevel=@{Value='None'}; DisplayName=(New-Label $L) } }
function Ensure-Memo { param($T,$S,$L,$Max=2000) Ensure-Attr $T $S @{ '@odata.type'='Microsoft.Dynamics.CRM.MemoAttributeMetadata'; MaxLength=$Max; Format='Text'; RequiredLevel=@{Value='None'}; DisplayName=(New-Label $L) } }

Write-Host "`nTabellen ..." -ForegroundColor Cyan
$setTaak = Ensure-Table "${p}_projecttaak"       'Projecttaak'      'Projecttaken'      'Taak'
$setMdw  = Ensure-Table "${p}_medewerker"        'Medewerker'       'Medewerkers'       'Naam'
$setBk   = Ensure-Table "${p}_boeking"           'Boeking'          'Boekingen'         'Naam'
$setRp   = Ensure-Table "${p}_restpunt"          'Restpunt'         'Restpunten'        'Naam'
$setKe   = Ensure-Table "${p}_keuring"           'Keuring'          'Keuringen'         'Onderdeel'
$setWv   = Ensure-Table "${p}_wijzigingsverzoek" 'Wijzigingsverzoek' 'Wijzigingsverzoeken' 'Nummer'

Write-Host "`nKolommen Projecttaak ..." -ForegroundColor Cyan
Ensure-Str "${p}_projecttaak" "${p}_taaknummer"     'Taaknummer'
Ensure-Str "${p}_projecttaak" "${p}_fase"           'Fase'
Ensure-Str "${p}_projecttaak" "${p}_project"        'Project'
Ensure-Str "${p}_projecttaak" "${p}_start"          'Start'
Ensure-Str "${p}_projecttaak" "${p}_eind"           'Eind'
Ensure-Int "${p}_projecttaak" "${p}_gereed"         'Percentage gereed'
Ensure-Str "${p}_projecttaak" "${p}_status"         'Status'
Ensure-Str "${p}_projecttaak" "${p}_afhankelijkvan" 'Afhankelijk van'

Write-Host "`nKolommen Medewerker ..." -ForegroundColor Cyan
Ensure-Str "${p}_medewerker" "${p}_medewerkernummer"  'Medewerkernummer'
Ensure-Str "${p}_medewerker" "${p}_functie"           'Functie'
Ensure-Str "${p}_medewerker" "${p}_certificaat"       'Certificaat'
Ensure-Str "${p}_medewerker" "${p}_certificaatstatus" 'Certificaat-status'
Ensure-Str "${p}_medewerker" "${p}_beschikbaarheid"   'Beschikbaarheid'

Write-Host "`nKolommen Boeking ..." -ForegroundColor Cyan
Ensure-Str  "${p}_boeking" "${p}_medewerker"  'Medewerker'
Ensure-Str  "${p}_boeking" "${p}_project"     'Project'
Ensure-Str  "${p}_boeking" "${p}_weken"       'Weken'
Ensure-Str  "${p}_boeking" "${p}_rol"         'Rol'
Ensure-Str  "${p}_boeking" "${p}_status"      'Status'
Ensure-Memo "${p}_boeking" "${p}_toelichting" 'Toelichting'

Write-Host "`nKolommen Restpunt ..." -ForegroundColor Cyan
Ensure-Str  "${p}_restpunt" "${p}_restpuntnummer"  'Restpuntnummer'
Ensure-Str  "${p}_restpunt" "${p}_locatie"         'Locatie'
Ensure-Memo "${p}_restpunt" "${p}_omschrijving"    'Omschrijving'
Ensure-Str  "${p}_restpunt" "${p}_status"          'Status'
Ensure-Str  "${p}_restpunt" "${p}_verantwoordelijke" 'Verantwoordelijke'

Write-Host "`nKolommen Keuring ..." -ForegroundColor Cyan
Ensure-Str "${p}_keuring" "${p}_resultaat" 'Resultaat'
Ensure-Str "${p}_keuring" "${p}_datum"     'Datum'

Write-Host "`nKolommen Wijzigingsverzoek ..." -ForegroundColor Cyan
Ensure-Memo "${p}_wijzigingsverzoek" "${p}_omschrijving"   'Omschrijving'
Ensure-Str  "${p}_wijzigingsverzoek" "${p}_aard"           'Aard'
Ensure-Str  "${p}_wijzigingsverzoek" "${p}_status"         'Status'
Ensure-Memo "${p}_wijzigingsverzoek" "${p}_onderbouwing"   'Onderbouwing'
Ensure-Str  "${p}_wijzigingsverzoek" "${p}_bron"           'Bron'
Ensure-Str  "${p}_wijzigingsverzoek" "${p}_aangevraagddoor" 'Aangevraagd door'

Write-Host "`nPublish ..." -ForegroundColor Cyan
try { Invoke-Dv -Method Post -Path 'PublishAllXml' | Out-Null; Write-Host '  ok' } catch { Write-Host "  (publish overgeslagen)" -ForegroundColor Yellow }

function Ensure-Row { param([string]$Set, [string]$Naam, [hashtable]$Fields)
  $q = Invoke-Dv -Method Get -Path "$Set`?`$select=${p}_naam&`$filter=${p}_naam eq '$($Naam.Replace("'","''"))'"
  if ($q.value.Count -gt 0) { return }
  Write-Host "    + $Naam"; $Fields["${p}_naam"] = $Naam
  Invoke-Dv -Method Post -Path $Set -Body $Fields | Out-Null
}

if ($SkipSeed) { Write-Host "`nSeed overgeslagen." -ForegroundColor Yellow }
else {
  Write-Host "`nSeed Projecttaak ..." -ForegroundColor Cyan
  Ensure-Row $setTaak 'Grondwerk en fundering' @{ "${p}_taaknummer"='T01'; "${p}_fase"='Ruwbouw'; "${p}_project"='De Beemster'; "${p}_start"='2026-06-01'; "${p}_eind"='2026-06-14'; "${p}_gereed"=100; "${p}_status"='Gereed'; "${p}_afhankelijkvan"='' }
  Ensure-Row $setTaak 'Wanden begane grond'    @{ "${p}_taaknummer"='T02'; "${p}_fase"='Ruwbouw'; "${p}_project"='De Beemster'; "${p}_start"='2026-06-16'; "${p}_eind"='2026-06-30'; "${p}_gereed"=60; "${p}_status"='In uitvoering'; "${p}_afhankelijkvan"='T01' }
  Ensure-Row $setTaak 'Verdiepingsvloeren'     @{ "${p}_taaknummer"='T03'; "${p}_fase"='Ruwbouw'; "${p}_project"='De Beemster'; "${p}_start"='2026-07-01'; "${p}_eind"='2026-07-11'; "${p}_gereed"=0; "${p}_status"='Gepland'; "${p}_afhankelijkvan"='T02' }
  Ensure-Row $setTaak 'Gevel en kozijnen'      @{ "${p}_taaknummer"='T04'; "${p}_fase"='Gevel'; "${p}_project"='De Beemster'; "${p}_start"='2026-07-14'; "${p}_eind"='2026-08-01'; "${p}_gereed"=0; "${p}_status"='Gepland'; "${p}_afhankelijkvan"='T03' }
  Ensure-Row $setTaak 'Installaties (E en W)'  @{ "${p}_taaknummer"='T05'; "${p}_fase"='Afbouw'; "${p}_project"='De Beemster'; "${p}_start"='2026-07-21'; "${p}_eind"='2026-08-08'; "${p}_gereed"=0; "${p}_status"='Gepland'; "${p}_afhankelijkvan"='T03' }
  Ensure-Row $setTaak 'Afbouw en afwerking'    @{ "${p}_taaknummer"='T06'; "${p}_fase"='Afbouw'; "${p}_project"='De Beemster'; "${p}_start"='2026-08-04'; "${p}_eind"='2026-08-22'; "${p}_gereed"=0; "${p}_status"='Gepland'; "${p}_afhankelijkvan"='T04, T05' }
  Ensure-Row $setTaak 'Oplevering'             @{ "${p}_taaknummer"='T07'; "${p}_fase"='Oplevering'; "${p}_project"='De Beemster'; "${p}_start"='2026-08-25'; "${p}_eind"='2026-08-29'; "${p}_gereed"=0; "${p}_status"='Gepland'; "${p}_afhankelijkvan"='T06' }

  Write-Host "`nSeed Medewerker ..." -ForegroundColor Cyan
  Ensure-Row $setMdw 'Jan de Vries'       @{ "${p}_medewerkernummer"='M01'; "${p}_functie"='Timmerman'; "${p}_certificaat"='VCA'; "${p}_certificaatstatus"='geldig t/m 2027'; "${p}_beschikbaarheid"='wk 24-30' }
  Ensure-Row $setMdw 'Piet Bakker'        @{ "${p}_medewerkernummer"='M02'; "${p}_functie"='Metselaar'; "${p}_certificaat"='VCA'; "${p}_certificaatstatus"='verloopt wk 27'; "${p}_beschikbaarheid"='wk 25-34' }
  Ensure-Row $setMdw 'Sanne Willems'      @{ "${p}_medewerkernummer"='M03'; "${p}_functie"='Uitvoerder'; "${p}_certificaat"='VCA-VOL'; "${p}_certificaatstatus"='geldig'; "${p}_beschikbaarheid"='wk 24-40' }
  Ensure-Row $setMdw 'Youssef El Amrani'  @{ "${p}_medewerkernummer"='M04'; "${p}_functie"='Timmerman'; "${p}_certificaat"='VCA'; "${p}_certificaatstatus"='geldig'; "${p}_beschikbaarheid"='wk 28-36' }
  Ensure-Row $setMdw 'Klaas Mulder'       @{ "${p}_medewerkernummer"='M05'; "${p}_functie"='Metselaar'; "${p}_certificaat"='VCA'; "${p}_certificaatstatus"='geldig'; "${p}_beschikbaarheid"='niet beschikbaar (ander project)' }

  Write-Host "`nSeed Boeking ..." -ForegroundColor Cyan
  Ensure-Row $setBk 'Boeking M03 - De Beemster' @{ "${p}_medewerker"='M03 Sanne Willems'; "${p}_project"='De Beemster'; "${p}_weken"='24-34'; "${p}_rol"='Uitvoerder'; "${p}_status"='Bevestigd'; "${p}_toelichting"='' }
  Ensure-Row $setBk 'Boeking M01 - De Beemster' @{ "${p}_medewerker"='M01 Jan de Vries'; "${p}_project"='De Beemster'; "${p}_weken"='24-30'; "${p}_rol"='Ruwbouw'; "${p}_status"='Bevestigd'; "${p}_toelichting"='' }
  Ensure-Row $setBk 'Boeking M02 - De Beemster' @{ "${p}_medewerker"='M02 Piet Bakker'; "${p}_project"='De Beemster'; "${p}_weken"='25-30'; "${p}_rol"='Metselwerk'; "${p}_status"='Bevestigd'; "${p}_toelichting"='' }

  Write-Host "`nSeed Restpunt ..." -ForegroundColor Cyan
  Ensure-Row $setRp 'Kras op kozijn'            @{ "${p}_restpuntnummer"='R01'; "${p}_locatie"='App. 1.2 woonkamer'; "${p}_omschrijving"='Kras op kozijn'; "${p}_status"='Open'; "${p}_verantwoordelijke"='Timmerman' }
  Ensure-Row $setRp 'Schilderwerk onvolledig'   @{ "${p}_restpuntnummer"='R02'; "${p}_locatie"='Trappenhuis'; "${p}_omschrijving"='Schilderwerk onvolledig'; "${p}_status"='Open'; "${p}_verantwoordelijke"='Schilder' }
  Ensure-Row $setRp 'Kit ontbreekt bij douche'  @{ "${p}_restpuntnummer"='R03'; "${p}_locatie"='App. 2.1 badkamer'; "${p}_omschrijving"='Kit ontbreekt bij douche'; "${p}_status"='Open'; "${p}_verantwoordelijke"='Tegelzetter' }
  Ensure-Row $setRp 'Deurdranger stelt niet af' @{ "${p}_restpuntnummer"='R04'; "${p}_locatie"='Entree'; "${p}_omschrijving"='Deurdranger stelt niet goed af'; "${p}_status"='Hersteld'; "${p}_verantwoordelijke"='Installateur' }

  Write-Host "`nSeed Keuring ..." -ForegroundColor Cyan
  Ensure-Row $setKe 'Wapening fundering'                    @{ "${p}_resultaat"='Akkoord'; "${p}_datum"='2026-06-06' }
  Ensure-Row $setKe 'Woningscheidende wand (brand/geluid)' @{ "${p}_resultaat"='Nog uit te voeren'; "${p}_datum"='' }
  Ensure-Row $setKe 'Waterdichtheid gevel'                 @{ "${p}_resultaat"='Nog uit te voeren'; "${p}_datum"='' }

  Write-Host "`nSeed Wijzigingsverzoek ..." -ForegroundColor Cyan
  Ensure-Row $setWv 'WV-2026-001' @{ "${p}_omschrijving"='Woonkamerkozijnen uitvoeren als 2.100x2.400 mm i.p.v. 1.800x2.400 mm.'; "${p}_aard"='Meerwerk'; "${p}_status"='Beoordeeld'; "${p}_onderbouwing"='Groter kozijn-/glasoppervlak; toets latei/constructie en U-waarde/Rc; extra engineering.'; "${p}_bron"='bestek 30.40; tekening BK-301 rev. C'; "${p}_aangevraagddoor"='Opdrachtgever (Woonstichting Noord)' }
  Ensure-Row $setWv 'WV-2026-002' @{ "${p}_omschrijving"='Bergingen niet behangklaar opleveren; wanden in het zicht.'; "${p}_aard"='Minderwerk'; "${p}_status"='Beoordeeld'; "${p}_onderbouwing"='Reductie afwerkingsuren/materiaal bergingen t.o.v. bestek 70.10.'; "${p}_bron"='bestek 70.10'; "${p}_aangevraagddoor"='Opdrachtgever' }
  Ensure-Row $setWv 'WV-2026-003' @{ "${p}_omschrijving"='Tegelkleur badkamer antraciet.'; "${p}_aard"='Geen'; "${p}_status"='Beoordeeld'; "${p}_onderbouwing"='Bestek schrijft geen tegelkleur voor; keuze binnen stelpost -> geen verrekening.'; "${p}_bron"='bestek 70 (geen kleurbepaling)'; "${p}_aangevraagddoor"='Opdrachtgever' }
}

Write-Host "`nKlaar. Tabellen: $setTaak, $setMdw, $setBk, $setRp, $setKe, $setWv" -ForegroundColor Green
