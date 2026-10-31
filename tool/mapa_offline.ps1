# AURORA - Mapa SIN INTERNET de verdad (Protomaps / OpenStreetMap, formato .pmtiles)
# Baja solo la zona que eliges (no el planeta) y la pasa al teléfono por cable (ADB).
#
#   cd E:\APOCA
#   powershell -ExecutionPolicy Bypass -File .\tool\mapa_offline.ps1                       # Colombia, zoom 14
#   powershell -ExecutionPolicy Bypass -File .\tool\mapa_offline.ps1 -Zona bogota -MaxZoom 15
#   powershell -ExecutionPolicy Bypass -File .\tool\mapa_offline.ps1 -Bbox "-75.7,6.1,-75.4,6.4" -Zona mizona
#
# Requisitos: internet en el PC, teléfono con "Depuración USB" activada y la app abierta una vez.
# Datos © colaboradores de OpenStreetMap (licencia ODbL), mapa base de Protomaps.
param(
    [string]$Zona = "colombia",
    [int]$MaxZoom = 14,
    [string]$Bbox = "",
    [string]$Fuente = "",
    [switch]$SinTelefono
)
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$root = Split-Path $PSScriptRoot -Parent
$dir = Join-Path $root "mapas"
New-Item -ItemType Directory -Force $dir | Out-Null

# Zonas listas (oeste, sur, este, norte)
$zonas = @{
    colombia     = "-79.1,-4.3,-66.8,12.6"
    bogota       = "-74.35,4.45,-73.95,4.85"
    medellin     = "-75.75,6.05,-75.35,6.45"
    cali         = "-76.65,3.30,-76.40,3.55"
    barranquilla = "-74.95,10.85,-74.70,11.10"
    cartagena    = "-75.60,10.30,-75.40,10.50"
    bucaramanga  = "-73.20,7.00,-73.00,7.20"
    pereira      = "-75.80,4.75,-75.60,4.90"
    venezuela    = "-73.5,0.6,-59.7,12.3"
    ecuador      = "-81.1,-5.1,-75.1,1.5"
    peru         = "-81.4,-18.4,-68.6,-0.0"
    mexico       = "-118.5,14.5,-86.7,32.8"
    espana       = "-9.4,35.9,3.4,43.9"
    portugal     = "-9.6,36.9,-6.1,42.2"
    brasil       = "-74.0,-33.8,-34.7,5.3"
}
if (-not $Bbox) {
    if (-not $zonas.ContainsKey($Zona)) {
        Write-Host "Zona desconocida. Usa una de: $($zonas.Keys -join ', ') o pasa -Bbox 'oeste,sur,este,norte'" -ForegroundColor Red
        exit 1
    }
    $Bbox = $zonas[$Zona]
}

# 1. Programa pmtiles (go-pmtiles) para recortar la zona
$exe = Join-Path $dir "pmtiles.exe"
if (-not (Test-Path $exe)) {
    Write-Host "Descargando la herramienta pmtiles..." -ForegroundColor Cyan
    $rel = Invoke-RestMethod "https://api.github.com/repos/protomaps/go-pmtiles/releases/latest" -Headers @{ "User-Agent" = "AURORA" }
    $asset = $rel.assets | Where-Object { $_.name -like "*Windows_x86_64.zip" } | Select-Object -First 1
    if (-not $asset) { throw "No se encontró pmtiles para Windows en GitHub." }
    $zip = Join-Path $dir "pmtiles.zip"
    Invoke-WebRequest $asset.browser_download_url -OutFile $zip
    Expand-Archive $zip -DestinationPath (Join-Path $dir "pmtiles_bin") -Force
    Get-ChildItem (Join-Path $dir "pmtiles_bin") -Recurse -Filter "pmtiles.exe" | Select-Object -First 1 | Copy-Item -Destination $exe
    Remove-Item $zip
}

# 2. Mapa base del mundo más reciente (se lee a distancia: solo baja tu zona)
if (-not $Fuente) {
    Write-Host "Buscando el mapa base más reciente de Protomaps..." -ForegroundColor Cyan
    try {
        $builds = Invoke-RestMethod "https://build-metadata.protomaps.dev/builds.json"
        $last = $builds | Sort-Object { $_.key } | Select-Object -Last 1
        if ($last.key) { $Fuente = "https://build.protomaps.com/$($last.key)" }
    } catch {}
    if (-not $Fuente) {
        for ($i = 0; $i -lt 14 -and -not $Fuente; $i++) {
            $u = "https://build.protomaps.com/{0}.pmtiles" -f (Get-Date).AddDays(-$i).ToString("yyyyMMdd")
            try {
                $r = Invoke-WebRequest $u -Method Head -UseBasicParsing
                if ($r.StatusCode -eq 200) { $Fuente = $u }
            } catch {}
        }
    }
    if (-not $Fuente) {
        Write-Host "No se encontró el mapa base. Abre https://maps.protomaps.com/builds , copia el enlace del .pmtiles más nuevo y ejecuta:" -ForegroundColor Red
        Write-Host "  .\tool\mapa_offline.ps1 -Fuente <enlace>" -ForegroundColor Yellow
        exit 1
    }
}
Write-Host "Fuente: $Fuente"

$ErrorActionPreference = "Continue"
# 3. Recortar
$out = Join-Path $dir "$Zona.pmtiles"
Write-Host "Recortando $Zona (zoom 0-$MaxZoom). Un país puede tardar varios minutos y pesar cientos de MB..." -ForegroundColor Cyan
& $exe extract $Fuente $out "--bbox=$Bbox" "--maxzoom=$MaxZoom"
if ($LASTEXITCODE -ne 0 -or -not (Test-Path $out)) { throw "Falló el recorte del mapa." }
$mb = [math]::Round((Get-Item $out).Length / 1MB)
Write-Host "Listo: $out ($mb MB)" -ForegroundColor Green
if ($SinTelefono) { exit 0 }

# 4. Pasar al teléfono por cable
$adb = (Get-Command adb -ErrorAction SilentlyContinue).Source
if (-not $adb) {
    $cand = Join-Path $env:LOCALAPPDATA "Android\Sdk\platform-tools\adb.exe"
    if (Test-Path $cand) { $adb = $cand }
}
if (-not $adb) {
    Write-Host "No encontré adb. Copia $out al teléfono (carpeta Descargas) y en la app: Mapa > Mapa sin internet > Importar." -ForegroundColor Yellow
    exit 0
}
& $adb devices
$dest = "/sdcard/Android/data/com.panlabstudios.apoca/files"
Write-Host "Copiando al teléfono ($mb MB)..." -ForegroundColor Cyan
try { & $adb shell mkdir -p $dest 2>&1 | Out-Null } catch {}
& $adb push $out "$dest/$Zona.pmtiles"
if ($LASTEXITCODE -ne 0) {
    Write-Host "No se pudo copiar a la carpeta de la app; lo dejo en Descargas." -ForegroundColor Yellow
    & $adb push $out "/sdcard/Download/$Zona.pmtiles"
    Write-Host "En la app: Mapa > Mapa sin internet > Importar .pmtiles > Descargas > $Zona.pmtiles" -ForegroundColor Green
} else {
    Write-Host "Listo. En la app: Mapa > Mapa sin internet > Buscar." -ForegroundColor Green
}
