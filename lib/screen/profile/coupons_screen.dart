import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomFold(
      appBar: 'Coupons',
      isShowBack: true,
      bodys: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('asset/svg/notification.json', height: 300),
          const Height(10),
          SmallText(
            text: 'Nothing to show here at the moment.',
            size: 14,
            fontweights: FontWeight.w400,
          ),
          const Height(6),
          SmallText(
            text: "Stay tuned for updates!",
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
