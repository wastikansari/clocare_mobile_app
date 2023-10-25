import 'package:clocare/backend/api/package_api.dart';
import 'package:clocare/routes/routes.dart';
import 'package:clocare/screen/basket/steps/address_page.dart';
import 'package:clocare/screen/home/service_details_screen.dart';
import 'package:clocare/screen/package/package_screen.dart';
import 'package:clocare/screen/package/stepper/package_details_page.dart';
import 'package:clocare/screen/package/stepper/package_first_page.dart';
import 'package:clocare/screen/package/stepper/package_payment_page.dart';
import 'package:clocare/screen/package/stepper/pickup_slot_page.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/bottom_navigation_btn.dart';
import 'package:clocare/screen/widget/custom_dialog.dart';
import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/screen/widget/whatsapp_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
  PackageApi packageApi = PackageApi();

  String pickupformatAddress = '';
  String pickupAddressId = '';
  Map pickupSlotData = {};
  var startDate = '';
  var endDate = '';
  var payType = '';
  double walletBalance = 0;
  double totalBill = 0;
  String selectPaymentType = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime currentDate = DateTime.now();
    DateTime expirationDate =
        DateTime(currentDate.year, currentDate.month + 1, currentDate.day);

    setState(() {
      totalBill = double.parse(widget.packageData.prices.toString());
      startDate = DateFormat('dd-MMM-yyyy').format(currentDate);
      endDate = DateFormat('dd-MMM-yyyy').format(expirationDate);
    });
  }

  buyPackage() async {
    String packageId = widget.packageData.sId.toString();
    String addressId = pickupAddressId;
    String pickupAddress = pickupformatAddress;
    String email = '';
    String packageValid = widget.packageData.valid.toString();
    String packagePrices = widget.packageData.prices.toString();
    String pickupDay = pickupSlotData['pickup_day'];
    String pickupSlot = pickupSlotData['pickup_time'];
    String delivery = pickupSlotData['delivery'];
    String amountPay = '1575';
    String paymentStatus = 'Paid';
    String paymentType = selectPaymentType;
    String transactionId = 'WAS23434';

    await packageApi
        .packageBuy(
            packageId,
            addressId,
            pickupAddress,
            email,
            packageValid,
            packagePrices,
            pickupDay,
            pickupSlot,
            delivery,
            amountPay,
            paymentStatus,
            paymentType,
            transactionId)
        .then(
      (value) {
        if (value == true) {
          String msg = value.msg.toString();
          orderPlaceSucessfulMsg(msg);
        }
      },
    );
  }

  confermationBox() {
    print('dddddddddddddddddddddd');
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: AppColor.boxColor,
        // shape: Border.all(color: Colors.white),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        elevation: 10,
        title: const Text('Proceed'),
        content: SizedBox(
          height: 80,
          child: Column(
            children: [
              SmallText(
                text: 'Are you sure you want to buy this package ${widget.packageData.packageName.toString()}?',
                overFlow: TextOverflow.visible,
                color: AppColor.appBarColor,
              ),
              const Height(10),
              SmallText(
                text: 'The amount is non-refundable once you purchase this package.',
                overFlow: TextOverflow.visible,
                color: AppColor.appBarColor,
              )
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AletBtn(
                text: 'Cancel',
                bg: AppColor.backgroundColor,
                textColor: AppColor.appBarColor,
                onTap: () => Navigator.pop(context, 'OK'),
              ),
              AletBtn(
                text: 'Pay',
                bg: AppColor.primaryColor1,
                textColor: Colors.white,
                onTap: () {
                  Navigator.pop(context, 'OK');
                  buyPackage();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  orderPlaceSucessfulMsg(msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        image: Lottie.asset('asset/svg/success_icon.json', height: 300),
        title: "Thank You",
        description: msg,
        buttonText: "Order Tracking",
        buttonTap: () {
          Get.toNamed(Routes.bottomNavigation);
        },
      ),
    );
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
                step: StepA(
                    currentStepColor: Colors.green,
                    completeStepColor: AppColor.primaryColor1,
                    inactiveStepColor: AppColor.primaryColorDark,
                    // loadingWidget: CircularProgressIndicator(color: Colors.green,),
                    margin: const EdgeInsets.all(5)),
                stepperSize: const Size(360, 100),
                borderShape: BorderShape.circle,
                stepperAxis: Axis.horizontal,
                lineType: LineType.dotted,
                stepperBackgroundColor: Colors.transparent,
                stepHeight: 35,
                stepWidth: 35,
                stepBorder: true,
                pageSwipe: false,
                formValidation: true,
                stepperAController: controller,
                customSteps: const [
                  CustomSteps(stepsIcon: IconlyLight.buy, title: "Orders"),
                  CustomSteps(
                      stepsIcon: Icons.location_on_outlined, title: "Address"),
                  CustomSteps(stepsIcon: Icons.history, title: "P/D slot"),
                  CustomSteps(
                      stepsIcon: Icons.outbox_rounded, title: "Details"),
                  CustomSteps(stepsIcon: Icons.wallet, title: "   pay"),

                  // CustomSteps(stepsIcon: IconlyLight.buy, title: "Package"),
                  // CustomSteps(
                  //     stepsIcon: Icons.location_on_outlined, title: "Address"),
                  // CustomSteps(stepsIcon: Icons.history, title: "P/D Slot"),
                  // CustomSteps(
                  //     stepsIcon: Icons.outbox_rounded, title: "Details"),
                  // CustomSteps(stepsIcon: Icons.wallet, title: "   Pay"),
                ],
                stepperBodyWidget: [
                  packagePlan(packageData: widget.packageData),
                  AddressPage(
                    callback: (data) {
                      pickupformatAddress = data['addressName'];
                      pickupAddressId = data['addressId'];
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
                    callback: (data) {
                      payType = data['selectPayType'];
                      selectPaymentType = data['selectPayType'];
                      walletBalance = data['wallet_balances'];
                      print(
                          'pppppppppp $payType and $walletBalance and pac $totalBill');
                    },
                    amount: totalBill.toString(),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBtn(backOntap: () {
          controller.back(
            onTap: (currentIndex) {
              print('ttttttt $currentIndex');
            },
          );
        }, nextOntap: () {
          controller.next(
            onTap: (currentIndex) {
              setState(() {});
              switch (currentIndex) {
                case 0:
                  controller.next(
                    onTap: (currentIndex) {},
                  );

                  break;
                case 1:
                  if (pickupAddressId.isNotEmpty) {
                    controller.next(
                      onTap: (currentIndex) {},
                    );
                  } else {
                    showCustomSnackBar(
                        title: 'Address', 'Please select pickup address');
                    controller.back(
                      onTap: (currentIndex) {},
                    );
                  }

                case 2:
                  if (pickupSlotData['pickup_day'] == null ||
                      pickupSlotData['pickup_day'] == '') {
                    showCustomSnackBar(
                        title: 'Pickup Day', 'Please select pickup Day');
                    controller.back(
                      onTap: (currentIndex) {},
                    );
                  } else if (pickupSlotData['pickup_time'] == null ||
                      pickupSlotData['pickup_time'] == '') {
                    showCustomSnackBar(
                        title: 'Pickup Time', 'Please select pickup time');

                    controller.back(
                      onTap: (currentIndex) {},
                    );
                  } else if (pickupSlotData['delivery'] == null ||
                      pickupSlotData['delivery'] == '') {
                    showCustomSnackBar(
                        title: 'Delivery', 'Please select delivery type');

                    controller.back(
                      onTap: (currentIndex) {},
                    );
                  } else {
                    controller.next(
                      onTap: (currentIndex) {},
                    );
                  }

                case 4:
                  if (selectPaymentType.isEmpty) {
                    print('case 4 $selectPaymentType');
                    showCustomSnackBar(
                        title: 'Payment Option',
                        'Please select payment option');
                    controller.back(
                      onTap: (currentIndex) {},
                    );
                  } else if (selectPaymentType == 'Wallet pay') {
                    showCustomSnackBar(
                        title: 'Wallet', 'Your wallet balance is low');
                  } else {
                    confermationBox();
                  }
                default:
                  controller.next(
                    onTap: (currentIndex) {},
                  );
              }
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
          size: 14,
        ),
        SmallText(
          text: value,
          color: AppColor.backgroundColor,
          size: 14,
        ),
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
