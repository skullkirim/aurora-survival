# APOCA - preparar el proyecto Flutter (ejecutar UNA vez dentro de E:\APOCA)
#   cd E:\APOCA
#   powershell -ExecutionPolicy Bypass -File .\setup.ps1
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

# 1. Genera la carpeta android/ sin tocar lib/, pubspec.yaml ni test/ existentes
flutter create --org com.panlabstudios --project-name apoca --platforms android .

# 2. Permisos y nombre de la app en el AndroidManifest
$m = "android\app\src\main\AndroidManifest.xml"
$xml = Get-Content $m -Raw
if ($xml -notmatch "ACCESS_FINE_LOCATION") {
    $perms = @"
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.FLASHLIGHT" />
    <uses-feature android:name="android.hardware.camera.flash" android:required="false" />
    <uses-feature android:name="android.hardware.location.gps" android:required="false" />
    <uses-feature android:name="android.hardware.sensor.compass" android:required="false" />
    <application
"@
    $xml = $xml -replace "(?s)\s*<application", "`n$perms"
}
$xml = $xml -replace 'android:label="[^"]*"', 'android:label="AURORA"'
Set-Content $m $xml -Encoding UTF8

# 2b. Pub cache y proyecto en discos distintos: sin cache incremental de Kotlin
$gp = "android\gradle.properties"
if (-not (Select-String -Path $gp -Pattern "kotlin.incremental" -Quiet)) {
    Add-Content $gp "`nkotlin.incremental=false"
}

# 2c. Actividad nativa de ahorro de energía (60 Hz y brillo)
Copy-Item "android_overrides\MainActivity.kt" "android\app\src\main\kotlin\com\panlabstudios\apoca\MainActivity.kt" -Force

# 2d. Ícono de la app (logo AURORA)
Copy-Item "android_overrides\res\*" "android\app\src\main\res\" -Recurse -Force

# 2e. Alarmas (notificaciones programadas) y Modo comunidad (red local sin internet)
$xml = Get-Content $m -Raw
if ($xml -notmatch "RECEIVE_BOOT_COMPLETED") {
    $extra = @"
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.USE_EXACT_ALARM" />
    <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" android:maxSdkVersion="32" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.CHANGE_WIFI_MULTICAST_STATE" />
"@
    $xml = $xml -replace '(<uses-permission android:name="android.permission.INTERNET" />)', "`$1`n$extra"
}
if ($xml -notmatch "ScheduledNotificationReceiver") {
    $recv = @"
        <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
        <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
                <action android:name="android.intent.action.QUICKBOOT_POWERON" />
                <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
            </intent-filter>
        </receiver>
    </application>
"@
    $xml = $xml -replace '\s*</application>', "`n$recv"
}
if ($xml -notmatch "usesCleartextTraffic") {
    $xml = $xml -replace 'android:label="AURORA"', 'android:label="AURORA" android:usesCleartextTraffic="true"'
}
Set-Content $m $xml -Encoding UTF8

$bg = "android\app\build.gradle.kts"
$g = Get-Content $bg -Raw
if ($g -notmatch "isCoreLibraryDesugaringEnabled") {
    $g = $g -replace 'compileOptions \{', "compileOptions {`n        isCoreLibraryDesugaringEnabled = true"
    $g = $g.TrimEnd() + "`n`ndependencies {`n    coreLibraryDesugaring(`"com.android.tools:desugar_jdk_libs:2.1.4`")`n}`n"
    [IO.File]::WriteAllText((Resolve-Path $bg), $g)
}

# 3. Dependencias y verificación
flutter pub get
flutter analyze
flutter test

Write-Host ""
Write-Host "Listo. Conecta el Redmi y ejecuta:  flutter run --release" -ForegroundColor Green
