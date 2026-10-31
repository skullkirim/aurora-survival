# AURORA - Publicar el código en GitHub (repositorio PÚBLICO) y subir el APK como release.
#   cd E:\APOCA
#   powershell -ExecutionPolicy Bypass -File .\tool\publicar_github.ps1
# Opcional: -Repo nombre  (por defecto aurora-survival)
param([string]$Repo = "aurora-survival")
$ErrorActionPreference = "Continue"
Set-Location (Split-Path $PSScriptRoot -Parent)

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "Instala Git: winget install Git.Git" }
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "Instalando GitHub CLI..." -ForegroundColor Cyan
    winget install --id GitHub.cli -e --accept-source-agreements --accept-package-agreements
    $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")
}
gh auth status 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Inicia sesión en GitHub (se abre el navegador)..." -ForegroundColor Cyan
    gh auth login --hostname github.com --git-protocol https --web
}
$user = (gh api user --jq .login).Trim()

# Limpieza de temporales
Remove-Item _apoca_*.tgz -ErrorAction SilentlyContinue

if (-not (Test-Path .git)) { git init -b main | Out-Null }
git add -A
git -c user.name="$user" -c user.email="$user@users.noreply.github.com" commit -m "AURORA 1.6.0: supervivencia offline (ES/EN/PT)" 2>$null
if ($LASTEXITCODE -ne 0) { Write-Host "(sin cambios nuevos para commit)" }

gh repo view "$user/$Repo" 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) {
    gh repo create "$user/$Repo" --public --source . --remote origin --push `
        --description "AURORA: manual de supervivencia 100% offline para Android (Flutter). Guías, mapas sin internet, Morse, alarmas, modo comunidad. ES/EN/PT."
} else {
    if (-not (git remote | Select-String origin)) { git remote add origin "https://github.com/$user/$Repo.git" }
    git push -u origin main
}

$apk = "build\app\outputs\flutter-apk\app-release.apk"
$ver = ((Select-String -Path pubspec.yaml -Pattern '^version:\s*([0-9.]+)').Matches[0].Groups[1].Value)
if (Test-Path $apk) {
    Copy-Item $apk "AURORA-$ver.apk" -Force
    gh release view "v$ver" --repo "$user/$Repo" 2>$null | Out-Null
    if ($LASTEXITCODE -ne 0) {
        gh release create "v$ver" "AURORA-$ver.apk" --repo "$user/$Repo" --title "AURORA $ver" `
            --notes "APK para Android. Instálalo permitiendo 'orígenes desconocidos'. Funciona sin internet."
    } else {
        gh release upload "v$ver" "AURORA-$ver.apk" --repo "$user/$Repo" --clobber
    }
    Remove-Item "AURORA-$ver.apk"
} else {
    Write-Host "No hay APK. Compila con: flutter build apk --release  y vuelve a ejecutar este script." -ForegroundColor Yellow
}
Write-Host "Listo: https://github.com/$user/$Repo" -ForegroundColor Green
