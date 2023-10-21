import 'package:flutter_test/flutter_test.dart';
import 'package:my_phonepe_plugin/my_phonepe_plugin.dart';
import 'package:my_phonepe_plugin/my_phonepe_plugin_platform_interface.dart';
import 'package:my_phonepe_plugin/my_phonepe_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyPhonepePluginPlatform
    with MockPlatformInterfaceMixin
    implements MyPhonepePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyPhonepePluginPlatform initialPlatform = MyPhonepePluginPlatform.instance;

  test('$MethodChannelMyPhonepePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyPhonepePlugin>());
  });

  test('getPlatformVersion', () async {
    MyPhonepePlugin myPhonepePlugin = MyPhonepePlugin();
    MockMyPhonepePluginPlatform fakePlatform = MockMyPhonepePluginPlatform();
    MyPhonepePluginPlatform.instance = fakePlatform;

    expect(await myPhonepePlugin.getPlatformVersion(), '42');
  });
}
