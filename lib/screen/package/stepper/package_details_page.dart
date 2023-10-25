import 'package:clocare/screen/package/package_checkout_screen.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';

import '../../../backend/model/package_model.dart';

class PackageDetailsPage extends StatelessWidget {
  final Data package;
  final String address;
  final Map pickupSlotData;
  final startDate;
  final endDate;
  const PackageDetailsPage(
      {super.key,
      required this.package,
      required this.address,
      required this.pickupSlotData,
      this.startDate,
      this.endDate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
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
          child: Column(
            children: [
              packageDetail(
                packages: package,
                startDate: startDate,
                endDate: endDate,
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
                        // color: AppColor.primaryColor1,
                        borderRadius: BorderRadius.circular(8),
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
                                borderRadius: BorderRadius.circular(8),
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
                                      text: 'Pickup day',
                                      size: 14,
                                      color: AppColor.appBarColor,
                                      fontweights: FontWeight.w500,
                                    ),
                                    const Height(8),
                                    SmallText(
                                      text: pickupSlotData['pickup_day'],
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
                                borderRadius: BorderRadius.circular(8),
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
                                      text: 'Pickup slot',
                                      size: 14,
                                      color: AppColor.appBarColor,
                                      fontweights: FontWeight.w500,
                                    ),
                                    const Height(8),
                                    SmallText(
                                      text: pickupSlotData['pickup_time'],
                                      size: 12,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    const Height(8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                // color: AppColor.primaryColor1,
                                borderRadius: BorderRadius.circular(8),
                                // border:  Border.all(color: Colors.grey, width: 0.5),
                                // color: const Color(0xFFF9F8FF),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SmallText(
                                      text: 'Delivery',
                                      size: 14,
                                      color: AppColor.appBarColor,
                                      fontweights: FontWeight.w500,
                                    ),
                                    const Height(8),
                                    SmallText(
                                      text: pickupSlotData['delivery'],
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
                                borderRadius: BorderRadius.circular(8),
                                // border:   Border.all(color: Colors.grey, width: 0.5),
                                // color: AppColor.primaryColor1,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SmallText(
                                      text: 'Delivery slot',
                                      size: 14,
                                      color: AppColor.appBarColor,
                                      fontweights: FontWeight.w500,
                                    ),
                                    const Height(8),
                                    SmallText(
                                      text: pickupSlotData['pickup_time'],
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
              ),
              // const Height(25),
              // Container(
              //   height: 60,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(color: Colors.white, width: 1),
              //     color: const Color(0xFFF9F8FF),
              //     boxShadow: [
              //       BoxShadow(
              //         color: AppColor.boxShadowColor,
              //         blurRadius: 4.0,
              //         spreadRadius: 2.0,
              //         offset: const Offset(0.0, 0.0),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class packageDetail extends StatelessWidget {
  final Data packages;
  final startDate;
  final endDate;
  const packageDetail({
    super.key,
    required this.packages,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 1),
        color: AppColor.primaryColor1,
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
            PackBox(
              title: 'Package name :',
              value: packages.packageName.toString(),
            ),
            const Height(10),
            PackBox(
              title: 'Package code :',
              value: packages.packageCode.toString(),
            ),
            const Height(10),
            PackBox(
              title: 'No of clothes :',
              value: packages.routineGarments.toString(),
            ),
            const Height(10),
            Divider(
              color: AppColor.backgroundColor,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        // color: AppColor.primaryColor1,
                        borderRadius: BorderRadius.circular(8),
                        // border: Border.all(color: Colors.grey, width: 0.5),
                        color: AppColor.primaryButtonColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SmallText(
                              text: 'START DATE',
                              size: 14,
                              color: AppColor.backgroundColor,
                              // fontweights: FontWeight.w500,
                            ),
                            const Height(8),
                            SmallText(
                              text: startDate,
                              size: 12,
                              color: const Color.fromARGB(255, 255, 213, 86),
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
                        borderRadius: BorderRadius.circular(8),
                        // border: Border.all(color: Colors.grey, width: 0.5),
                        color: AppColor.primaryButtonColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SmallText(
                              text: 'END DATE',
                              size: 14,
                              color: AppColor.backgroundColor,
                              // fontweights: FontWeight.w500,
                            ),
                            const Height(8),
                            SmallText(
                              text: endDate,
                              size: 12,
                              color: const Color.fromARGB(255, 255, 213, 86),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
            const Height(10),
            Divider(
              color: AppColor.backgroundColor,
            ),
            const Height(10),
            Container(
                decoration: BoxDecoration(
                  // color: AppColor.primaryColor1,
                  borderRadius: BorderRadius.circular(8),
                  // border: Border.all(color: Colors.grey, width: 0.5),
                  color: AppColor.primaryButtonColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmallText(
                        text: 'Total Bill',
                        size: 14,
                        color: AppColor.backgroundColor,
                        // fontweights: FontWeight.w500,
                      ),
                      const Height(8),
                      SmallText(
                        text: '₹${double.parse(packages.prices.toString())}',
                        size: 14,
                        color: const Color.fromARGB(255, 255, 213, 86),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
