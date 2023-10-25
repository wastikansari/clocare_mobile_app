import 'dart:async';
import 'package:clocare/backend/api/address_api.dart';
import 'package:clocare/backend/api/order_api.dart';
import 'package:clocare/routes/routes.dart';
import 'package:clocare/screen/basket/steps/address_page.dart';
import 'package:clocare/screen/home/steper/order_summary_page.dart';
import 'package:clocare/screen/home/steper/payment_page.dart';
import 'package:clocare/screen/home/steper/time_slot_page.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/bottom_navigation_btn.dart';
import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/screen/widget/custom_dialog.dart';
import 'package:clocare/utiles/app_asset.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:stepper_a/stepper_a.dart';
import '../widget/custom_text_field.dart';

class ServiceDetailScreen extends StatefulWidget {
  final String serviceName;
  final int serviceId;
  const ServiceDetailScreen(
      {super.key, required this.serviceName, required this.serviceId});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  final StepperAController controller = StepperAController();
  AddressApi addressApi = AddressApi();
  OrderApi orderApi = OrderApi();
  int isSelectAddress = -1;
  bool isVisibal = false;
  int _counter = 0;
  String currentMonthe = '';
  int isSelectPickupDate = 0;
  int isSelectTimePickupSlot = 1;
  int isSelectDeliverDate = 1;
  String pickupformatAddress = '';
  var addressId = '';
  Map timeslotData = {};
  int? selectedOption;
  // int isSelectTimePickupSlot = 1;
  final TextEditingController _textEditingController = TextEditingController();
  int indec = 0;

  List<DateTime> pickupDate = [];
  List<DateTime> deliverDate = [];

  List<Map<String, dynamic>> clothePics = [];

  String payType = '';
  bool isLoading = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    pickupformatAddress = '';
    super.dispose();
  }

  orderPlace() async {
    setState(() {
      isLoading = true;
    });
    const String orderType = 'Service order';
    final int serviceId = widget.serviceId;
    final String serviceName = widget.serviceName;
    final int items = int.parse(_textEditingController.text.trim());
    final String paymentType = payType;
    const String paymentStatus = 'Unpaid';
    final String pickupDate = timeslotData['pickup_date'];
    final String pickupTime = timeslotData['pickup_time'];
    final String deliveryDate = timeslotData['Delivery_date'];
    final String deliveryTime = timeslotData['Delivery_time'];
    var pickupAddressId = addressId;
    const String ordStatus = 'order place';

    print('DDDDDDDDDDDDDDDDD $pickupAddressId');

    await orderApi
        .serviceOrderCreate(
            orderType,
            serviceId,
            serviceName,
            items,
            paymentType,
            paymentStatus,
            pickupDate,
            pickupTime,
            deliveryDate,
            deliveryTime,
            pickupAddressId,
            ordStatus)
        .then(
      (value) {
        if (value.status == true) {
          String msg = value.msg.toString();
          setState(() {
            isLoading = false;
          });

          orderPlaceSucessfulMsg(msg);
          Timer(const Duration(seconds: 3), () {
            Get.toNamed(Routes.bottomNavigation);
          });
        } else {
          setState(() {
            isLoading = false;
          });
          errorBox();
        }
        print('ddddddddddddddddddddddddddddddddddddddddd ${value.msg}');
        setState(() {
          isLoading = false;
        });
      },
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
    return CustomFold(
      appBar: widget.serviceName,
      isShowBack: true,
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
              borderType: BorderType.straight,
              stepperAxis: Axis.horizontal,
              lineType: LineType.dotted,
              stepperBackgroundColor: Colors.transparent,
              stepperAController: controller,
              stepHeight: 35,
              stepWidth: 35,
              stepBorder: true,
              pageSwipe: false,
              formValidation: true,
              customSteps: const [
                CustomSteps(stepsIcon: IconlyLight.buy, title: "Order"),
                CustomSteps(
                    stepsIcon: Icons.location_on_outlined, title: "Address"),
                CustomSteps(stepsIcon: Icons.history, title: "P/D slot"),
                CustomSteps(stepsIcon: Icons.outbox_rounded, title: "Details"),
                CustomSteps(stepsIcon: Icons.wallet, title: "   pay"),
              ],
              stepperBodyWidget: [
                stepAddClothes(),
                AddressPage(
                  callback: (data) {
                    pickupformatAddress = data['addressName'];
                    addressId = data['addressId'];
                    print('adresss $pickupformatAddress');
                  },
                ),
                TimeSlotPage(
                  callback: (data) {
                    timeslotData = data;
                    print('slotsss $data');
                  },
                ),
                stepOrderSummary(),
                // const StepOrderPaymentPage(),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       bottom: 15, top: 35, left: 15, right: 15),
                //   child: Column(
                //     children: [
                //       const Height(30),
                //       Container(
                //           height: 200,
                //           width: double.infinity,
                //           decoration: BoxDecoration(
                //             color: AppColor.boxColor,
                //             borderRadius: BorderRadius.circular(10),
                //             border: Border.all(color: Colors.white, width: 2),
                //             // color: const Color(0xFFF9F8FF),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: AppColor.boxShadowColor,
                //                 blurRadius: 4.0,
                //                 spreadRadius: 2.0,
                //                 offset: const Offset(0.0, 0.0),
                //               )
                //             ],
                //           ),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.all(20),
                //                 child: SmallText(
                //                   text: 'SELECT PAY ON',
                //                   color:
                //                       const Color.fromARGB(255, 155, 162, 207),
                //                   fontweights: FontWeight.w500,
                //                 ),
                //               ),
                //               const Height(10),
                //               ListTile(
                //                 title: SmallText(
                //                   text: 'Pay on Pickup',
                //                   size: 14,
                //                 ),
                //                 leading: Radio(
                //                   value: 1,
                //                   toggleable: true,
                //                   groupValue: selectedOption,
                //                   onChanged: (value) {
                //                     if (_formKey.currentState!.validate()) {
                //                       ScaffoldMessenger.of(context)
                //                           .showSnackBar(
                //                         const SnackBar(
                //                             content: Text('Processing Data')),
                //                       );
                //                     }
                //                     print('pay $selectedOption and $value');
                //                     setState(() {
                //                       selectedOption = value!;
                //                     });
                //                     print('pay $selectedOption and $value');
                //                   },
                //                 ),
                //               ),
                //               ListTile(
                //                 title: SmallText(
                //                   text: 'Pay on Delivery',
                //                   size: 14,
                //                 ),
                //                 leading: Radio(
                //                   value: 2,
                //                   groupValue: selectedOption,
                //                   onChanged: (value) {
                //                     setState(() {
                //                       selectedOption = value!;
                //                     });
                //                     print('pay $selectedOption and $value');
                //                   },
                //                 ),
                //               ),
                //             ],
                //           )),
                //     ],
                //   ),
                // )
                PaymentPage(
                  callback: (value) {
                    payType = value;
                    print('slotsss $payType');
                  },
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBtn(
        backOntap: () {
          controller.back(
            onTap: (currentIndex) {
              print('Back currentIndex top $currentIndex');
            },
          );
        },
        nextOntap: () {
          controller.next(
            onTap: (currentIndex) {
              print('currentIndex top $currentIndex');
              switch (currentIndex) {
                case 0:
                  // ignore: unnecessary_null_comparison
                  if (_textEditingController.text.isEmpty) {
                    controller.back(
                      onTap: (currentIndex) {
                        print('currentIndex 0 back  $currentIndex');
                      },
                    );
                    break;
                  } else {
                    controller.next(
                      onTap: (currentIndex) {
                        print('currentIndex 0 next $currentIndex');
                      },
                    );
                    break;
                  }

                case 1:
                  if (pickupformatAddress.isEmpty) {
                    showCustomSnackBar(
                        title: 'Address', "Select your pickup address");
                    controller.back(
                      onTap: (currentIndex) {
                        print('currentIndex add 1 $currentIndex');
                      },
                    );
                    break;
                  } else {
                    controller.next(
                      onTap: (currentIndex) {
                        print('currentIndex next $currentIndex ');
                      },
                    );
                  }
                  print('currentIndex $currentIndex and $pickupformatAddress');
                case 2:
                  controller.next(
                    onTap: (currentIndex) {
                      setState(() {
                        print('currentIndex 2 $currentIndex');
                      });
                    },
                  );
                  break;
                case 4:
                  if (payType.isEmpty) {
                    showCustomSnackBar(
                        title: 'Payment Option',
                        "Please select payment option");
                    controller.back(
                      onTap: (currentIndex) {
                        print('currentIndex pay 4 $currentIndex');
                      },
                    );
                    break;
                  } else {
                    controller.next(
                      onTap: (currentIndex) {
                        confermationBox();

                        print('currentIndex 4 $currentIndex');
                      },
                    );
                    break;
                  }
                default:
                  controller.next(
                    onTap: (currentIndex) {
                      print('default call $currentIndex');
                    },
                  );
              }
            },
          );
        },
      ),
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
          height: 60,
          child: Column(
            children: [
              SmallText(
                text:
                    'You order will be delivered on ${timeslotData['Delivery_date']}',
                overFlow: TextOverflow.visible,
                color: AppColor.appBarColor,
              ),
              SmallText(
                text: 'Do you want to proceed with provided information?',
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
                text: 'Confirm',
                bg: AppColor.primaryColor1,
                textColor: Colors.white,
                onTap: () {
                  Navigator.pop(context, 'OK');
                  orderPlace();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  errorBox() {
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
        title: const Text('Oopps!'),
        content: SizedBox(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallText(
                text:
                    'You cannot place the same service order on the same day, you have already placed this order',
                overFlow: TextOverflow.visible,
                color: AppColor.appBarColor,
              ),
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
                text: 'Ok',
                bg: AppColor.primaryColor1,
                textColor: Colors.white,
                onTap: () {
                  Get.toNamed(Routes.bottomNavigation);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget stepAddClothes() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Height(20),
            Container(
              // height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.boxColor,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
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
                                text: widget.serviceName,
                                size: 15,
                                color: AppColor.appBarColor,
                                fontweights: FontWeight.bold,
                              ),
                              const Height(3),
                              SmallText(
                                text: '$_counter items',
                                color: _counter == 0
                                    ? Colors.grey
                                    : AppColor.primaryColor1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Height(30),
                      SmallText(
                        text: 'No of Clothes',
                        fontweights: FontWeight.bold,
                        color: AppColor.appBarColor,
                        size: 15,
                      ),
                      const Height(4),
                      SmallText(
                        text: "Count clothes and enter below",
                        color: Colors.grey,
                        size: 10,
                      ),
                      const Height(15),
                      CustomTextField(
                        labelText: 'No fo clothes',
                        keyboardType: TextInputType.phone,
                        controller: _textEditingController,
                        readOnlys: false,
                        // suffix: SmallText(
                        //   text: 'verify',
                        //   color: Colors.blueAccent,
                        //   fontweights: FontWeight.bold,
                        // ),
                        onChanged: (valu) {
                          setState(() {
                            _counter = int.parse(valu!);
                          });
                        },
                        hintTexts: 'e.g 12',
                        validator: (value) {
                          print('dddddddddddd $value');
                          if (value == null || value.isEmpty) {
                            // showCustomSnackBar(
                            //     title: 'Clothes',
                            //     'Please enter total number of clothes');
                            return 'Enter total number of clothes';
                          } else if (int.parse(value) > 5) {
                            return null;
                          } else {
                            showCustomSnackBar(
                                title: 'Clothes',
                                'Enter number of clothes minimum 5+');
                            return '';
                          }
                        },
                      ),
                      //  Row(
                      //   children: [
                      //     Expanded(
                      //       child: ButtonAdd(
                      //         icon: Icons.add_circle,
                      //         onTap: (){},
                      //       ),
                      //     ),
                      //     const Widths(15),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Container(
                      //         width: double.infinity,
                      //         height: size.height * 0.05,
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           boxShadow: const [
                      //             BoxShadow(
                      //               color: Color.fromARGB(255, 244, 244, 244),
                      //               blurRadius: 1.0,
                      //               spreadRadius: 1.0,
                      //               offset: Offset(
                      //                 1.0,
                      //                 1.0,
                      //               ),
                      //             ),
                      //           ],
                      //           border: Border.all(
                      //               color: const Color.fromARGB(
                      //                   255, 221, 221, 221)),
                      //           borderRadius: const BorderRadius.all(
                      //             Radius.circular(7),
                      //           ),
                      //         ),
                      //         child: Row(
                      //           children: [
                      //             Expanded(
                      //               child: TextFormField(
                      //                 // autofocus: true,
                      //                 textAlign: TextAlign.center,
                      //                 textAlignVertical:
                      //                     TextAlignVertical.center,
                      //                 controller: _textEditingController,
                      //                 onChanged: _manualInput,
                      //                 validator: (value) {
                      //                   print('dddddddddddd $value');
                      //                   if (value == null || value.isEmpty) {
                      //                     showCustomSnackBar(
                      //                         title: 'Clothes',
                      //                         'Please enter total number of clothes');
                      //                     return '';
                      //                   } else if (int.parse(value!) > 5) {
                      //                     return null;
                      //                   } else {
                      //                     showCustomSnackBar(
                      //                         title: 'Clothes',
                      //                         'Enter number of clothes minimum 5');
                      //                     return '';
                      //                   }
                      //                 },
                      //                 style: TextStyle(
                      //                     color: AppColor.primaryColor1,
                      //                     fontSize: 15,
                      //                     fontWeight: FontWeight.w500),
                      //                 textInputAction: TextInputAction.next,
                      //                 keyboardType: TextInputType.number,
                      //                 decoration: const InputDecoration(
                      //                   hintStyle: TextStyle(
                      //                     fontSize: 10,
                      //                     color: Color(0xffADA4A5),
                      //                   ),
                      //                   border: InputBorder.none,
                      //                   hintText: 'Number of Clothes',
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     const Widths(15),
                      //     Expanded(
                      //       child: ButtonAdd(
                      //         icon: Icons.remove_circle,
                      //         onTap: _decrementCounter,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ]),
              ),
            ),
            const Height(20),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.boxColor,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.rateCard);
                      },
                      child: Center(
                          child: SmallText(
                        text: 'View Rate card',
                        fontweights: FontWeight.w500,
                        color: AppColor.primaryColor1,
                      )))),
            ),
          ],
        ),
      ),
    );
  }

  Widget stepOrderSummary() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 35, left: 15, right: 15),
      child: OrderSummaryPage(
        serviceName: widget.serviceName,
        items: '${_textEditingController.text} items',
        address: pickupformatAddress,
        pickupDate: timeslotData['pickup_date'] ?? '',
        pickupTime: timeslotData['pickup_time'] ?? '',
        deliverDate: timeslotData['Delivery_date'] ?? '',
        deliverTime: timeslotData['Delivery_time'] ?? '',
      ),
    );
  }
}

class AletBtn extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color? bg;
  final Function onTap;

  const AletBtn({
    super.key,
    required this.text,
    this.bg,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColor.backgroundColor, width: 1),
          // color: const Color(0xFFF9F8FF),
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColor.boxShadowColor,
          //     blurRadius: 4.0,
          //     spreadRadius: 2.0,
          //     offset: const Offset(0.0, 0.0),
          //   )
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: SmallText(
              text: text,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonAdd extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  const ButtonAdd({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
        border: Border.all(color: const Color.fromARGB(255, 221, 221, 221)),
        borderRadius: const BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: InkWell(
            onTap: () {
              onTap();
            },
            child: Icon(
              icon,
              color: Colors.grey,
            )),
      ),
    );
  }
}
