import 'package:clocare/screen/package/stepper/pickup_slot_page.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final Function(String) callback;
  const PaymentPage({super.key, required this.callback});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selectDeliveryIndex = 0;
  String selectPayType = '';

  void sendDataToParent() {
    setState(() {
      widget.callback(selectPayType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
      child: Column(
        children: [
          Expanded(
            child: Container(
                // height: 150,
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallText(
                                  text: 'Payment Option',
                                  size: 15,
                                  fontweights: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                const Height(5),
                                SmallText(
                                  text: 'Select suitable payment option',
                                  size: 10,
                                  // fontweights: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 117, 117, 117),
                                ),
                              ],
                            ),
                          ),
                          const Height(20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BoxWidget(
                                title: 'Pay on Pickup',
                                icon: Icons.time_to_leave,
                                onTap: () {
                                  setState(() {
                                    selectDeliveryIndex = 1;
                                    selectPayType = "Pay on Pickup";
                                  });
                                  sendDataToParent();
                                },
                                textColor: selectDeliveryIndex == 1
                                    ? AppColor.backgroundColor
                                    : AppColor.appBarColor,
                                bg: selectDeliveryIndex == 1
                                    ? AppColor.primaryColor1Greey
                                    : const Color.fromARGB(106, 239, 241, 254),
                              ),
                              const Height(15),
                              BoxWidget(
                                title: 'Pay on Delivery',
                                icon: Icons.timer_sharp,
                                onTap: () {
                                  setState(() {
                                    selectDeliveryIndex = 2;
                                    selectPayType = "Pay on Delivery";
                                  });
                                  sendDataToParent();
                                },
                                textColor: selectDeliveryIndex == 2
                                    ? AppColor.backgroundColor
                                    : AppColor.appBarColor,
                                bg: selectDeliveryIndex == 2
                                    ? AppColor.primaryColor1Greey
                                    : const Color.fromARGB(106, 239, 241, 254),
                              ),
                            ],
                          ),
                        ]))),
          ),
          // const Height(20),
          Expanded(
            child: Container(
                //     color: Colors.yellow,
                //     child: SmallText(
                //       text: 'asasds',
                //       color: Colors.redAccent,
                //       size: 10,
                //     ),
                ),
          )
        ],
      ),
    );
  }
}
