package com.panlabstudios.apoca

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * APOCA: canal nativo de ahorro de energía.
 *  - setLowRefresh: limita la pantalla a ~60 Hz (las pantallas de 120 Hz gastan mucho más).
 *  - setBrightness: brillo solo dentro de la app (-1 = el del sistema).
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
                        else -> result.notImplemented()
                    }
                } catch (e: Exception) {
                    result.success(false)
                }
            }
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
