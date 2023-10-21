import 'package:clocare/backend/api/profile_api.dart';
import 'package:clocare/routes/routes.dart';
import 'package:clocare/screen/profile/profile_screen.dart';
import 'package:clocare/screen/wallet/secure_payment_screen.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final TextEditingController _amountController = TextEditingController();
  int totalAmount = 0;
  double walletBalance = 0;
  double unpaidBalance = 0;
  bool isLoading = false;
  ProfileApi profileApi = ProfileApi();
  void addToTotal(int amount) {
    setState(() {
      totalAmount = amount;
      _amountController.text = totalAmount.toString();
    });
  }

  getData() {
    profileApi.profileData().then((value) {
      if (value.status == true) {
        var data = value.data;
        setState(() {
          walletBalance = double.parse(data!.walletBalance!.toString());
          unpaidBalance = double.parse(data.unpaidBalance!.toString());
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFold(
      appBar: 'Wallet',
      isShowBack: true,
      leading: IconButton(
          padding: const EdgeInsets.all(6),
          constraints: const BoxConstraints(),
          onPressed: () {
            Get.toNamed(Routes.transactions);
          },
          icon: Icon(
            Icons.more_vert,
            color: AppColor.backgroundColor,
            size: 25,
          )),
      bodys: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      textBox(
                        title: 'wallet amount',
                        amount: walletBalance.toString(),
                      ),
                      Container(
                        height: 50,
                        width: 1,
                        color: AppColor.primaryColor1,
                      ),
                      textBox(
                        title: 'Unpaid amount',
                        amount: unpaidBalance.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              const Height(30),
              SmallText(
                text: 'Add Money',
                size: 17,
                color: AppColor.appBarColor,
                fontweights: FontWeight.w500,
              ),
              const Height(20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white, width: 1),
                  color: AppColor.boxColor,
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
                    children: [
                      const Height(20),
                      TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            totalAmount = int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          prefix: Text('      ₹  '),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: 'Enter amount',
                        ),
                      ),
                      const Height(30),
                      SizedBox(
                        height: 30,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            AddBox(
                              money: '100',
                              onTap: () {
                                addToTotal(100);
                              },
                            ),
                            const Widths(10),
                            AddBox(
                              money: '500',
                              onTap: () {
                                addToTotal(500);
                              },
                            ),
                            const Widths(10),
                            AddBox(
                              money: '1,000',
                              onTap: () {
                                addToTotal(1000);
                              },
                            ),
                          ],
                        ),
                      ),
                      const Height(20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: InkWell(
                    onTap: () {
                      if (totalAmount > 0) {
                        int amount = int.parse(totalAmount.toString());
                        Get.to(
                            SecurePaymentScreen(
                              amount: amount,
                            ),
                            // UpiPayScreen(
                            //   amount: amount,
                            // ),
                            transition: Transition.rightToLeft);
                      } else {
                        showCustomSnackBar(
                            title: 'Add Money',
                            "Please enter your amount to proceed");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor1,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50) //
                                ),
                      ),
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 16, bottom: 16),
                            child: isLoading
                                ? Center(
                                    child:
                                        LoadingAnimationWidget.fourRotatingDots(
                                    color: Colors.white,
                                    size: 20,
                                  ))
                                : SmallText(
                                    text: 'Proceed',
                                    size: 16,
                                    color: Colors.white,
                                    fontweights: FontWeight.bold,
                                  )),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddBox extends StatelessWidget {
  final String money;
  final Function onTap;
  const AddBox({
    super.key,
    required this.money,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
          height: 30,
          width: 70,
          decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: Color.fromARGB(34, 23, 79, 162), width: 0.5)),
          child: Center(
              child: SmallText(
            text: '+ ₹$money',
            color: AppColor.primaryColor1,
            fontweights: FontWeight.w400,
          ))),
    );
  }
}
