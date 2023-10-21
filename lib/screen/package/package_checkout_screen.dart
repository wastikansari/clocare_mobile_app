import 'package:clocare/screen/basket/steps/address_page.dart';
import 'package:clocare/screen/home/steper/payment_page.dart';
import 'package:clocare/screen/package/package_screen.dart';
import 'package:clocare/screen/package/stepper/package_details_page.dart';
import 'package:clocare/screen/package/stepper/package_first_page.dart';
import 'package:clocare/screen/package/stepper/package_payment_page.dart';
import 'package:clocare/screen/package/stepper/pickup_slot_page.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/bottom_navigation_btn.dart';
import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/screen/widget/whatsapp_btn.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:stepper_a/stepper_a.dart';
import '../../backend/model/package_model.dart';
import '../../utiles/themes/ColorConstants.dart';

// ignore: must_be_immutable
class PackageCheckoutScreen extends StatefulWidget {
  final Data packageData;
  const PackageCheckoutScreen({super.key, required this.packageData});

  @override
  State<PackageCheckoutScreen> createState() => _PackageCheckoutScreenState();
}

class _PackageCheckoutScreenState extends State<PackageCheckoutScreen> {
  StepperAController controller = StepperAController();

  String pickupformatAddress = '';

  Map pickupSlotData = {};

  var startDate = '';
  var endDate = '';
  var payType = '';
    double totalBill = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime currentDate = DateTime.now();
    DateTime expirationDate =DateTime(currentDate.year, currentDate.month + 1, currentDate.day);

    setState(() {
      startDate = DateFormat('dd-MMM-yyyy').format(currentDate);
      endDate = DateFormat('dd-MMM-yyyy').format(expirationDate);
    });
  }



  @override
  Widget build(BuildContext context) {
    print('dddddddddddddddddddddddd $startDate and $endDate');
    return CustomFold(
        appBar:
            '${widget.packageData.packageName.toString()} (${widget.packageData.packageCode.toString()})',
        isShowBack: true,
        leading: const WhatsappBtn(),
        bodys: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Height(20),
            Expanded(
              child: StepperA(
                stepperSize: const Size(350, 80),
                borderShape: BorderShape.circle,
                stepperAxis: Axis.horizontal,
                lineType: LineType.dotted,
                stepperBackgroundColor: Colors.transparent,
                stepHeight: 35,
                stepWidth: 35,
                stepBorder: true,
                pageSwipe: true,
                formValidation: true,
                stepperAController: controller,
                customSteps: const [
                  CustomSteps(stepsIcon: IconlyLight.buy, title: "Package"),
                  CustomSteps(
                      stepsIcon: Icons.location_on_outlined, title: "Address"),
                  CustomSteps(stepsIcon: Icons.history, title: "P/D Slot"),
                  CustomSteps(
                      stepsIcon: Icons.outbox_rounded, title: "Details"),
                  CustomSteps(stepsIcon: Icons.wallet, title: "Payment"),
                ],
                step: StepA(
                    currentStepColor: Colors.green,
                    completeStepColor: AppColor.primaryColor1,
                    inactiveStepColor: Colors.black54,
                    // loadingWidget: CircularProgressIndicator(color: Colors.green,),
                    margin: const EdgeInsets.all(5)),
                stepperBodyWidget: [
                  packagePlan(packageData: widget.packageData),
                  AddressPage(
                    callback: (data) {
                      pickupformatAddress = data['addressName'];
                      print('addddddddddddddr $data');
                    },
                  ),
                  PickupSlot(
                    callback: (data) {
                      pickupSlotData = data;

                      print('slotsss $data');
                    },
                  ),
                  PackageDetailsPage(
                    package: widget.packageData,
                    address: pickupformatAddress,
                    pickupSlotData: pickupSlotData,
                    startDate: startDate,
                    endDate: endDate,
                  ),
                   PackagePaymentPage(
                  callback: (value) {
                    payType = value;
                    print('pppppppppp $payType');
                  },
                  amount: totalBill.toString(),
                ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBtn(backOntap: () {
          print(
              'data back and ${pickupSlotData['pickup_day']} and ${pickupSlotData['pickup_time']} and ${pickupSlotData['delivery']} ');
          controller.back(
            onTap: (currentIndex) {
              print('ttttttt $currentIndex');
            },
          );
        }, nextOntap: () {
          controller.next(
            onTap: (currentIndex) {
              print('currentIndex top $currentIndex');
              setState(() {});
              switch (currentIndex) {
                case 0:
                  controller.next(
                    onTap: (currentIndex) {},
                  );
                  print('currentIndex $currentIndex and 0');
                  break;
                case 1:
                  controller.next(
                    onTap: (currentIndex) {},
                  );
                  print('currentIndex $currentIndex and 1');
                case 2:
                  print('call 1 $currentIndex');
                  if (pickupSlotData['pickup_day'] == null ||
                      pickupSlotData['pickup_day'] == '') {
                    showCustomSnackBar(
                        title: 'Pickup Day', 'Please select pickup Day');
                    controller.back(
                      onTap: (currentIndex) {},
                    );

                    print(
                        'call 2 $currentIndex and ${pickupSlotData['pickup_day']} and ${pickupSlotData['pickup_time']} and ${pickupSlotData['delivery']} ');
                  } else if (pickupSlotData['pickup_time'] == null ||
                      pickupSlotData['pickup_time'] == '') {
                    showCustomSnackBar(
                        title: 'Pickup Time', 'Please select pickup time');
                    print(
                        'call 3 $currentIndex and ${pickupSlotData['pickup_day']} and ${pickupSlotData['pickup_time']} and ${pickupSlotData['delivery']} ');
                    controller.back(
                      onTap: (currentIndex) {},
                    );
                  } else if (pickupSlotData['delivery'] == null ||
                      pickupSlotData['delivery'] == '') {
                    showCustomSnackBar(
                        title: 'Delivery', 'Please select delivery type');
                    print(
                        'call 4 $currentIndex and ${pickupSlotData['pickup_day']} and ${pickupSlotData['pickup_time']} and ${pickupSlotData['delivery']} ');
                    controller.back(
                      onTap: (currentIndex) {},
                    );
                  } else {
                    controller.next(
                      onTap: (currentIndex) {},
                    );
                  }
                default:
                  controller.next(
                    onTap: (currentIndex) {},
                  );
              }

              // if (timeslotData['pickup_day'] == null && timeslotData['pickup_slot'] == null && currentIndex == 2) {
              //   showCustomSnackBar(title: 'Pickup Day','Please select pickup Day and Time');
              //   print('pdddddddddddd ${timeslotData['pickup_day'] == null} and ${timeslotData['pickup_slot'] ==null}  and ${currentIndex == 2}}');
              //   controller.back(
              //     onTap: (currentIndex) {},
              //   );
              // }
              //  print('pdddddddddddd ${timeslotData['pickup_day'] == null} and ${timeslotData['pickup_slot'] ==null}  and ${currentIndex == 2}}');
              // else if (timeslotData['pickup_slot'] == null &&
              //     currentIndex == 2) {
              //   showCustomSnackBar(
              //       title: 'Pickup Time',
              //       'Please select pickup time');
              //   controller.back(
              //     onTap: (currentIndex) {},
              //   );
              // }
            },
          );
        }));
  }
}

class PackBox extends StatelessWidget {
  final String title;
  final String value;
  const PackBox({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmallText(
          text: title,
          color: AppColor.backgroundColor,
        ),
        SmallText(text: value, color: AppColor.backgroundColor),
      ],
    );
  }
}

class PackageCheckoutBox extends StatefulWidget {
  final String title;
  final String code;
  final String pricing;
  final String validity;
  final String garments;
  final Function buyPlan;
  final Widget detaile;
  const PackageCheckoutBox(
      {super.key,
      required this.title,
      required this.pricing,
      required this.validity,
      required this.garments,
      required this.buyPlan,
      required this.code,
      required this.detaile});

  @override
  State<PackageCheckoutBox> createState() => _PackageCheckoutBoxState();
}

class _PackageCheckoutBoxState extends State<PackageCheckoutBox> {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SmallText(
                            text: widget.title,
                            size: 18,
                            color: Colors.white,
                            fontweights: FontWeight.w500,
                          ),
                          SmallText(
                            text: widget.code,
                            size: 14,
                            color: Colors.white,
                            fontweights: FontWeight.w400,
                          ),
                        ],
                      ),
                      const Height(4),
                      SmallText(
                        text: 'Package',
                        //'₹1,575 / Months',
                        size: 10,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: size.height / 2.5,
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
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: widget.detaile,
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
