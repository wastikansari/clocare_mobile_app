import 'package:clocare/backend/api/wallet_api.dart';
import 'package:clocare/screen/package/stepper/pickup_slot_page.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';

class PackagePaymentPage extends StatefulWidget {
  final String amount;
  final Function(Map) callback;
  const PackagePaymentPage(
      {super.key, required this.callback, required this.amount});

  @override
  State<PackagePaymentPage> createState() => _PackagePaymentPageState();
}

class _PackagePaymentPageState extends State<PackagePaymentPage> {
  int selectDeliveryIndex = 0;
  String selectPayType = '';
  double walletBalances = 0;
  WalletApi walletApi = WalletApi();

  void sendDataToParent() {
    setState(() {
      Map data = {
        'selectPayType': selectPayType,
        'wallet_balances': walletBalances,
      };
      widget.callback(data);
    });
  }

  getData() async {
    await walletApi.walletAmountApi().then((value) {
      if (value.status == true) {
        var data = value.data;
        setState(() {
          walletBalances = double.parse(data!.walletBalance!.toString());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 1),
                color: //const Color.fromARGB(106, 239, 241, 254),
                    const Color(0xFFF9F8FF),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.boxShadowColor,
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0.0, 0.0),
                  )
                ],
              ),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: const Color.fromARGB(106, 239, 241, 254),
              //     border: Border.all(
              // color: const Color.fromARGB(39, 68, 137, 255))),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SmallText(
                      text: 'Total Pay',
                      color: AppColor.primaryColor1,
                      size: 14,
                      fontweights: FontWeight.w500,
                    ),
                    SmallText(
                      text: '₹${double.parse(widget.amount)}',
                      color: AppColor.primaryColor1,
                      size: 14,
                      fontweights: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            const Height(20),
            Container(
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
                                title: 'Wallet Pay',
                                icon: Icons.wallet,
                                onTap: () {
                                  getData();
                                  setState(() {
                                    selectDeliveryIndex = 1;
                                    selectPayType = "Wallet pay";
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
                                title: 'Online Pay',
                                icon: Icons.public,
                                onTap: () {
                                  setState(() {
                                    selectDeliveryIndex = 2;
                                    selectPayType = "Online Pay";
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
            const Height(20),
            Visibility(
              visible: selectPayType == "Wallet pay",
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
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
                  padding: const EdgeInsets.all(18),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SmallText(
                          text: 'Wallet Balances',
                          color: AppColor.appBarColor,
                          fontweights: FontWeight.w500,
                        ),
                        SmallText(
                          text: '₹$walletBalances',
                          color: AppColor.appBarColor,
                          fontweights: FontWeight.w500,
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
