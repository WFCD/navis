package com.cephalon.navis

import com.transistorsoft.flutter.backgroundfetch.BackgroundFetchPlugin;
import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterMain

class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        FlutterMain.startInitialization(this)
        BackgroundFetchPlugin.setPluginRegistrant(this)
    }

     override  fun registerWith(registry: PluginRegistry) {
        GeneratedPluginRegistrant.registerWith(registry)
    }
}