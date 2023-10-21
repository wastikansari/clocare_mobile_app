import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_phonepe_plugin_platform_interface.dart';

/// An implementation of [MyPhonepePluginPlatform] that uses method channels.
class MethodChannelMyPhonepePlugin extends MyPhonepePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_phonepe_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
