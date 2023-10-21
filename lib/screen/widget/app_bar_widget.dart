import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utiles/themes/ColorConstants.dart';

class CustomFold extends StatelessWidget {
  final String appBar;
  final Widget bodys;
  final bool isShowBack;
  final Widget? leading;
  final Widget? bottomNavigationBar;
  const CustomFold(
      {super.key,
      required this.appBar,
      required this.bodys,
      this.isShowBack = false,
      this.leading,
      this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBarColor,
      body: Column(
        children: [
          Container(
            height: 85,
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: isShowBack,
                      child: IconButton(
                          padding: const EdgeInsets.all(6),
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColor.backgroundColor,
                            size: 25,
                          )),
                    ),
                    const Widths(10),
                    SmallText(
                      text: appBar,
                      size: 20,
                      fontweights: FontWeight.w500,
                      color: AppColor.backgroundColor,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: SizedBox(
                    height: 100,
                    child: leading,
                  ),
                ),
              ],
            ),
          ),
          const Height(20),
          Expanded(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: bodys),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
