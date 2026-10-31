# AURORA - Compilar, publicar el código en GitHub (repositorio PÚBLICO) y subir los APK como release.
#   cd E:\APOCA
#   powershell -ExecutionPolicy Bypass -File .\tool\publicar_github.ps1
# Opciones: -Repo nombre (por defecto aurora-survival) · -SinCompilar
param([string]$Repo = "aurora-survival", [switch]$SinCompilar)
$ErrorActionPreference = "Continue"
Set-Location (Split-Path $PSScriptRoot -Parent)

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { Write-Host "Instala Git: winget install Git.Git" -ForegroundColor Red; exit 1 }
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "Instalando GitHub CLI..." -ForegroundColor Cyan
    winget install --id GitHub.cli -e --accept-source-agreements --accept-package-agreements
    $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")
}
gh auth status 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) { gh auth login --hostname github.com --git-protocol https --web }
$user = (gh api user --jq .login).Trim()
$ver = ((Select-String -Path pubspec.yaml -Pattern '^version:\s*([0-9.]+)').Matches[0].Groups[1].Value)

# 1. APK livianos: uno por tipo de procesador (~20-25 MB cada uno)
if (-not $SinCompilar) {
    Write-Host "Compilando APK $ver..." -ForegroundColor Cyan
    flutter build apk --release --split-per-abi
    if ($LASTEXITCODE -ne 0) { Write-Host "Falló la compilación." -ForegroundColor Red; exit 1 }
}

# 2. Código
Remove-Item _apoca_*.tgz -ErrorAction SilentlyContinue
if (-not (Test-Path .git)) { git init -b main | Out-Null }
git add -A
git -c user.name="$user" -c user.email="$user@users.noreply.github.com" commit -m "AURORA $ver" 2>&1 | Out-Null
gh repo view "$user/$Repo" 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    gh repo create "$user/$Repo" --public --source . --remote origin --push
} else {
    if (-not (git remote | Select-String origin)) { git remote add origin "https://github.com/$user/$Repo.git" }
    git push -u origin main
}
gh repo edit "$user/$Repo" `
    --description "AURORA: manual de supervivencia 100% offline para Android. Emergencias paso a paso, mapa sin internet, Morse, alarmas, modo comunidad. ES/EN/PT." `
    --add-topic survival --add-topic offline --add-topic flutter --add-topic android --add-topic first-aid `
    --add-topic emergency --add-topic offline-maps --add-topic pmtiles --add-topic prepper --add-topic morse-code | Out-Null

# 3. Release con los APK
$out = "build\app\outputs\flutter-apk"
$apks = @()
foreach ($abi in @("arm64-v8a", "armeabi-v7a", "x86_64")) {
    $f = "$out\app-$abi-release.apk"
    if (Test-Path $f) { $dest = "AURORA-$ver-$abi.apk"; Copy-Item $f $dest -Force; $apks += $dest }
}
if ($apks.Count -eq 0 -and (Test-Path "$out\app-release.apk")) { Copy-Item "$out\app-release.apk" "AURORA-$ver.apk" -Force; $apks += "AURORA-$ver.apk" }
if ($apks.Count -gt 0) {
    $notes = @"
## AURORA $ver
Descarga **AURORA-$ver-arm64-v8a.apk** (sirve para casi todos los teléfonos de los últimos años). Si no instala, prueba armeabi-v7a (teléfonos viejos).

Instalar: abre el APK y permite orígenes desconocidos. Funciona sin internet.

Novedades: baliza SOS automática, signos vitales por persona, mensajes entre teléfonos en Modo comunidad, aviso para que las alarmas no se pierdan en Xiaomi/Redmi, temas de higiene/botiquín casero y autoprotección, más recetas.
"@
    gh release view "v$ver" --repo "$user/$Repo" 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        $nf = Join-Path $env:TEMP "aurora_notes.md"
        [IO.File]::WriteAllText($nf, $notes, (New-Object System.Text.UTF8Encoding $false))
        gh release create "v$ver" @apks --repo "$user/$Repo" --title "AURORA $ver" --notes-file $nf --latest
    } else {
        gh release upload "v$ver" @apks --repo "$user/$Repo" --clobber
    }
    $apks | ForEach-Object { Remove-Item $_ }
}
Write-Host "Listo: https://github.com/$user/$Repo" -ForegroundColor Green
