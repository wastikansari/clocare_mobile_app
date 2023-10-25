import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/whatsapp_btn.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utiles/themes/ColorConstants.dart';

class AboutScreen extends StatefulWidget {
  final String title;
  final String url;
  const AboutScreen({super.key, required this.title, required this.url});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  double _loadingProgress = 0.0;
  late WebViewController controller;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
            if (request.url.startsWith(widget.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return CustomFold(
        appBar: widget.title,
        isShowBack: true,
        leading: const WhatsappBtn(),
        bodys: Stack(
          children: [
            WebViewWidget(controller: controller),
            Center(
              child: _loadingProgress > 0.0
                  ? LoadingAnimationWidget.dotsTriangle(
                      color: AppColor.primaryColor1, size: 60)
                  : const SizedBox.shrink(),
            ),
          ],
        ));
  }
}
