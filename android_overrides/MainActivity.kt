package com.panlabstudios.apoca

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * AURORA: canal nativo de energía.
 *  - setLowRefresh: limita la pantalla a ~60 Hz (las pantallas de 120 Hz gastan mucho más).
 *  - setBrightness: brillo solo dentro de la app (-1 = el del sistema).
 *  - keepScreenOn: mantiene la pantalla encendida (baliza SOS).
 *  - isIgnoringBattery / openBatterySettings / openAutostart: para que las alarmas
 *    no se pierdan en MIUI/HyperOS y otros sistemas que "matan" apps.
 */
class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "apoca/power")
            .setMethodCallHandler { call, result ->
                try {
                    when (call.method) {
                        "setLowRefresh" -> {
                            setLowRefresh(call.argument<Boolean>("on") ?: true)
                            result.success(true)
                        }
                        "setBrightness" -> {
                            val v = (call.argument<Double>("value") ?: -1.0).toFloat()
                            val lp = window.attributes
                            lp.screenBrightness = if (v < 0f) -1f else v.coerceIn(0.01f, 1f)
                            window.attributes = lp
                            result.success(true)
                        }
                        "keepScreenOn" -> {
                            if (call.argument<Boolean>("on") == true) {
                                window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                            } else {
                                window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                            }
                            result.success(true)
                        }
                        "isIgnoringBattery" -> {
                            val pm = getSystemService(Context.POWER_SERVICE) as PowerManager
                            result.success(Build.VERSION.SDK_INT < Build.VERSION_CODES.M || pm.isIgnoringBatteryOptimizations(packageName))
                        }
                        "openBatterySettings" -> {
                            result.success(openBatterySettings())
                        }
                        "openAutostart" -> {
                            result.success(openAutostart())
                        }
                        else -> result.notImplemented()
                    }
                } catch (e: Exception) {
                    result.success(false)
                }
            }
    }

    private fun tryStart(i: Intent): Boolean = try {
        i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(i)
        true
    } catch (e: Exception) {
        false
    }

    private fun openBatterySettings(): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (tryStart(Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS, Uri.parse("package:$packageName")))) return true
            if (tryStart(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))) return true
        }
        return tryStart(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:$packageName")))
    }

    private fun openAutostart(): Boolean {
        val candidates = listOf(
            ComponentName("com.miui.securitycenter", "com.miui.permcenter.autostart.AutoStartManagementActivity"),
            ComponentName("com.coloros.safecenter", "com.coloros.safecenter.permission.startup.StartupAppListActivity"),
            ComponentName("com.huawei.systemmanager", "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity"),
            ComponentName("com.vivo.permissionmanager", "com.vivo.permissionmanager.activity.BgStartUpManagerActivity"),
        )
        for (c in candidates) {
            if (tryStart(Intent().setComponent(c))) return true
        }
        return tryStart(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:$packageName")))
    }

    private fun setLowRefresh(on: Boolean) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) return
        @Suppress("DEPRECATION")
        val disp = (if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) display else windowManager.defaultDisplay)
            ?: return
        val lp = window.attributes
        if (!on) {
            lp.preferredDisplayModeId = 0
            lp.preferredRefreshRate = 0f
        } else {
            val current = disp.mode
            val best = disp.supportedModes
                .filter { it.physicalWidth == current.physicalWidth && it.physicalHeight == current.physicalHeight }
                .minByOrNull { Math.abs(it.refreshRate - 60f) }
            if (best != null) {
                lp.preferredDisplayModeId = best.modeId
                lp.preferredRefreshRate = best.refreshRate
            }
        }
        window.attributes = lp
    }
}
