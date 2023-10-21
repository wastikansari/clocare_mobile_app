import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappBtn extends StatelessWidget {
  const WhatsappBtn({super.key});

  Future whatsapp(context) async {
    String url = "https://wa.me/918141116600?text=Hey";
    print('sdfsd $url');
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 62, 70),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey, width: 0.3)),
      child: Center(
        child: InkWell(
          onTap: () {
            whatsapp(context);
          },
          child: Center(
              child: Lottie.asset('asset/svg/whatsapp.json', height: 400)),
        ),
      ),
    );
  }
}
