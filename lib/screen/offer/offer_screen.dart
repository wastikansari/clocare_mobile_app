import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/utiles/app_asset.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFold(
        appBar: 'Offers',
        isShowBack: true,
        bodys: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(color: AppColor.appBarColor),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    const Height(60),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Image.asset(
                        AppAsset.offerImage[4],
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: AppAsset.offerImage.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Image.asset(AppAsset.offerImage[index]),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
