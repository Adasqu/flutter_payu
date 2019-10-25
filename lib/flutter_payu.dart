import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

enum GooglePayResponseStatus { OK, CANCELED, ERROR }

class GooglePayResponse {
  final GooglePayResponseStatus status;
  final String message;

  GooglePayResponse(this.status, this.message);
}

class FlutterPayu {
  static const MethodChannel _channel = const MethodChannel('flutter_payu');

  static Future<GooglePayResponse> googlePay(String posId, int price) async {
    if(!Platform.isAndroid)
      throw UnsupportedError;
    try {
      final message = await _channel
          .invokeMethod("googlePay", {"posId": posId, "price": price});
      return GooglePayResponse(GooglePayResponseStatus.OK, message);
    } on PlatformException catch (exception) {
      if (exception.details == "canceled") {
        return GooglePayResponse(
            GooglePayResponseStatus.CANCELED, exception.message);
      } else {
        return GooglePayResponse(
            GooglePayResponseStatus.ERROR, exception.message);
      }
    }
  }
}
