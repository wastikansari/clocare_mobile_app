import 'package:clocare/screen/home/home_screen.dart';
import 'package:clocare/screen/home/service_details_screen.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/utiles/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<String> _imageUrls = [
    AppAsset.offer1,
    AppAsset.offer2,
    AppAsset.offer3,
    AppAsset.offer4,
    AppAsset.offer5,
  ];

  serviceDetailScreen({required String serviceName, required int serviceId}) {
    Get.to(
        ServiceDetailScreen(
          serviceName: serviceName,
          serviceId: serviceId,
        ),
        transition: Transition.rightToLeft);
  }

  @override
  Widget build(BuildContext context) {
    return CustomFold(
      appBar: 'Services',
      isShowBack: true,
      bodys: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Height(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ServiceBox(
                title: 'Wash & Fold',
                icon:
                    'https://clocare.in/wp-content/uploads/2022/12/wash-fold.png',
                onPress: () {
                  serviceDetailScreen(serviceName: 'Wash & Fold', serviceId: 1);
                },
              ),
              ServiceBox(
                title: 'Dry Cleaning',
                icon:
                    'https://clocare.in/wp-content/uploads/2022/12/dry-cleaning.png',
                onPress: () {
                  serviceDetailScreen(
                      serviceName: 'Dry Cleaning', serviceId: 3);
                },
              ),
              ServiceBox(
                title: 'Ironing',
                icon:
                    'https://clocare.in/wp-content/uploads/2022/12/ironing.png',
                onPress: () {
                  serviceDetailScreen(serviceName: 'Ironing', serviceId: 4);
                },
              ),
            ],
          ),
          const Height(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ServiceBox(
                title: 'Wash & Ironing',
                icon:
                    'https://clocare.in/wp-content/uploads/2022/12/premium-rental-services.png',
                onPress: () {
                  serviceDetailScreen(
                      serviceName: 'Wash & Ironing', serviceId: 2);
                },
              ),
              ServiceBox(
                title: 'Stream Ironing',
                icon:
                    'https://clocare.in/wp-content/uploads/2022/12/steam-Ironing.png',
                onPress: () {
                  serviceDetailScreen(
                      serviceName: 'Stream Ironing', serviceId: 5);
                },
              ),
              ServiceBox(
                title: 'Tailoring',
                icon:
                    'https://clocare.in/wp-content/uploads/2022/12/tailoring.png',
                onPress: () {
                  // serviceDetailScreen(serviceName: 'Tailoring', serviceId: 6);
                },
              ),
            ],
          ),
          const Height(20),
        ],
      ),
    );
  }
}
