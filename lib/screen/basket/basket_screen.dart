import 'package:clocare/screen/basket/basket_check_out_screen.dart';
import 'package:clocare/screen/basket/steps/basket_page.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:stepper_a/stepper_a.dart';

class BasketScreen extends StatefulWidget {
  final bool visible;
  const BasketScreen({Key? key, required this.visible}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  bool isVisibal = false;
  final basketBox = Hive.box('basketBox');
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomFold(
      appBar: 'My Basket',
      isShowBack: false,
      bodys: basketBox.get('BASKETLIST') == null
          ? const AddBasketBox()
          : Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Column(
                    children: [
                      const BasketData(),
                      const Height(35),
                      Row(
                        children: [
                          BtnBasket(
                            title: 'Empty Basket',
                            bg: AppColor.boxColor,
                            onTap: () {
                              basketBox.delete('BASKETLIST');
                              setState(() {});
                            },
                            textColor: AppColor.appBarColor,
                          ),
                          const Widths(20),
                          BtnBasket(
                            title: 'Check out',
                            bg: AppColor.primaryColor1,
                            onTap: () {
                              Get.to(const BasketCheckOutScreen(),
                                  transition: Transition.rightToLeft);
                            },
                            textColor: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class AddBasketBox extends StatelessWidget {
  const AddBasketBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
              stepHeight: 35,
              stepWidth: 35,
              stepBorder: true,
              pageSwipe: false,
              formValidation: false,
              customSteps: const [
                CustomSteps(stepsIcon: IconlyLight.buy, title: "Basket"),
                CustomSteps(
                    stepsIcon: Icons.location_on_outlined, title: "Address"),
                CustomSteps(stepsIcon: Icons.history, title: "P/D Slot"),
                CustomSteps(stepsIcon: Icons.outbox_rounded, title: "Details"),
                CustomSteps(stepsIcon: Icons.wallet, title: "Payment"),
              ],
              step: StepA(
                  currentStepColor: Colors.green,
                  completeStepColor: AppColor.primaryColor1,
                  inactiveStepColor: Colors.black54,
                  // loadingWidget: CircularProgressIndicator(color: Colors.green,),
                  margin: const EdgeInsets.all(5)),
              stepperBodyWidget: [
                const BasketPage(),
                Container(),
                Container(),
                Container(),
                Container(),
              ],
            ),
          )
        ]);
  }
}
