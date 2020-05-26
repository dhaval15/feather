package com.brokenglass.feather

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)

    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        val methodChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger,"plugins.broken-glass.com/feather")
        print("Activity : --------------------------- ${intent.data}" )
        methodChannel.invokeMethod("onIntentData",intent.data?.toString())
    }
}
