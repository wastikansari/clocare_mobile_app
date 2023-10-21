import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/screen/widget/whatsapp_btn.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../utiles/themes/ColorConstants.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFold(
      appBar: 'Orders',
      isShowBack: false,
      leading: WhatsappBtn(),
      bodys: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('asset/svg/orders.json', height: 300),
          const Height(40),
          SmallText(
            text: 'Looks like no orders yet',
            size: 14,
            fontweights: FontWeight.w500,
          ),
          const Height(6),
          SmallText(
            text: "Start now to track your laundry with ease!",
            color: AppColor.primaryColor1,
            fontweights: FontWeight.w500,
            size: 14,
          ),
          const Height(100),
        ],
      ),
    );
  }
}
