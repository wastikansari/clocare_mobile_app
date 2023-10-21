import 'package:clocare/screen/package/package_checkout_screen.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';

class BottomNavigationBtn extends StatelessWidget {
  final Function backOntap;
  final Function nextOntap;
  const BottomNavigationBtn(
      {super.key, required this.backOntap, required this.nextOntap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      color: AppColor.backgroundColor,
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: AppColor.boxColor,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 244, 244, 244),
              blurRadius: 1.0,
              spreadRadius: 1.0,
              offset: Offset(
                1.0,
                1.0,
              ),
            ),
          ],
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BtnWidget(
                title: 'Back',
                onTap: () {
                  backOntap();
                },
                bg: AppColor.backgroundColor,
                titleColor: AppColor.primaryColor1,
              ),
              const Widths(15),
              BtnWidget(
                title: 'Next',
                onTap: () {
                  nextOntap();
                },
                bg: AppColor.primaryColor1,
                titleColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BtnWidget extends StatelessWidget {
  final String title;
  final Color bg;
  final Function onTap;
  final Color titleColor;
  const BtnWidget({
    super.key,
    required this.title,
    required this.bg,
    required this.onTap,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                  child: SmallText(
                text: title,
                fontweights: FontWeight.w500,
                color: titleColor,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
