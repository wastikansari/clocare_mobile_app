import 'dart:async';
import 'package:clocare/backend/api/order_api.dart';
import 'package:clocare/routes/routes.dart';
import 'package:clocare/screen/basket/steps/basket_page.dart';
import 'package:clocare/screen/basket/steps/basket_payment_page.dart';
import 'package:clocare/screen/home/service_details_screen.dart';
import 'package:clocare/screen/home/steper/order_summary_page.dart';
import 'package:clocare/screen/home/steper/time_slot_page.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/custom_dialog.dart';
import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:stepper_a/stepper_a.dart';
import 'steps/address_page.dart';

class BasketCheckOutScreen extends StatefulWidget {
  // final bool visible;
  const BasketCheckOutScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BasketCheckOutScreen> createState() => _BasketCheckOutScreenState();
}

class _BasketCheckOutScreenState extends State<BasketCheckOutScreen> {
  final basketBox = Hive.box('basketBox');
  final StepperAController basketController = StepperAController();
  OrderApi orderApi = OrderApi();
  Map timeslotData = {};
  bool isVisibal = false;
  TextEditingController couponCode = TextEditingController();
  bool isApply = false;
  bool isLoading = false;
  var pickupAddress = '';
  String selectAddressId = '';
  String totalPrice = '';
  int itemss = 0;
  int service = 0;
  int deliveryCharges = 0;
  int discount = 0;
  double totalBill = 0;
  String garmnentList = '';
  String payType = '';
  List serviceName = [];

  getData() {
    var data = basketBox.get('BASKETLIST')[1];
    var dataList = basketBox.get('BASKETLIST')[0];
    print('getData of basketbox $data and $dataList');
    setState(() {
      garmnentList = dataList.toString();
      totalPrice = data['price'].toString();
      itemss = int.parse(data['items'].toString());
      service = dataList.length;
      totalBill =
          double.parse(totalPrice) + double.parse(deliveryCharges.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  orderPlace() async {
    setState(() {
      isLoading = true;
    });
    const String orderType = 'Basket order';
    final int noOfServic = service;
    const String serviceName = 'wash';
    final int items = itemss;
    final String itemsList = garmnentList.toString();
    final String paymentType = payType;
    final String paymentStatus = payType == 'Pay on Pickup' ? 'Unpaid' : 'Paid';
    final String amount = totalBill.toString();
    final String pickupDate = timeslotData['pickup_date'];
    final String pickupTime = timeslotData['pickup_time'];
    final String deliveryDate = timeslotData['Delivery_date'];
    final String deliveryTime = timeslotData['Delivery_time'];
    final String pickupAddressId = selectAddressId.toString();
    const String ordStatus = 'order place';
    await orderApi
        .basketOrderCreate(
            orderType,
            noOfServic,
            serviceName,
            items,
            itemsList,
            paymentType,
            paymentStatus,
            amount,
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
            basketBox.clear();
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
      appBar: 'My Basket',
      isShowBack: false,
      bodys: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Height(20),
          Expanded(
            child: StepperA(
              stepperSize: const Size(350, 100),
              borderShape: BorderShape.circle,
              stepperAxis: Axis.horizontal,
              lineType: LineType.dotted,
              stepperBackgroundColor: Colors.transparent,
              stepperAController: basketController,
              stepHeight: 35,
              stepWidth: 35,
              stepBorder: true,
              pageSwipe: true,
              formValidation: false,
              previousButton: (int index) => StepperAButton(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 60,
                  boxDecoration: BoxDecoration(
                    color: AppColor.primaryColor2,
                    // borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  onTap: (int currentIndex) {
                    debugPrint("Previous Button Current Index $currentIndex");
                  },
                  buttonWidget: SmallText(
                    text: '<- Back',
                    color: Colors.white,
                    fontweights: FontWeight.w500,
                    size: 15,
                  )),
              forwardButton: (index) => StepperAButton(
                  onComplete: () {
                    debugPrint(
                        "Forward Button click complete step call back! $index");
                    confermationBox();
                    // Get.toNamed(Routes.bottomNavigation);
                  },
                  // width:100,
                  width: index == 0
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width / 2,
                  height: 60,
                  onTap: (int currentIndex) {
                    debugPrint("Forward Button $currentIndex");
                    setState(() {});
                    // if(_counter < 10){
                    // setState(() {
                    //   controller.back;
                    //   // controller = currentIndex;
                    // });

                    // }else{

                    // }
                    // controller.back;
                    // debugPrint(
                    // "Forward Button Current Index $controller and $currentIndex");
                  },
                  boxDecoration: BoxDecoration(
                    color: index == 3 ? Colors.indigo : AppColor.primaryColor1,
                    // borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  buttonWidget: SmallText(
                    text: index == 0 ? 'Place Order' : 'Next ->',
                    color: Colors.white,
                    fontweights: FontWeight.w500,
                    size: 15,
                  )),
              customSteps: const [
                CustomSteps(stepsIcon: IconlyLight.buy, title: "Basket"),
                CustomSteps(
                    stepsIcon: Icons.location_on_outlined, title: "Address"),
                CustomSteps(stepsIcon: Icons.history, title: "P/D Slot"),
                CustomSteps(stepsIcon: Icons.outbox_rounded, title: "Details"),
                CustomSteps(stepsIcon: Icons.wallet, title: "   Pay"),
              ],
              step: StepA(
                  currentStepColor: Colors.green,
                  completeStepColor: AppColor.primaryColor1,
                  inactiveStepColor: Colors.black54,
                  // loadingWidget: CircularProgressIndicator(color: Colors.green,),
                  margin: const EdgeInsets.all(5)),
              stepperBodyWidget: [
                const BasketPage(),
                AddressPage(
                  callback: (data) {
                    pickupAddress = data['addressName'];
                    selectAddressId = data['addressId'];
                    print('addddddddddddddr $data');
                  },
                ),
                TimeSlotPage(
                  callback: (data) {
                    timeslotData = data;

                    print('slotsss $data');
                  },
                ),
                stepOrderSummary(),
                // stepOrderSummary(),
                BasketPaymentPage(
                  callback: (value) {
                    payType = value;
                    print('pppppppppp $payType');
                  },
                  amount: totalBill.toString(),
                ),
              ],
            ),
          ),
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

  applyCouponCode() async {
    String couponCodes = couponCode.text;
    if (couponCodes.isEmpty) {
      showCustomSnackBar(
          title: 'Coupon Code', 'Please enter valid coupon code');
    } else {
      setState(() {
        isApply = true;
      });
    }

    await Timer(const Duration(seconds: 4), () {
      setState(() {
        isApply = false;
      });
    });
  }

  Widget stepOrderSummary() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BasketSummaryPage(
              address: pickupAddress,
              pickupDate: timeslotData['pickup_date'] ?? '',
              pickupTime: timeslotData['pickup_time'] ?? '',
              deliverDate: timeslotData['Delivery_date'] ?? '',
              deliverTime: timeslotData['Delivery_time'] ?? '',
              totalItems: itemss.toString(),
              service: service.toString(),
              basketAmount: '₹${double.parse(totalPrice)}',
              deliveryCharges: '₹${double.parse(deliveryCharges.toString())}',
              // promoCode: '₹${double.parse(totalPrice)}',
              totalBill: '₹${totalBill}',
            ),
            // const DisplayText(text: 'Offers & Benefits'),
            const Height(15),
          ],
        ),
      ),
    );
  }
}

class DisplayText extends StatelessWidget {
  final String text;
  const DisplayText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SmallText(
      text: text,
      fontweights: FontWeight.w500,
      size: 16,
    );
  }
}















// import 'package:clocare/screen/basket/steps/basket_page.dart';
// import 'package:clocare/screen/home/steper/order_summary_page.dart';
// import 'package:clocare/screen/home/steper/time_slot_page.dart';
// import 'package:clocare/screen/widget/app_bar_widget.dart';
// import 'package:clocare/screen/widget/size_box.dart';
// import 'package:clocare/utiles/themes/ColorConstants.dart';
// import 'package:flutter/material.dart';
// import 'package:iconly/iconly.dart';
// import 'package:stepper_a/stepper_a.dart';
// import 'steps/address_page.dart';

// class BasketCheckOutScreen extends StatefulWidget {
//   final bool visible;
//   const BasketCheckOutScreen({Key? key, required this.visible}) : super(key: key);

//   @override
//   State<BasketCheckOutScreen> createState() => _BasketCheckOutScreenState();
// }

// class _BasketCheckOutScreenState extends State<BasketCheckOutScreen> {
//   final StepperAController basketController = StepperAController();
//   Map timeslotData = {};
//   bool isVisibal = false;

//   @override
//   Widget build(BuildContext context) {
//     return CustomFold(
//       appBar: 'My Basket',
//       isShowBack: false,
//       bodys: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Height(20),
//           Expanded(
//             child: StepperA(
//               stepperSize: const Size(360, 100),
//               borderShape: BorderShape.circle,
//               // borderType: BorderType.straight,
//               stepperAxis: Axis.horizontal,
//               lineType: LineType.dotted,
//               stepperBackgroundColor: Colors.transparent,
//               stepperAController: basketController,
//               stepHeight: 35,
//               stepWidth: 35,
//               stepBorder: true,
//               pageSwipe: true,
//               formValidation: false,
//               // previousButton: (int index) => StepperAButton(
//               //   width: 40,
//               //   height: 40,
//               //   onTap: (int currentIndex) {
//               //     debugPrint("Previous Button Current Index $currentIndex");
//               //   },
//               //   buttonWidget: const Icon(
//               //     Icons.arrow_back,
//               //     color: Colors.white,
//               //   ),
//               // ),

//               // forwardButton: (index) => StepperAButton(
//               //   onComplete: () {
//               //     debugPrint("Forward Button click complete step call back!");
//               //   },
//               //   width: 40,
//               //   // width: index == 0 ? MediaQuery.of(context).size.width-25 : MediaQuery.of(context).size.width-140,
//               //   height: 40,
//               //   onTap: (int currentIndex) {
//               //     debugPrint("Forward Button Current Index $currentIndex");
//               //   },
//               //   boxDecoration: BoxDecoration(
//               //       color: index == 3 ? Colors.indigo : Colors.green,
//               //       borderRadius: const BorderRadius.all(Radius.circular(10))),
//               //   buttonWidget: const Icon(
//               //     Icons.arrow_forward,
//               //     color: Colors.white,
//               //   ),
//               // ),
//               customSteps: const [
//                 CustomSteps(stepsIcon: IconlyLight.buy, title: "Basket"),
//                 CustomSteps(
//                     stepsIcon: Icons.location_on_outlined, title: "Address"),
//                 CustomSteps(stepsIcon: Icons.history, title: "P/D Slot"),
//                 CustomSteps(stepsIcon: Icons.outbox_rounded, title: "Sumary"),
//                 CustomSteps(stepsIcon: Icons.wallet, title: "Payment"),
//               ],
//               step: StepA(
//                   currentStepColor: Colors.green,
//                   completeStepColor: AppColor.primaryColor1,
//                   inactiveStepColor: Colors.black54,
//                   // loadingWidget: CircularProgressIndicator(color: Colors.green,),
//                   margin: const EdgeInsets.all(5)),
//               stepperBodyWidget: [
//                 BasketPage(
//                   controllers: basketController,
//                 ),
//                 AddressPage(
//                   callback: (data) {
//                     print('addddddddddddddr $data');
//                   },
//                 ),
//                 TimeSlotPage(
//                   callback: (data) {
//                     timeslotData = data;

//                     print('slotsss $data');
//                   },
//                 ),
//                 stepOrderSummary(),
//                 stepOrderSummary(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget stepOrderSummary() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15, top: 35, left: 15, right: 15),
//       child: OrderSummaryPage(
//         serviceName: 'widget.serviceName',
//         items: '4 items',
//         address: 'pickupformatAddress',
//         pickupDate: timeslotData['pickup_date'] ?? '',
//         pickupTime: timeslotData['pickup_time'] ?? '',
//         deliverDate: timeslotData['Delivery_date'] ?? '',
//         deliverTime: timeslotData['Delivery_time'] ?? '',
//       ),
//     );
//   }
// }

// class MyTabbedWidget extends StatefulWidget {
//   const MyTabbedWidget({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MyTabbedWidgetState createState() => _MyTabbedWidgetState();
// }

// class _MyTabbedWidgetState extends State<MyTabbedWidget>
//     with SingleTickerProviderStateMixin {
//   // The provided data
//   var data = [
//     {
//       "id": "0",
//       "text": "Regular-Ironing",
//       "itemsList": [
//         {
//           "gtype_id": '1',
//           "name": "Men",
//           "items": [
//             {
//               'price': "6.00",
//               "name": "Men1",
//             },
//             {
//               'price': "6.00",
//               "name": "Men2",
//             }
//           ]
//         },
//         {
//           "gtype_id": '2',
//           "name": "wear",
//           "items": [
//             {
//               'price': "6.00",
//               "name": "wear1",
//             },
//             {
//               'price': "6.00",
//               "name": "wear2",
//             }
//           ]
//         }
//       ]
//     },
//     {
//       "id": "0",
//       "text": "Ironing",
//       "itemsList": [
//         {
//           "gtype_id": '1',
//           "name": "Ironing1",
//           "items": [
//             {
//               'price': "6.00",
//               "name": "sunIroning1",
//             },
//             {
//               'price': "6.00",
//               "name": "sunIroning2",
//             }
//           ]
//         },
//         {
//           "gtype_id": '2',
//           "name": "Ironing2",
//           "items": [
//             {
//               'price': "6.00",
//               "name": "12",
//             },
//             {
//               'price': "6.00",
//               "name": "12",
//             }
//           ]
//         }
//       ]
//     }
//   ];

//   // Variable to store selected items data
//   var saveData = <dynamic>[];

//   // Controller for the top tab bar
//   TabController? _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       length: data.length,
//       vsync: this,
//     );
//   }

//   @override
//   void dispose() {
//     _tabController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TabBar(
//           controller: _tabController,
//           tabs: data.map((item) => Tab(text: item['text'].toString())).toList(),
//         ),
//         // Expanded(
//         // child: TabBarView(
//         // controller: _tabController,
//         // children: data.map((item) {
//         //   return ListView(
//         //     children:  item['itemsList'] == null ? const Text('dd') : item['itemsList']!.map((itemsList) {
//         //       return ListTile(
//         //         title: Text(itemsList['name']),
//         //         onTap: () {
//         //           setState(() {
//         //             // Add the selected item to saveData
//         //             saveData.add(itemsList);
//         //           });
//         //         },
//         //       );
//         //     }).toList(),
//         //   );
//         // }).toList(),
//         // ),
//         // ),

//         ElevatedButton(
//           onPressed: () {
//             // Print or use the selected items in saveData
//             print(saveData);
//           },
//           child: const Text('Save Selected Items'),
//         ),
//       ],
//     );
//   }
// }




















































