import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderCustomBox extends StatefulWidget {
  final String orderId;
  final String paymentStatus;
  final String orderType;
  final String serviceName;
  final String totalClothes;
  final String amount;
  final String date;
  final String paymentType;
  const OrderCustomBox(
      {super.key,
      required this.orderId,
      required this.paymentStatus,
      required this.orderType,
      required this.serviceName,
      required this.totalClothes,
      required this.amount,
      required this.date,
      required this.paymentType});

  @override
  State<OrderCustomBox> createState() => _OrderCustomBoxState();
}

class _OrderCustomBoxState extends State<OrderCustomBox> {
  int activeStep = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
            decoration: BoxDecoration(
                color: AppColor.boxColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: Colors.white)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SmallText(
                            text: 'Order Id : ',
                            color: AppColor.appBarColor,
                            size: 14,
                            fontweights: FontWeight.w500,
                          ),
                          SmallText(
                            text: widget.orderId,
                            color: AppColor.primaryColor1,
                            size: 14,
                            fontweights: FontWeight.w500,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColor.backgroundColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: const Color.fromARGB(39, 68, 137, 255))),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: SmallText(
                            text: widget.paymentStatus,
                            color: AppColor.primaryColor1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Height(8),
                  const Divider(),
                  const Height(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmallText(
                        text: 'Order type:',
                        color: AppColor.appBarColor,
                      ),
                      SmallText(
                        text: widget.orderType,
                        color: AppColor.primaryColor1,
                      ),
                    ],
                  ),
                  const Height(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmallText(
                        text: 'Total service:',
                        color: AppColor.appBarColor,
                      ),
                      SmallText(
                        text: widget.serviceName,
                        color: AppColor.primaryColor1,
                      ),
                    ],
                  ),

                  const Height(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmallText(
                        text: 'Total clothes:',
                        color: AppColor.appBarColor,
                      ),
                      SmallText(
                        text: widget.totalClothes,
                        color: AppColor.primaryColor1,
                      ),
                    ],
                  ),
                  const Height(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmallText(
                        text: 'Order Place Date:',
                        color: AppColor.appBarColor,
                      ),
                      SmallText(
                        text: widget.date,
                        color: AppColor.primaryColor1,
                      ),
                    ],
                  ),
                  const Height(8),
                  const Divider(),
                  const Height(8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmallText(
                        text: 'Payment Type:',
                        color: AppColor.appBarColor,
                      ),
                      SmallText(
                        text: widget.paymentType,
                        color: AppColor.primaryColor1,
                      ),
                    ],
                  ),
                  const Height(8),
                  // const Divider(),
                  // const Height(8),
                  Visibility(
                    visible: widget.amount == '0' ? false : true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SmallText(
                          text: 'Total Amount:',
                          color: AppColor.appBarColor,
                          fontweights: FontWeight.w500,
                        ),
                        SmallText(
                          text: widget.amount,
                          color: AppColor.primaryColor1,
                          fontweights: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  // const Height(8),
                  // const Divider(),
                  // const Height(8),
                  // SmallText(
                  //   text: 'Order Status',
                  //   color: AppColor.primaryColor1,
                  //   fontweights: FontWeight.w500,
                  // ),
                  // const Height(15),

                  // EasyStepper(
                  //   activeStep: activeStep,
                  //   lineStyle: const LineStyle(
                  //     lineLength: 60,
                  //     lineThickness: 1,
                  //     lineSpace: 5,
                  //   ),
                  //   stepRadius: 15,
                  //   unreachedStepIconColor: Colors.black87,
                  //   unreachedStepBorderColor: Colors.black54,
                  //   unreachedStepTextColor: Colors.black,
                  //   showLoadingAnimation: false,
                  //   steps: const [
                  //     EasyStep(
                  //       icon: Icon(Icons.my_location),
                  //       title: 'You',
                  //       lineText: '1.7 KM',
                  //     ),
                  //     EasyStep(
                  //       icon: Icon(CupertinoIcons.cube_box),
                  //       title: 'Pick Up',
                  //       lineText: '3 KM',
                  //     ),
                  //     EasyStep(
                  //       icon: Icon(CupertinoIcons.flag),
                  //       title: 'Drop Off',
                  //     ),
                  //   ],
                  //   onStepReached: (index) =>
                  //       setState(() => activeStep = index),
                  // ),

//  EasyStepper(
//                   activeStep: activeStep,
//                   lineLength: 50,
//                   stepShape: StepShape.rRectangle,
//                   stepBorderRadius: 15,
//                   borderThickness: 2,
//                   padding: 20,
//                   stepRadius: 28,
//                   finishedStepBorderColor: Colors.deepOrange,
//                   finishedStepTextColor: Colors.deepOrange,
//                   finishedStepBackgroundColor: Colors.deepOrange,
//                   activeStepIconColor: Colors.deepOrange,
//                   showLoadingAnimation: false,
//                   steps: [
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 0 ? 1 : 0.3,
//                           child: Image.asset('assets/1.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 1',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 1 ? 1 : 0.3,
//                           child: Image.asset('assets/2.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 2',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 2 ? 1 : 0.3,
//                           child: Image.asset('assets/3.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 3',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 3 ? 1 : 0.3,
//                           child: Image.asset('assets/4.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 4',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 4 ? 1 : 0.3,
//                           child: Image.asset('assets/5.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 5',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ],
//                   onStepReached: (index) => setState(() => activeStep = index),
//                 ),
                ],
              ),
            )));
  }
}
