# APOCA - descarga las fotos de la guia visual (una sola vez, necesita internet)
# Fuente: Wikipedia / Wikimedia Commons (solo imagenes con licencia libre).
#   cd E:\APOCA
#   powershell -ExecutionPolicy Bypass -File .\tool\imagenes.ps1
# Puedes ejecutarlo varias veces: solo baja las que falten.
# Wikimedia limita las peticiones: el script va despacio y reintenta solo.

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-Location (Split-Path $PSScriptRoot -Parent)

$UA = "APOCA/1.3 (https://github.com/skullkirim; PanLabStudios educational offline app) PowerShell"
$size = 500          # ancho estandar de miniatura de Wikimedia
$dir = "assets\img"
New-Item -ItemType Directory -Force $dir | Out-Null
$creditsPath = Join-Path (Resolve-Path $dir).Path "credits.json"

function Invoke-Wiki($url, $outFile) {
    for ($try = 1; $try -le 6; $try++) {
        try {
            if ($outFile) {
                Invoke-WebRequest $url -OutFile $outFile -UserAgent $UA -TimeoutSec 60 | Out-Null
                return $true
            }
            return Invoke-RestMethod $url -UserAgent $UA -TimeoutSec 60
        } catch {
            $code = 0
            if ($_.Exception.Response) { $code = [int]$_.Exception.Response.StatusCode }
            if ($code -eq 429 -or $code -ge 500 -or $code -eq 0) {
                $wait = 5 * $try * $try
                Write-Host "   (Wikimedia pide esperar: $wait s)" -ForegroundColor DarkGray
                Start-Sleep -Seconds $wait
            } else { throw }
        }
    }
    throw "demasiados intentos"
}

# Creditos existentes
$credits = @{}
if (Test-Path $creditsPath) {
    try {
        $old = Get-Content $creditsPath -Raw -Encoding UTF8 | ConvertFrom-Json
        foreach ($c in @($old)) { if ($c.id) { $credits[$c.id] = $c } }
    } catch {}
}

$rows = @(Import-Csv "tool\especies.csv" -Delimiter ';' -Encoding UTF8)
$todo = @($rows | Where-Object { -not (Test-Path (Join-Path $dir "$($_.id).jpg")) })
Write-Host "Especies sin foto: $($todo.Count) de $($rows.Count)"
if ($todo.Count -eq 0) { Write-Host "Todo listo." -ForegroundColor Green; exit }

# ---------------------------------------------------------------------
# 1) Buscar la imagen principal (libre) de cada articulo, de 20 en 20
# ---------------------------------------------------------------------
$found = @{}   # id -> @{ thumb; file }
foreach ($lang in @('es', 'en')) {
    $pending = @($todo | Where-Object { -not $found.ContainsKey($_.id) })
    for ($i = 0; $i -lt $pending.Count; $i += 20) {
        $batch = @($pending[$i..([Math]::Min($i + 19, $pending.Count - 1))])
        $titles = ($batch | ForEach-Object { $_.wiki }) -join '|'
        $url = "https://$lang.wikipedia.org/w/api.php?action=query&format=json&redirects=1" +
               "&prop=pageimages&piprop=thumbnail|name&pilicense=free&pithumbsize=$size&pilimit=50" +
               "&titles=" + [uri]::EscapeDataString($titles)
        Write-Host "Buscando en $lang.wikipedia ($($batch.Count) especies)..."
        $r = Invoke-Wiki $url $null
        # Mapa titulo original -> titulo final (normalizado y redirecciones)
        $map = @{}
        foreach ($b in $batch) { $map[$b.wiki] = $b.wiki }
        foreach ($n in @($r.query.normalized)) { if ($n) { foreach ($k in @($map.Keys)) { if ($map[$k] -eq $n.from) { $map[$k] = $n.to } } } }
        foreach ($n in @($r.query.redirects)) { if ($n) { foreach ($k in @($map.Keys)) { if ($map[$k] -eq $n.from) { $map[$k] = $n.to } } } }
        $pages = @{}
        foreach ($p in $r.query.pages.PSObject.Properties.Value) { $pages[$p.title] = $p }
        foreach ($b in $batch) {
            $p = $pages[$map[$b.wiki]]
            if ($p -and $p.thumbnail -and $p.pageimage) {
                $found[$b.id] = @{ thumb = $p.thumbnail.source; file = $p.pageimage }
            }
        }
        Start-Sleep -Seconds 2
    }
}
Write-Host "Con imagen libre encontrada: $($found.Count)"

# ---------------------------------------------------------------------
# 2) Autor y licencia desde Commons (de 20 en 20)
# ---------------------------------------------------------------------
$meta = @{}  # file -> @{author; license; url}
$files = @($found.Values | ForEach-Object { $_.file } | Select-Object -Unique)
for ($i = 0; $i -lt $files.Count; $i += 20) {
    $batch = @($files[$i..([Math]::Min($i + 19, $files.Count - 1))])
    $titles = ($batch | ForEach-Object { "File:$_" }) -join '|'
    $url = "https://commons.wikimedia.org/w/api.php?action=query&format=json&prop=imageinfo" +
           "&iiprop=extmetadata|url&iiextmetadatafilter=Artist|LicenseShortName&titles=" + [uri]::EscapeDataString($titles)
    try {
        $r = Invoke-Wiki $url $null
        foreach ($p in $r.query.pages.PSObject.Properties.Value) {
            if (-not $p.imageinfo) { continue }
            $ii = $p.imageinfo[0]
            $artist = ""
            if ($ii.extmetadata.Artist) { $artist = ($ii.extmetadata.Artist.value -replace '<[^>]+>', '').Trim() }
            $lic = ""
            if ($ii.extmetadata.LicenseShortName) { $lic = $ii.extmetadata.LicenseShortName.value }
            $name = ($p.title -replace '^(File|Archivo):', '') -replace ' ', '_'
            $meta[$name] = @{ author = $artist; license = $lic; url = $ii.descriptionurl }
        }
    } catch { Write-Warning "No se pudieron leer licencias: $($_.Exception.Message)" }
    Start-Sleep -Seconds 2
}

# ---------------------------------------------------------------------
# 3) Descargar las miniaturas, despacio
# ---------------------------------------------------------------------
$ok = 0; $fail = @()
foreach ($row in $todo) {
    if (-not $found.ContainsKey($row.id)) { $fail += $row.id; continue }
    $f = $found[$row.id]
    $out = Join-Path $dir "$($row.id).jpg"
    Write-Host "-> $($row.id)"
    try {
        Invoke-Wiki $f.thumb $out | Out-Null
        $m = $meta[($f.file -replace ' ', '_')]
        $author = ""
        $lic = "Licencia libre (Wikimedia Commons)"
        $src = "https://commons.wikimedia.org/wiki/File:" + $f.file
        if ($m) { $author = $m.author; $lic = $m.license; $src = $m.url }
        $credits[$row.id] = [pscustomobject]@{
            id = $row.id; file = $f.file; author = $author; license = $lic; url = $src
        }
        $ok++
    } catch {
        Write-Warning "$($row.id): $($_.Exception.Message)"
        if (Test-Path $out) { Remove-Item $out }
        $fail += $row.id
    }
    Start-Sleep -Milliseconds 1500
}

# Guardar creditos (UTF-8 sin BOM)
$json = ConvertTo-Json @($credits.Values | Sort-Object id) -Depth 3
[IO.File]::WriteAllText($creditsPath, $json, (New-Object Text.UTF8Encoding $false))

$mb = (Get-ChildItem $dir -Filter *.jpg | Measure-Object Length -Sum).Sum / 1MB
Write-Host ""
Write-Host ("Descargadas ahora: {0}   Sin foto: {1}   Peso total: {2:N1} MB" -f $ok, $fail.Count, $mb) -ForegroundColor Green
if ($fail.Count) {
    Write-Host ("Sin foto (se vera un icono): " + ($fail -join ', ')) -ForegroundColor Yellow
    Write-Host "Puedes volver a ejecutar el script mas tarde para intentar las que faltan."
}
Write-Host "Luego ejecuta: flutter run --release"
