# AURORA - Tomar capturas del teléfono para la portada de GitHub (docs/screenshots) y ponerlas en el README.
#   Conecta el teléfono por cable (Depuración USB), abre la app y ejecuta:
#   powershell -ExecutionPolicy Bypass -File .\tool\capturas.ps1
$ErrorActionPreference = "Continue"
Set-Location (Split-Path $PSScriptRoot -Parent)
$adb = (Get-Command adb -ErrorAction SilentlyContinue).Source
if (-not $adb) { $adb = Join-Path $env:LOCALAPPDATA "Android\Sdk\platform-tools\adb.exe" }
if (-not (Test-Path $adb)) { Write-Host "No encontré adb." -ForegroundColor Red; exit 1 }
$dir = "docs\screenshots"
New-Item -ItemType Directory -Force $dir | Out-Null

$pantallas = @(
    @("01_inicio", "Inicio"),
    @("02_emergencia", "una guía de EMERGENCIA paso a paso"),
    @("03_biblioteca", "Biblioteca (temas)"),
    @("04_especies", "Plantas y animales"),
    @("05_mapa", "Mapa (ojalá con el mapa sin internet)"),
    @("06_herramientas", "Herramientas"),
    @("07_morse", "Código Morse"),
    @("08_comunidad", "Modo comunidad"),
    @("09_recetas", "Recetas"),
    @("10_alarmas", "Alarmas")
)
$hechas = @()
foreach ($p in $pantallas) {
    $r = Read-Host "Abre en el teléfono: $($p[1]). Enter = capturar · s = saltar · q = terminar"
    if ($r -eq "q") { break }
    if ($r -eq "s") { continue }
    & $adb shell screencap -p /sdcard/aurora_cap.png
    & $adb pull /sdcard/aurora_cap.png "$dir\$($p[0]).png" | Out-Null
    & $adb shell rm /sdcard/aurora_cap.png
    if (Test-Path "$dir\$($p[0]).png") { $hechas += $p; Write-Host "  ✓ $($p[0]).png" -ForegroundColor Green }
}

# Galería en el README (entre las marcas <!-- CAPTURAS --> y <!-- /CAPTURAS -->)
$todas = Get-ChildItem $dir -Filter *.png | Sort-Object Name
if ($todas.Count -gt 0) {
    $celdas = $todas | ForEach-Object { "<img src=""docs/screenshots/$($_.Name)"" width=""200"" alt=""$($_.BaseName)"">" }
    $bloque = "<!-- CAPTURAS -->`r`n<p align=""center"">`r`n" + ($celdas -join "`r`n") + "`r`n</p>`r`n<!-- /CAPTURAS -->"
    $readme = Get-Content README.md -Raw -Encoding UTF8
    $readme = [regex]::Replace($readme, "(?s)<!-- CAPTURAS -->.*?<!-- /CAPTURAS -->", $bloque)
    [IO.File]::WriteAllText((Resolve-Path README.md), $readme, (New-Object System.Text.UTF8Encoding $false))
    Write-Host "README actualizado con $($todas.Count) capturas. Súbelo con tool\publicar_github.ps1" -ForegroundColor Green
}
