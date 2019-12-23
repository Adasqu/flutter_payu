package io.proflutter.flutter_payu.internal

import android.app.Activity
import com.payu.android.front.sdk.payment_library_google_pay_module.builder.Cart
import com.payu.android.front.sdk.payment_library_google_pay_module.model.Currency
import com.payu.android.front.sdk.payment_library_google_pay_module.service.GooglePayService
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class GooglePayModule(registrar: PluginRegistry.Registrar, val channel: MethodChannel) {
    val activity = registrar.activity()
    val googlePayService: GooglePayService = GooglePayService(activity)
    var result: MethodChannel.Result? = null

    init {
        registrar.addActivityResultListener { requestCode, resultCode, data ->
            if (requestCode == GooglePayService.REQUEST_CODE_GOOGLE_PAY_PAYMENT) {
                if (resultCode == Activity.RESULT_OK) {
                    val googlePayTokenResponse = googlePayService.handleGooglePayResultData(data)
                    result!!.success(googlePayTokenResponse!!.googlePayToken)
                } else if (resultCode == Activity.RESULT_CANCELED) {
                    result!!.error("errorCode", "resultCanceled", "canceled")
                } else if (resultCode == GooglePayService.RESULT_ERROR) {
                    val status = googlePayService.handleGooglePayErrorStatus(data!!)
                    result!!.error("errorCode", "googlePayError", "error")
                }
            } else {
                result!!.success(null)
            }


            return@addActivityResultListener false
        }
    }

    fun googlePay(result: MethodChannel.Result, postId: String, price: Int, merchantName: String) {

        this.result = result
        val cart = Cart.Builder()
                .withTotalPrice(price) //10.00 as an integer
                .withCurrency(Currency.PLN)
                .build()
        googlePayService.requestGooglePayCard(cart, postId, merchantName)
    }
}