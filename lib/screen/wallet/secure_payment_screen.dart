import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecurePaymentScreen extends StatefulWidget {
  final int amount;
  const SecurePaymentScreen({super.key, required this.amount});
  @override
  State<SecurePaymentScreen> createState() => _SecurePaymentScreenState();
}

class _SecurePaymentScreenState extends State<SecurePaymentScreen> {
  securePaymentScreen({required int amount}) {
    Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_ceGA6ghFS7jiYY',
      'amount': amount,
      'name': 'Clocare',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'timeout': 60,
      'prefill': {'contact': '8327724967', 'email': 'wastik@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

    razorpay.open(options);
    // razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFold(
      appBar: 'Secure Payment',
      isShowBack: true,
      bodys: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Height(15),
            SmallText(
              text: 'Wallet credit with : ₹ ${widget.amount}',
              size: 14,
              fontweights: FontWeight.bold,
              color: AppColor.appBarColor,
            ),
            const Height(20),
            ListTileBox(
              title: 'Net Banking',
              icon: SvgPicture.asset(
                'asset/icons/digital-banking-icon.svg',
                height: 4,
                color: AppColor.primaryColor1,
              ),
              onTap: () {
                int pay = widget.amount * 100;
                // String money =  '$pay+00';
                // int a =  int.parse(money);
                print('daddddddddddddddd $pay and ${pay.runtimeType}');

                securePaymentScreen(amount: pay);
              },
            ),
            ListTileBox(
              title: 'Debit/Credit Cards',
              icon: SvgPicture.asset(
                'asset/icons/card-cvv-icon.svg',
                height: 4,
                color: AppColor.primaryColor1,
              ),
              onTap: () {},
            ),
            ListTileBox(
              title: 'Wallet',
              icon: SvgPicture.asset(
                'asset/icons/credit-card-icon.svg',
                height: 4,
                color: AppColor.primaryColor1,
              ),
              onTap: () {},
            ),
            ListTileBox(
              title: 'UPI Pay',
              icon: SvgPicture.asset(
                'asset/icons/upi-icon.svg',
                height: 4,
                // color: AppColor.primaryColor1,
              ),
              onTap: () {},
            ),

            // ListTileBox(
            //   title: 'Google pay',
            //   icon: SvgPicture.asset(
            //     'asset/icons/ggpay.svg',
            //     height: 4,
            //     // color: AppColor.primaryColor1,
            //   ),
            //   onTap: () {},
            // ),
            // ListTileBox(
            //   title: 'PhonePe',
            //   icon: SvgPicture.asset(
            //     'asset/icons/phonePe.svg',
            //     height: 4,
            //     // color: AppColor.primaryColor1,
            //   ),
            //   onTap: () {
            //     Get.to(UpiPayScreen(
            //       amount: double.parse(widget.amount.toString()),
            //     ));
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class ListTileBox extends StatelessWidget {
  final Widget icon;
  final String title;
  final Function onTap;
  const ListTileBox({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.black87,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  height: 43,
                  width: 43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black, width: 0.1),
                    color: const Color(0xFFe7e7ff),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: icon,
                  )),
              const Widths(18),
              SmallText(
                text: title,
                size: 15,
                // fontweights: FontWeight.w500,
                color: const Color.fromARGB(157, 0, 0, 0),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
