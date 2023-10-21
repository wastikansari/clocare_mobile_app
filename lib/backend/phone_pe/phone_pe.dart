import 'package:flutter/services.dart';

class PhonePePlugin {
  static const MethodChannel _channel =  MethodChannel('phonepe_plugin');

  // Initialize PhonePe
  static Future<void> init() async {
    try {
      await _channel.invokeMethod('initPhonePe');
    } catch (e) {
      print(e);
    }
  }
}
