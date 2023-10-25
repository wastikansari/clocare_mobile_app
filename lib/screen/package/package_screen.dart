import 'package:clocare/backend/api/package_api.dart';
import 'package:clocare/backend/model/package_model.dart';
import 'package:clocare/screen/package/package_checkout_screen.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/screen/widget/whatsapp_btn.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  bool isVisibal = false;
  PackageApi packageApi = PackageApi();

  @override
  Widget build(BuildContext context) {
    return CustomFold(
      appBar: 'Package',
      leading: const WhatsappBtn(),
      bodys: Container(
          decoration: BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: FutureBuilder<PackageModel>(
              future: packageApi.packageList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.data!;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Data packageData = data[index];
                        // print('ddddddddddddddddd ${packageData.runtimeType}');
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: PackageBox(
                            title: packageData.packageName!,
                            code: " ${packageData.packageCode}",
                            pricing: "₹${packageData.prices}",
                            validity: "${packageData.valid!} day",
                            garments: packageData.routineGarments!,
                            buyPlan: () {
                              Get.to(
                                  PackageCheckoutScreen(
                                      packageData: packageData),
                                  transition: Transition.rightToLeft);
                            },
                            detaile: Column(
                              children: [
                                GarmentText(
                                  title: 'Routine Garments :',
                                  qty: data[index].routineGarments!,
                                  icon: data[index].routineGarments == '0'
                                      ? Icons.close
                                      : Icons.check,
                                ),
                                GarmentText(
                                  title: 'Ironing :',
                                  qty: data[index].ironing!,
                                  icon: data[index].ironing == '0'
                                      ? Icons.close
                                      : Icons.check,
                                ),
                                GarmentText(
                                  title: 'Steam Ironing :',
                                  qty: data[index].steamIroning!,
                                  icon: data[index].steamIroning == '0'
                                      ? Icons.close
                                      : Icons.check,
                                ),
                                GarmentText(
                                  title: 'Wash + Ironing :',
                                  qty: data[index].washIroning!,
                                  icon: data[index].washIroning! == '0'
                                      ? Icons.close
                                      : Icons.check,
                                ),
                                GarmentText(
                                  title: 'Dry Cleaning :',
                                  qty: data[index].dryCleaning!,
                                  icon: data[index].dryCleaning! == '0'
                                      ? Icons.close
                                      : Icons.check,
                                ),
                                GarmentText(
                                  title: 'No. of Free Pickup :',
                                  qty: data[index].freeDelivery!,
                                  icon: Icons.check,
                                ),
                                // Height(15),
                                const Divider()
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  // return LoadingAnimationWidget.fourRotatingDots(
                  //   color: AppColor.primaryColor2,
                  //   size: 20,
                  // );
                  return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.all(10),
                      child: LoadingPackageBox(),
                    ),
                  );
                }
              })),
    );
  }
}

class PackageBox extends StatefulWidget {
  final String title;
  final String code;
  final String pricing;
  final String validity;
  final String garments;
  final Function buyPlan;
  final Widget detaile;
  const PackageBox(
      {super.key,
      required this.title,
      required this.pricing,
      required this.validity,
      required this.garments,
      required this.buyPlan,
      required this.code,
      required this.detaile});

  @override
  State<PackageBox> createState() => _PackageBoxState();
}

class _PackageBoxState extends State<PackageBox> {
  bool isVisibal = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: const Color(0xFFf8f9fe),
        gradient: const LinearGradient(colors: [
          Color(0xFF2f7ae5),
          Color.fromARGB(255, 18, 112, 245),
          Color.fromARGB(255, 39, 95, 173),
        ]),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(29, 185, 185, 185),
            blurRadius: 6.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmallText(
                        text: widget.title,
                        size: 18,
                        color: Colors.white,
                        fontweights: FontWeight.w500,
                      ),
                      const Height(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SmallText(
                            text: 'Package code :',
                            //'₹1,575 / Months',
                            size: 11,
                            color: Colors.white,
                          ),
                          SmallText(
                            text: widget.code,
                            size: 11,
                            color: Colors.white,
                            fontweights: FontWeight.w400,
                          ),
                        ],
                      ),
                      const Height(4),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      widget.buyPlan();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: AppColor.backgroundColor, width: 0.3),
                            //color: const Color.fromARGB(40, 219, 219, 219),
                            color: AppColor.backgroundColor),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SmallText(
                              text: 'Buy Plan',
                              // color: const Color.fromARGB(255, 251, 255, 3),
                              color: AppColor.primaryColor1,
                              fontweights: FontWeight.w500,
                            ))),
                  ),
                ],
              ),
            ),
            Container(
              height: isVisibal ? size.height / 2.5 : size.height / 6.5,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: AppColor.boxColor,
              ),
              child: Column(
                children: [
                  const Height(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PackagePlanText(
                        title: widget.pricing,
                        subtitle: 'Pricing',
                      ),
                      PackagePlanText(
                        title: widget.validity,
                        subtitle: 'Validity',
                      ),
                      PackagePlanText(
                        title: widget.garments,
                        subtitle: 'Garments',
                      ),
                    ],
                  ),
                  const Height(15),
                  const Divider(),
                  Visibility(
                    visible: isVisibal,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: widget.detaile,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisibal = !isVisibal;
                      });
                      print(isVisibal);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SmallText(
                            text: 'view details',
                            size: 12,
                            color: AppColor.primaryColor2,
                            // fontweights: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          isVisibal
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColor.primaryColor2,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GarmentText extends StatelessWidget {
  final String title;
  final String qty;
  final IconData icon;

  const GarmentText({
    super.key,
    required this.title,
    required this.qty,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SmallText(
              text: title,
              color: Colors.black,
              fontweights: FontWeight.w400,
            ),
          ),
          Expanded(
            child: Icon(
              icon,
              color: icon == Icons.check
                  ? Colors.green
                  : const Color.fromARGB(190, 255, 28, 12),
              size: 20,
            ),
          ),
          Expanded(child: SmallText(text: qty)),
        ],
      ),
    );
  }
}

class PackagePlanText extends StatelessWidget {
  final String title;
  final String subtitle;
  const PackagePlanText({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SmallText(
          text: title,
          size: 16,
          color: Colors.black,
          fontweights: FontWeight.w500,
        ),
        const Height(5),
        SmallText(
          text: subtitle,
          size: 11,
          color: Colors.grey,
          fontweights: FontWeight.w400,
        ),
      ],
    );
  }
}

class LoadingPackageBox extends StatelessWidget {
  const LoadingPackageBox({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color.fromARGB(244, 232, 232, 232),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 20,
                            width: 150,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Color.fromARGB(174, 245, 245, 245),
                            ),
                          ),
                        ],
                      ),
                      const Height(4),
                      Container(
                        height: 8,
                        width: 80,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color.fromARGB(174, 245, 245, 245),
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(8),
                  //   border: Border.all(
                  //       color: AppColor.backgroundColor, width: 0.3),
                  //   color: const Color.fromARGB(40, 219, 219, 219),
                  // ),
                  // child:
                  Container(
                    height: 35,
                    width: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color.fromARGB(174, 245, 245, 245),
                    ),
                  )
                  // ),
                ],
              ),
            ),
            Container(
              height: size.height / 6.5,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Color.fromARGB(174, 245, 245, 245),
              ),
              child: Column(
                children: [
                  const Height(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 35,
                        width: 80,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color.fromARGB(174, 245, 245, 245),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 80,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color.fromARGB(174, 245, 245, 245),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 80,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color.fromARGB(174, 245, 245, 245),
                        ),
                      )
                    ],
                  ),
                  const Height(15),
                  const Divider(),
                  const Height(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 13,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: Colors.grey[100],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
