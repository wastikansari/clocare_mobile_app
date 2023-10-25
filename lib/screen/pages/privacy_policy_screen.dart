import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utiles/themes/ColorConstants.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

    double _loadingProgress = 0.0;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _loadingProgress = progress / 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              _loadingProgress = 0.0;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _loadingProgress = 0.0;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url
                .startsWith('https://clocare.in/privacy-policy/?v=c86ee0d9d7ed')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://clocare.in/privacy-policy/?v=c86ee0d9d7ed'));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          'Privacy policy',
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          Center(
            child: _loadingProgress > 0.0
                ? LoadingAnimationWidget.dotsTriangle(
                    color: AppColor.primaryColor1, size: 60)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

}
