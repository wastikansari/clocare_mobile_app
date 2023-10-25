import 'package:carousel_slider/carousel_slider.dart';
import 'package:clocare/payment_gateway/phonePe_payment_gateway.dart';
import 'package:clocare/routes/routes.dart';
import 'package:clocare/screen/home/service_details_screen.dart';
import 'package:clocare/screen/widget/whatsapp_btn.dart';
import 'package:clocare/services/call_reguest.dart';
import 'package:clocare/utiles/app_asset.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../testing.dart';
import '../../utiles/themes/ColorConstants.dart';
import '../basket/basket_garment_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

      CallReuest callReuest = CallReuest();
  serviceDetailScreen({required String serviceName, required int serviceId}) {
    Get.to(
        ServiceDetailScreen(
          serviceName: serviceName,
          serviceId: serviceId,
        ),
        transition: Transition.rightToLeft);
  }

    _makePhoneCall() async {
    const url = 'tel:+91 8141116600'; 
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBarColor,
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AppAsset.logoWhite,
                  height: 30,
                ),
                Row(
                  children: [
                    const WhatsappBtn(),
                    const Widths(20),
                    IconButtonWidet(
                      icon: IconlyLight.wallet,
                      onPress: () {
                        Get.toNamed(Routes.wallet);
                      },
                    ),

                    //  const Widths(20),
                    // IconButtonWidet(
                    //   icon: IconlyLight.notification,
                    //   onPress: () {
                    //     Get.toNamed(Routes.notification);
                    //     //  Get.toNamed(Routes.wallet);
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          ),
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
              child: SingleChildScrollView(
                // reverse: true,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Height(20),
                      SizedBox(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            ServiceTypeBox(
                              title: 'MEN',
                              backgroundColor:
                                  Color.fromARGB(183, 255, 240, 221),
                            ),
                            ServiceTypeBox(
                              title: 'WOMEN',
                              backgroundColor:
                                  Color.fromARGB(183, 255, 240, 221),
                            ),
                            ServiceTypeBox(
                              title: 'KIDS',
                              backgroundColor:
                                  Color.fromARGB(183, 255, 240, 221),
                            ),
                            ServiceTypeBox(
                              title: 'HOUSEHOLD',
                              backgroundColor:
                                  Color.fromARGB(183, 255, 240, 221),
                            ),
                          ],
                        ),
                      ),
                      const Height(20),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                              text: 'Services',
                              size: 20,
                              color: Colors.black,
                              fontweights: FontWeight.bold,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.service);
                              },
                              child: SmallText(
                                text: 'see all',
                                color: AppColor.primaryColor1,
                                fontweights: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Height(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ServiceBox(
                            title: 'Wash & Fold',
                            icon:
                                'https://clocare.in/wp-content/uploads/2022/12/wash-fold.png',
                            onPress: () {
                              serviceDetailScreen(
                                  serviceName: 'Wash & Fold', serviceId: 1);
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
                              serviceDetailScreen(
                                  serviceName: 'Ironing', serviceId: 4);
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
                               callReuest.comingSoon(context, 'Tailoring Service', "Tailoring services coming soon! Stay tuned for expert alterations and custom fittings.");
                              // serviceDetailScreen(
                              //     serviceName: 'Tailoring', serviceId: 6);
                            },
                          ),
                        ],
                      ),
                      const Height(20),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10, right: 10),
                      // child:
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: CarouselSlider(
                          items: AppAsset.offerImage.map((url) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                url,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            onPageChanged: (index, _) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      // ),
                      const Height(20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FastBox(
                            title: 'Quick',
                            icon: 'asset/icons/on-time.png',
                            iconHight: 32,
                            onTap: () {
                              callReuest.comingSoon(context, 'Quick Service', "Fast service is on its way. Your order will be delivered the same day");
                            },
                          ),
                          FastBox(
                            title: 'Express',
                            icon: 'asset/icons/express.png',
                            iconHight: 32,
                            onTap: () {
                              callReuest.comingSoon(context, 'Express Service', "Fast service is on its way. Your order will be delivered the same day");
                              // print('dd');
                              // PhonePePaymentGateway phonePePaymentGateway =
                              //     PhonePePaymentGateway();
                              // phonePePaymentGateway.phonePeGateway();
                              // phonePeGateway();
                              // Get.to(Stepper1());
                            },
                          ),
                          FastBox(
                            title: 'Daily',
                            icon: 'asset/icons/24-hours.png',
                            iconHight: 32,
                            onTap: () {
                              Get.to(const BasketGarmentScreen(), transition: Transition.rightToLeft);
                            },
                          ),
                        ],
                      ),
                      const Height(20),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          // height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white, width: 1),
                            color: const Color(0xFFF9F8FF),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.boxShadowColor,
                                blurRadius: 4.0,
                                spreadRadius: 2.0,
                                offset: const Offset(0.0, 0.0),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 25,
                                  ),
                                  child: SmallText(
                                    text: 'SHORTCUTS',
                                    color: const Color.fromARGB(
                                        255, 155, 162, 207),
                                    fontweights: FontWeight.w500,
                                  ),
                                ),
                                const Height(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ShortcutsBox(
                                      title: 'Wallet',
                                      icon: IconlyBold.wallet,
                                      onTap: () {
                                        Get.toNamed(Routes.wallet);
                                      },
                                    ),
                                    ShortcutsBox(
                                      title: 'Rate Card',
                                      icon: IconlyBold.arrow_right_square,
                                      onTap: () {
                                        Get.toNamed(Routes.rateCard);
                                      },
                                    ),
                                    ShortcutsBox(
                                      title: 'Offers',
                                      icon: IconlyBold.activity,
                                      onTap: () {
                                        Get.toNamed(Routes.offer);
                                      },
                                    ),
                                  ],
                                ),
                                const Height(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ShortcutsBox(
                                      title: 'Help',
                                      icon: IconlyBold.document,
                                      onTap: () {
                                       _makePhoneCall();
                                      },
                                    ),
                                    ShortcutsBox(
                                      title: 'Call Request',
                                      icon: IconlyBold.more_circle,
                                      onTap: () {
                                        callReuest.confermationBox(context);
                                      },
                                    ),
                                    const ShortcutsBox1(
                                      title: ' ',
                                      icon: IconlyBold.profile,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      const Height(12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconButtonWidet extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  const IconButtonWidet({
    super.key,
    required this.icon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 62, 70),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey, width: 0.3)),
      child: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            onPress();
          },
          child: Center(
              child: Icon(
            icon,
            size: 18,
          )),
        ),
      ),
    );
  }
}

class ShortcutsBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  const ShortcutsBox({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white, width: 0.1),
              color: AppColor.backgroundColor,
            ),
            child: Icon(
              icon,
              size: 25,
            ),
          ),
          const Height(6),
          SmallText(
            text: title,
            size: 12,
            color: const Color.fromARGB(157, 0, 0, 0),
          )
        ],
      ),
    );
  }
}

class ShortcutsBox1 extends StatelessWidget {
  final IconData icon;
  final String title;
  const ShortcutsBox1({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white, width: 0.1),
            color: AppColor.boxColor,
          ),
        ),
        const Height(6),
        SmallText(
          text: title,
          size: 12,
          color: const Color.fromARGB(157, 0, 0, 0),
        )
      ],
    );
  }
}

class FastBox extends StatelessWidget {
  final String title;
  final String icon;
  final double iconHight;
  final Function onTap;
  const FastBox({
    super.key,
    required this.title,
    required this.icon,
    required this.iconHight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 70,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 1),
          color: const Color(0xFFF9F8FF),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(
            children: [
              Image.asset(icon, height: iconHight),
              const Height(5),
              SmallText(text: title),
            ],
          )),
        ),
      ),
    );
  }
}

class ServiceBox extends StatelessWidget {
  final String icon;
  final String title;
  final Function onPress;

  ServiceBox({
    super.key,
    required this.icon,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white, width: 1),
          color: const Color(0xFFF9F8FF),
          boxShadow: [
            BoxShadow(
              color: AppColor.boxShadowColor,
              blurRadius: 4.0,
              spreadRadius: 2.0,
              offset: const Offset(0.0, 0.0),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                icon,
                height: 40,
              ),
              // const Height(8),
              SmallText(
                text: title,
                color: AppColor.appBarColor,
                fontweights: FontWeight.w500,
                size: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceTypeBox extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  const ServiceTypeBox({
    super.key,
    required this.title,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.rateCard);
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white, width: 1),
            color: const Color(0xFFF9F8FF),
            boxShadow: [
              BoxShadow(
                color: AppColor.boxShadowColor,
                blurRadius: 4.0,
                spreadRadius: 2.0,
                offset: const Offset(0.0, 0.0),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: SmallText(
                text: title,
                color: Colors.black,
                fontweights: FontWeight.w500,
                size: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
