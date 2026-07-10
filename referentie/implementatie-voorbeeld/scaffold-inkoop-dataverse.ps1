<#
.SYNOPSIS
  Zet de Dataverse-tabellen voor de Inkoop & Materialen-demo (Fase C) klaar:
  publisher `wvb`, de tabellen Materiaal / Offerte / Inkoopaanvraag, alle kolommen
  en fictieve seed-data (project "De Beemster").

.DESCRIPTION
  Gebruikt de Dataverse Web API. Idempotent: bestaande objecten worden overgeslagen,
  dus je kunt het script veilig opnieuw draaien.

  Auth: het script haalt een access token via de Azure CLI
  (`az account get-access-token`). Log daarom eerst in op de TENANT van je
  Dataverse-omgeving:

      az login --tenant <jouw-tenant>.onmicrosoft.com --allow-no-subscriptions

.PARAMETER OrgUrl
  De org-URL van je Dataverse-omgeving, bv. https://contoso.crm.dynamics.com/

.PARAMETER Prefix
  Aanpasbare aanpassings-prefix (default: wvb).

.PARAMETER SkipSeed
  Sla het inladen van seed-data over (alleen schema aanmaken).

.EXAMPLE
  ./scaffold-inkoop-dataverse.ps1 -OrgUrl https://contoso.crm.dynamics.com/

.NOTES
  Data is FICTIEF (project "De Beemster"). Gebruik een demo-/test-omgeving.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)] [string] $OrgUrl,
  [string] $Prefix = 'wvb',
  [switch] $SkipSeed
)

$ErrorActionPreference = 'Stop'
$OrgUrl = $OrgUrl.TrimEnd('/')
$Api    = "$OrgUrl/api/data/v9.2"
$p      = $Prefix.ToLower()

# --- Token via Azure CLI -----------------------------------------------------
Write-Host "Token ophalen voor $OrgUrl ..." -ForegroundColor Cyan
$token = az account get-access-token --resource $OrgUrl --query accessToken -o tsv 2>$null
if (-not $token) {
  throw "Geen token. Log eerst in op de juiste tenant: az login --tenant <jouw-tenant>.onmicrosoft.com --allow-no-subscriptions"
}

$H = @{
  Authorization    = "Bearer $token"
  'OData-MaxVersion' = '4.0'
  'OData-Version'    = '4.0'
  Accept           = 'application/json'
  'Content-Type'   = 'application/json; charset=utf-8'
  Prefer           = 'return=representation'
}

function Invoke-Dv {
  param([string]$Method, [string]$Path, $Body)
  $uri = if ($Path -match '^https?://') { $Path } else { "$Api/$Path" }
  $json = $null
  if ($null -ne $Body) { $json = ($Body | ConvertTo-Json -Depth 20) }
  try {
    if ($json) {
      return Invoke-RestMethod -Method $Method -Uri $uri -Headers $H -Body ([System.Text.Encoding]::UTF8.GetBytes($json))
    } else {
      return Invoke-RestMethod -Method $Method -Uri $uri -Headers $H
    }
  } catch {
    $msg = $_.ErrorDetails.Message
    if (-not $msg) { $msg = $_.Exception.Message }
    throw "$Method $uri`n$msg"
  }
}

function Test-Dv {
  param([string]$Path)
  try { Invoke-Dv -Method Get -Path $Path | Out-Null; return $true } catch { return $false }
}

# --- Basetaal ophalen (voor labels) -----------------------------------------
$org  = Invoke-Dv -Method Get -Path 'organizations?$select=languagecode'
$Lcid = [int]$org.value[0].languagecode
Write-Host "Basetaal (LCID): $Lcid"

function New-Label($text) {
  @{
    '@odata.type'   = 'Microsoft.Dynamics.CRM.Label'
    LocalizedLabels = @(@{ '@odata.type' = 'Microsoft.Dynamics.CRM.LocalizedLabel'; Label = $text; LanguageCode = $Lcid })
  }
}

# --- Publisher ---------------------------------------------------------------
Write-Host "`nPublisher '$p' controleren ..." -ForegroundColor Cyan
$pub = Invoke-Dv -Method Get -Path "publishers?`$select=publisherid,customizationprefix&`$filter=customizationprefix eq '$p'"
if ($pub.value.Count -eq 0) {
  Write-Host "  + publisher aanmaken"
  Invoke-Dv -Method Post -Path 'publishers' -Body @{
    uniquename                    = "${p}publisher"
    friendlyname                  = "Werkvoorbereider ($p)"
    customizationprefix           = $p
    customizationoptionvalueprefix = 32100
  } | Out-Null
} else {
  Write-Host "  = publisher bestaat"
}

# --- Helpers: tabellen & kolommen -------------------------------------------
function Ensure-Table {
  param([string]$Name, [string]$Singular, [string]$Plural, [string]$PrimaryLabel = 'Naam')
  $logical = $Name.ToLower()
  if (Test-Dv "EntityDefinitions(LogicalName='$logical')?`$select=LogicalName") {
    Write-Host "  = tabel $Name bestaat"
  } else {
    Write-Host "  + tabel $Name"
    $body = @{
      '@odata.type'         = 'Microsoft.Dynamics.CRM.EntityMetadata'
      SchemaName            = $Name
      DisplayName           = (New-Label $Singular)
      DisplayCollectionName = (New-Label $Plural)
      OwnershipType         = 'UserOwned'
      HasActivities         = $false
      HasNotes              = $false
      IsActivity            = $false
      Attributes            = @(
        @{
          '@odata.type' = 'Microsoft.Dynamics.CRM.StringAttributeMetadata'
          SchemaName    = "${p}_naam"
          IsPrimaryName = $true
          MaxLength     = 200
          FormatName    = @{ Value = 'Text' }
          RequiredLevel = @{ Value = 'None' }
          DisplayName   = (New-Label $PrimaryLabel)
        }
      )
    }
    Invoke-Dv -Method Post -Path 'EntityDefinitions' -Body $body | Out-Null
  }
  $e = Invoke-Dv -Method Get -Path "EntityDefinitions(LogicalName='$logical')?`$select=EntitySetName"
  return $e.EntitySetName
}

function Ensure-Attr {
  param([string]$Table, [string]$Schema, [hashtable]$Payload)
  $tl = $Table.ToLower(); $al = $Schema.ToLower()
  if (Test-Dv "EntityDefinitions(LogicalName='$tl')/Attributes(LogicalName='$al')?`$select=LogicalName") {
    Write-Host "    = $Schema"
    return
  }
  Write-Host "    + $Schema"
  $Payload.SchemaName = $Schema
  Invoke-Dv -Method Post -Path "EntityDefinitions(LogicalName='$tl')/Attributes" -Body $Payload | Out-Null
}

function Ensure-Str  { param($Table,$Schema,$Label,$Max=200)
  Ensure-Attr $Table $Schema @{ '@odata.type'='Microsoft.Dynamics.CRM.StringAttributeMetadata'; MaxLength=$Max; FormatName=@{Value='Text'}; RequiredLevel=@{Value='None'}; DisplayName=(New-Label $Label) } }
function Ensure-Dec  { param($Table,$Schema,$Label,$Precision=2)
  Ensure-Attr $Table $Schema @{ '@odata.type'='Microsoft.Dynamics.CRM.DecimalAttributeMetadata'; MinValue=-1000000000; MaxValue=1000000000; Precision=$Precision; RequiredLevel=@{Value='None'}; DisplayName=(New-Label $Label) } }
function Ensure-Int  { param($Table,$Schema,$Label)
  Ensure-Attr $Table $Schema @{ '@odata.type'='Microsoft.Dynamics.CRM.IntegerAttributeMetadata'; Format='None'; MinValue=-2147483648; MaxValue=2147483647; RequiredLevel=@{Value='None'}; DisplayName=(New-Label $Label) } }
function Ensure-Memo { param($Table,$Schema,$Label,$Max=2000)
  Ensure-Attr $Table $Schema @{ '@odata.type'='Microsoft.Dynamics.CRM.MemoAttributeMetadata'; MaxLength=$Max; Format='Text'; RequiredLevel=@{Value='None'}; DisplayName=(New-Label $Label) } }

# --- Tabellen aanmaken -------------------------------------------------------
Write-Host "`nTabellen ..." -ForegroundColor Cyan
$setMat = Ensure-Table "${p}_materiaal"       'Materiaal'      'Materialen'       'Naam'
$setOff = Ensure-Table "${p}_offerte"         'Offerte'        'Offertes'         'Offertenummer'
$setInk = Ensure-Table "${p}_inkoopaanvraag"  'Inkoopaanvraag' 'Inkoopaanvragen'  'Naam'

Write-Host "`nKolommen Materiaal ..." -ForegroundColor Cyan
Ensure-Str  "${p}_materiaal" "${p}_artikelnummer"  'Artikelnummer'
Ensure-Str  "${p}_materiaal" "${p}_eenheid"        'Eenheid'
Ensure-Dec  "${p}_materiaal" "${p}_voorraad"       'Voorraad'
Ensure-Str  "${p}_materiaal" "${p}_magazijn"       'Magazijn'
Ensure-Int  "${p}_materiaal" "${p}_levertijdweken" 'Levertijd (weken)'
Ensure-Dec  "${p}_materiaal" "${p}_nodig"          'Behoefte project'

Write-Host "`nKolommen Offerte ..." -ForegroundColor Cyan
Ensure-Str  "${p}_offerte" "${p}_materiaalartikel" 'Materiaal/artikel'
Ensure-Str  "${p}_offerte" "${p}_leverancier"      'Leverancier'
Ensure-Str  "${p}_offerte" "${p}_post"             'Post'
Ensure-Dec  "${p}_offerte" "${p}_bedrag"           'Bedrag (EUR, fictief)'
Ensure-Int  "${p}_offerte" "${p}_levertijdweken"   'Levertijd (weken)'
Ensure-Str  "${p}_offerte" "${p}_raamcontract"     'Raamcontract'
Ensure-Str  "${p}_offerte" "${p}_geldigtot"        'Geldig tot'

Write-Host "`nKolommen Inkoopaanvraag ..." -ForegroundColor Cyan
Ensure-Str  "${p}_inkoopaanvraag" "${p}_project"          'Project'
Ensure-Str  "${p}_inkoopaanvraag" "${p}_materiaalartikel" 'Materiaal/artikel'
Ensure-Dec  "${p}_inkoopaanvraag" "${p}_aantal"           'Aantal'
Ensure-Str  "${p}_inkoopaanvraag" "${p}_eenheid"          'Eenheid'
Ensure-Str  "${p}_inkoopaanvraag" "${p}_status"           'Status'
Ensure-Memo "${p}_inkoopaanvraag" "${p}_toelichting"      'Toelichting'
Ensure-Str  "${p}_inkoopaanvraag" "${p}_aangevraagddoor"  'Aangevraagd door'

# --- Publiceren --------------------------------------------------------------
Write-Host "`nPublish all customizations ..." -ForegroundColor Cyan
try { Invoke-Dv -Method Post -Path 'PublishAllXml' | Out-Null; Write-Host "  ok" } catch { Write-Host "  (publish overgeslagen: $_)" -ForegroundColor Yellow }

# --- Seed --------------------------------------------------------------------
function Ensure-Row {
  param([string]$Set, [string]$Naam, [hashtable]$Fields)
  $exists = Invoke-Dv -Method Get -Path "$Set`?`$select=${p}_naam&`$filter=${p}_naam eq '$($Naam.Replace("'","''"))'"
  if ($exists.value.Count -gt 0) { Write-Host "    = $Naam"; return }
  Write-Host "    + $Naam"
  $Fields["${p}_naam"] = $Naam
  Invoke-Dv -Method Post -Path $Set -Body $Fields | Out-Null
}

if ($SkipSeed) { Write-Host "`nSeed overgeslagen (-SkipSeed)." -ForegroundColor Yellow }
else {
  Write-Host "`nSeed Materiaal ..." -ForegroundColor Cyan
  Ensure-Row $setMat 'Baksteen roodbruin genuanceerd' @{ "${p}_artikelnummer"='ART-BAK-001'; "${p}_eenheid"='1000 st'; "${p}_voorraad"=24000; "${p}_magazijn"='Centraal'; "${p}_levertijdweken"=2; "${p}_nodig"=60000 }
  Ensure-Row $setMat 'Metselmortel'                    @{ "${p}_artikelnummer"='ART-MOR-002'; "${p}_eenheid"='zak';     "${p}_voorraad"=800;   "${p}_magazijn"='Centraal'; "${p}_levertijdweken"=1; "${p}_nodig"=650 }
  Ensure-Row $setMat 'HR++ beglazing'                  @{ "${p}_artikelnummer"='ART-GLA-003'; "${p}_eenheid"='m2';      "${p}_voorraad"=0;     "${p}_magazijn"='-';        "${p}_levertijdweken"=4; "${p}_nodig"=210 }
  Ensure-Row $setMat 'Hardhouten kozijn 1.800x2.400'   @{ "${p}_artikelnummer"='ART-KOZ-004'; "${p}_eenheid"='st';      "${p}_voorraad"=6;     "${p}_magazijn"='Centraal'; "${p}_levertijdweken"=5; "${p}_nodig"=12 }
  Ensure-Row $setMat 'Beton C30/37'                    @{ "${p}_artikelnummer"='ART-BET-005'; "${p}_eenheid"='m3';      "${p}_voorraad"=0;     "${p}_magazijn"='-';        "${p}_levertijdweken"=0; "${p}_nodig"=140 }
  Ensure-Row $setMat 'Wapeningsstaal'                  @{ "${p}_artikelnummer"='ART-WAP-006'; "${p}_eenheid"='ton';     "${p}_voorraad"=3;     "${p}_magazijn"='Centraal'; "${p}_levertijdweken"=1; "${p}_nodig"=2.4 }

  Write-Host "`nSeed Offerte ..." -ForegroundColor Cyan
  Ensure-Row $setOff 'O-101' @{ "${p}_materiaalartikel"='ART-KOZ-004 Hardhouten kozijn'; "${p}_leverancier"='L01 Kozijnfabriek Noord'; "${p}_post"='12 kozijnen 1.800x2.400'; "${p}_bedrag"=18600; "${p}_levertijdweken"=5; "${p}_raamcontract"='Ja';  "${p}_geldigtot"='2026-07-31' }
  Ensure-Row $setOff 'O-102' @{ "${p}_materiaalartikel"='ART-KOZ-004 Hardhouten kozijn'; "${p}_leverancier"='L02 HoutTech Kozijnen';   "${p}_post"='12 kozijnen 1.800x2.400'; "${p}_bedrag"=17200; "${p}_levertijdweken"=8; "${p}_raamcontract"='Nee'; "${p}_geldigtot"='2026-07-15' }
  Ensure-Row $setOff 'O-201' @{ "${p}_materiaalartikel"='ART-BAK-001 Baksteen';          "${p}_leverancier"='L03 Metselbedrijf Zuid';   "${p}_post"='Metselwerk gevel';        "${p}_bedrag"=42000; "${p}_levertijdweken"=0; "${p}_raamcontract"='Nee'; "${p}_geldigtot"='2026-08-01' }

  Write-Host "`nSeed Inkoopaanvraag (verificatierij) ..." -ForegroundColor Cyan
  Ensure-Row $setInk 'IA-2026-001' @{ "${p}_project"='De Beemster'; "${p}_materiaalartikel"='ART-KOZ-004 Hardhouten kozijn'; "${p}_aantal"=12; "${p}_eenheid"='st'; "${p}_status"='Concept'; "${p}_toelichting"='Verificatierij door scaffold-script.'; "${p}_aangevraagddoor"='scaffold' }
}

Write-Host "`nKlaar. Tabellen: $setMat, $setOff, $setInk" -ForegroundColor Green
