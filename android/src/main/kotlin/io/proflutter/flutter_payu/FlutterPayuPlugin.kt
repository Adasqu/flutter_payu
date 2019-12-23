package io.proflutter.flutter_payu

import io.proflutter.flutter_payu.internal.GooglePayModule


import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

class FlutterPayuPlugin(methodChannel: MethodChannel, registrar: PluginRegistry.Registrar) : MethodCallHandler {
    val googlePayModule: GooglePayModule = GooglePayModule(registrar, methodChannel)

    companion object {
        @JvmStatic
        fun registerWith(registrar: PluginRegistry.Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_payu")
            channel.setMethodCallHandler(FlutterPayuPlugin(channel, registrar))
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "googlePay") {
            val arugments = call.arguments<Map<String, Any>>()
            val posId: String = arugments["posId"] as String
            val price: Int = arugments["price"] as Int
            val merchantName: String = arugments["merchantName"] as String
            googlePayModule.googlePay(result, posId, price, merchantName)
        } else {
            result.notImplemented()
        }
    }
}
