import 'package:clocare/routes/routes.dart';
import 'package:clocare/screen/widget/custom_text_field.dart';
import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/app_asset.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  final String serviceName;

   LandingPage({super.key, required this.serviceName, });
  final clothNo = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                                text: serviceName,
                                size: 15,
                                color: AppColor.appBarColor,
                                fontweights: FontWeight.bold,
                              ),
                              const Height(3),
                              SmallText(text: '${clothNo.text} items'),
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
                        controller: clothNo,
                        readOnlys: false,
                        // suffix: SmallText(
                        //   text: 'verify',
                        //   color: Colors.blueAccent,
                        //   fontweights: FontWeight.bold,
                        // ),
                        hintTexts: 'e.g 12',
                        validator: (value) {
                          print('dddddddddddd $value');
                          if (value == null || value.isEmpty) {
                            // showCustomSnackBar(
                            //     title: 'Clothes',
                            //     'Please enter total number of clothes');
                            return 'Enter total number of clothes';
                          } else if (int.parse(value!) > 5) {
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
}
