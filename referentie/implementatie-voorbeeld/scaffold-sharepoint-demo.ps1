<#
.SYNOPSIS
  Zet de SharePoint-demostructuur klaar: een projectmap met de 7-domein-taxonomie en
  (optioneel) het fictieve bestek/tekeninglijst/normenregister als documenten, zodat de
  Bestek-agent er kennis op kan gronden.

.DESCRIPTION
  Gebruikt Microsoft Graph (delegated, via Azure CLI). Idempotent: bestaande mappen
  worden hergebruikt, documenten worden overschreven.

  Auth: log met Azure CLI in op de TENANT van je SharePoint:
      az login --tenant <jouw-tenant>.onmicrosoft.com --allow-no-subscriptions

.PARAMETER SiteUrl
  URL van de SharePoint-site of documentbibliotheek, bv.
  https://contoso.sharepoint.com/sites/WerkvoorbereiderDemo

.PARAMETER Project
  Projectnaam (mapnaam onder /Projecten/). Default: "De Beemster".

.PARAMETER SkipDocs
  Sla het uploaden van de fictieve documenten over (alleen mappen aanmaken).

.EXAMPLE
  ./scaffold-sharepoint-demo.ps1 -SiteUrl https://contoso.sharepoint.com/sites/WerkvoorbereiderDemo

.NOTES
  Data is FICTIEF (project "De Beemster"). Gebruik een demo-/test-site.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)] [string] $SiteUrl,
  [string] $Project = 'De Beemster',
  [switch] $SkipDocs
)

$ErrorActionPreference = 'Stop'
$g = 'https://graph.microsoft.com/v1.0'

# --- Token via Azure CLI -----------------------------------------------------
Write-Host 'Graph-token ophalen ...' -ForegroundColor Cyan
$token = az account get-access-token --resource https://graph.microsoft.com --query accessToken -o tsv 2>$null
if (-not $token) { throw 'Geen token. Log eerst in: az login --tenant <jouw-tenant>.onmicrosoft.com --allow-no-subscriptions' }
$H  = @{ Authorization = "Bearer $token"; 'Content-Type' = 'application/json' }
$HB = @{ Authorization = "Bearer $token" }

# --- Site + drive resolven ---------------------------------------------------
$u = [uri]$SiteUrl
$segs = $u.AbsolutePath.Trim('/').Split('/')
$si = [array]::IndexOf($segs, 'sites')
if ($si -lt 0) { throw "Kon /sites/<naam> niet vinden in de URL. Geef de site-URL, bv. https://host/sites/NAAM" }
$sitePath = '/' + (($segs[$si..($si + 1)]) -join '/')
Write-Host "Site opzoeken: $($u.Host)$sitePath"
$site = Invoke-RestMethod -Uri "$g/sites/$($u.Host):${sitePath}" -Headers $H
$drive = Invoke-RestMethod -Uri "$g/sites/$($site.id)/drive?`$select=id,name" -Headers $H
Write-Host "  site : $($site.displayName)"
Write-Host "  drive: $($drive.name) ($($drive.id))"
$driveId = $drive.id

# --- Helpers -----------------------------------------------------------------
function Ensure-Folder([string]$ParentId, [string]$Name) {
  $enc = [uri]::EscapeDataString($Name)
  try {
    $body = @{ name = $Name; folder = @{}; '@microsoft.graph.conflictBehavior' = 'fail' } | ConvertTo-Json
    $f = Invoke-RestMethod -Method Post -Uri "$g/drives/$driveId/items/$ParentId/children" -Headers $H -Body $body
    Write-Host "    + $Name"
    return $f.id
  } catch {
    $f = Invoke-RestMethod -Uri "$g/drives/$driveId/items/${ParentId}:/$enc" -Headers $H
    Write-Host "    = $Name"
    return $f.id
  }
}

function Upload-Text([string]$ParentId, [string]$FileName, [string]$Text) {
  $enc = [uri]::EscapeDataString($FileName)
  $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)
  $r = Invoke-RestMethod -Method Put -Uri "$g/drives/$driveId/items/${ParentId}:/${enc}:/content" -Headers $HB -ContentType 'text/plain; charset=utf-8' -Body $bytes
  Write-Host "    ^ $FileName"
  return $r.id
}

# --- Mappen ------------------------------------------------------------------
Write-Host "`nProjectmap-structuur ..." -ForegroundColor Cyan
$rootId = Ensure-Folder 'root' 'Projecten'
$projId = Ensure-Folder $rootId $Project

$folders = @(
  '01 Contract & Voorwaarden',
  '02 Bestek & Tekeningen',
  '03 Vergunningen & Compliance',
  '04 Inkoop & Offertes',
  '05 Planning & Capaciteit',
  '06 Meer- en minderwerk',
  '07 Oplevering & Kwaliteit'
)
$ids = @{}
foreach ($f in $folders) { $ids[$f] = Ensure-Folder $projId $f }

# --- Documenten (fictief) ----------------------------------------------------
if ($SkipDocs) {
  Write-Host "`nDocumenten overgeslagen (-SkipDocs)." -ForegroundColor Yellow
} else {
  $vd = Join-Path $PSScriptRoot '..\..\voorbeelddata'
  Write-Host "`nFictieve documenten uploaden (uit voorbeelddata) ..." -ForegroundColor Cyan
  $map = @(
    @{ src = 'bestek-fictief-project.md'; dst = '02 Bestek & Tekeningen'; name = 'Bestek De Beemster.txt' },
    @{ src = 'tekeninglijst.md';          dst = '02 Bestek & Tekeningen'; name = 'Tekeninglijst De Beemster.txt' },
    @{ src = 'normenregister.md';         dst = '03 Vergunningen & Compliance'; name = 'Normenregister.txt' }
  )
  foreach ($d in $map) {
    $p = Join-Path $vd $d.src
    if (Test-Path $p) { Upload-Text $ids[$d.dst] $d.name (Get-Content $p -Raw) }
    else { Write-Host "    (overgeslagen, niet gevonden: $($d.src))" -ForegroundColor Yellow }
  }
  Write-Host "`n> Tip: voor de mooiste kennis-indexering vervang je de .txt door PDF/Word." -ForegroundColor DarkGray
}

Write-Host "`nKlaar. Koppel als kennis (Bestek-agent) de map:" -ForegroundColor Green
Write-Host "  $SiteUrl  ->  Projecten/$Project/02 Bestek & Tekeningen" -ForegroundColor Green
