import 'package:clocare/screen/basket/steps/basket_page.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/app_asset.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';

class OrderSummaryPage extends StatelessWidget {
  final String serviceName;
  final String items;
  final String address;
  final String pickupDate;
  final String pickupTime;
  final String deliverDate;
  final String deliverTime;
  const OrderSummaryPage(
      {super.key,
      required this.serviceName,
      required this.items,
      required this.address,
      required this.pickupDate,
      required this.pickupTime,
      required this.deliverDate,
      required this.deliverTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.boxColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 2),
            // color: const Color(0xFFF9F8FF),
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
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                        color: AppColor.backgroundColor,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(AppAsset.wash_fold),
                      ),
                    ),
                    const Widths(20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: serviceName,
                          size: 15,
                          color: AppColor.appBarColor,
                          fontweights: FontWeight.bold,
                        ),
                        const Height(3),
                        SmallText(text: items),
                      ],
                    ),
                  ],
                ),
                const Height(10),
                const Divider(
                  thickness: 1,
                ),
                const Height(10),
                SizedBox(
                  height: 60,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: 'Address',
                          size: 15,
                          color: AppColor.appBarColor,
                          fontweights: FontWeight.w500,
                        ),
                        const Height(8),
                        SmallText(
                          text: address,
                          overFlow: TextOverflow.visible,
                        )
                      ]),
                ),
                const Height(10),
                const Divider(
                  thickness: 1,
                  // color: Colors.grey,
                ),
                const Height(10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              // color: AppColor.primaryColor1,
                              color: Color.fromARGB(106, 239, 241, 254),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: const Color.fromARGB(39, 68, 137, 255))
                              // borderRadius: BorderRadius.circular(8),
                              // border: Border.all(color: Colors.grey, width: 0.5),
                              // color: const Color(0xFFF9F8FF),
                              ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallText(
                                  text: 'Pickup - time',
                                  size: 14,
                                  color: AppColor.appBarColor,
                                  fontweights: FontWeight.w500,
                                ),
                                const Height(8),
                                SmallText(text: pickupDate),
                                const Height(5),
                                SmallText(
                                  text: pickupTime,
                                )
                              ],
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(106, 239, 241, 254),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: const Color.fromARGB(39, 68, 137, 255))
                              // borderRadius: BorderRadius.circular(8),
                              // border: Border.all(color: Colors.grey, width: 0.5),
                              // color: AppColor.primaryColor1,
                              ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallText(
                                  text: 'Delivery - time',
                                  size: 14,
                                  color: AppColor.appBarColor,
                                  fontweights: FontWeight.w500,
                                ),
                                const Height(8),
                                SmallText(
                                  text: deliverDate,
                                ),
                                const Height(5),
                                SmallText(
                                  text: deliverTime,
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Height(20)
      ],
    );
  }
}

class BasketSummaryPage extends StatelessWidget {
  final String totalItems;
  final String service;
  final String basketAmount;
  final String deliveryCharges;
  // final String promoCode;
  final String totalBill;
  final String address;
  final String pickupDate;
  final String pickupTime;
  final String deliverDate;
  final String deliverTime;
  const BasketSummaryPage({
    super.key,
    required this.address,
    required this.pickupDate,
    required this.pickupTime,
    required this.deliverDate,
    required this.deliverTime,
    required this.totalItems,
    required this.service,
    required this.basketAmount,
    required this.deliveryCharges,
    required this.totalBill,
    // required this.promoCode
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.boxColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 2),
            // color: const Color(0xFFF9F8FF),
            boxShadow: [
              BoxShadow(
                color: AppColor.boxShadowColor,
                blurRadius: 4.0,
                spreadRadius: 2.0,
                offset: const Offset(0.0, 0.0),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.primaryColor1,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(children: [
                    TextBox(
                      title: 'Total items',
                      value: totalItems,
                    ),
                    const Height(8),
                    TextBox(
                      title: 'Service',
                      value: service,
                    ),
                    const Height(8),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const Height(8),
                    TextBox(
                      title: 'Basket amount',
                      value: basketAmount,
                    ),
                    const Height(8),
                    TextBox(
                      title: 'Delivery charges',
                      value: deliveryCharges,
                    ),
                    const Height(8),
                    // TextBox(
                    //   title: 'Promo code',
                    //   value: promoCode,
                    // ),
                    const Height(8),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const Height(8),
                    TextBox(
                      title: 'Total bill',
                      value: totalBill,
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Height(8),
                    Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(106, 239, 241, 254),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color.fromARGB(39, 68, 137, 255))
                          // color: AppColor.primaryColor1,
                          // borderRadius: BorderRadius.circular(8),
                          // border: Border.all(color: Colors.grey, width: 0.5),
                          // color: const Color(0xFFF9F8FF),
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                text: 'Address',
                                size: 15,
                                color: AppColor.appBarColor,
                                fontweights: FontWeight.w500,
                              ),
                              const Height(8),
                              SmallText(
                                text: address,
                                overFlow: TextOverflow.visible,
                              )
                            ]),
                      ),
                    ),
                    const Height(10),
                    // const Divider(
                    //   thickness: 1,
                    //   // color: Colors.grey,
                    // ),
                    // const Height(10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(106, 239, 241, 254),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          39, 68, 137, 255))
                                  // border:Border.all(color: Colors.grey, width: 0.5),
                                  // color: const Color(0xFFF9F8FF),
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SmallText(
                                      text: 'Pickup - time',
                                      size: 14,
                                      color: AppColor.appBarColor,
                                      fontweights: FontWeight.w500,
                                    ),
                                    const Height(8),
                                    SmallText(
                                      text: pickupDate,
                                      size: 12,
                                    ),
                                    const Height(5),
                                    SmallText(
                                      text: pickupTime,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(106, 239, 241, 254),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          39, 68, 137, 255))
                                  // color: AppColor.primaryColor1,
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SmallText(
                                      text: 'Delivery - time',
                                      size: 14,
                                      color: AppColor.appBarColor,
                                      fontweights: FontWeight.w500,
                                    ),
                                    const Height(8),
                                    SmallText(
                                      text: deliverDate,
                                      size: 12,
                                    ),
                                    const Height(5),
                                    SmallText(
                                      text: deliverTime,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // Height(20)
      ],
    );
  }
}
