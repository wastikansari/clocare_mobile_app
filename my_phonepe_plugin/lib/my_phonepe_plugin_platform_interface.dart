import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_phonepe_plugin_method_channel.dart';

abstract class MyPhonepePluginPlatform extends PlatformInterface {
  /// Constructs a MyPhonepePluginPlatform.
  MyPhonepePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyPhonepePluginPlatform _instance = MethodChannelMyPhonepePlugin();

  /// The default instance of [MyPhonepePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyPhonepePlugin].
  static MyPhonepePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyPhonepePluginPlatform] when
  /// they register themselves.
  static set instance(MyPhonepePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
