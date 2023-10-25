import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          'Send Feedback',
        ),
      ),
      body: WebViewWidget(controller: controller),
      //      body: isLoading == true ? const Center(child: CustomLoader()) : Column(
      //   children: [
      //     Expanded(
      //         child: InAppWebView(
      //       pullToRefreshController: refreshController,
      //       onWebViewCreated: ((controller) =>
      //           webViewController = controller),
      //       initialUrlRequest: URLRequest(url: Uri.parse('https://forms.gle/XRFx1knJL3g1snx97')),
      //     )),
      //   ],
      // ),
    );
  }

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith(
              'https://docs.google.com/forms/d/e/1FAIpQLSdeoP2H4pgzWA2I18h13wkpgcMz-T22wVDYIJBE4y1PY0LHRQ/viewform?usp=sf_link')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(
        'https://docs.google.com/forms/d/e/1FAIpQLSdeoP2H4pgzWA2I18h13wkpgcMz-T22wVDYIJBE4y1PY0LHRQ/viewform?usp=sf_link'));
}
