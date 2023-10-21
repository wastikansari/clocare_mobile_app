import 'package:clocare/backend/api/profile_api.dart';
import 'package:clocare/screen/package/package_checkout_screen.dart';
import 'package:clocare/screen/package/package_screen.dart';
import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../backend/model/package_model.dart';
import '../../widget/custom_text_field.dart';

class packagePlan extends StatefulWidget {
  const packagePlan({
    super.key,
    required this.packageData,
  });

  final Data packageData;

  @override
  State<packagePlan> createState() => _packagePlanState();
}

class _packagePlanState extends State<packagePlan> {
  ProfileApi profileApi = ProfileApi();
  bool isLoading = false;

  var emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() {
    profileApi.profileData().then((value) {
      if (value.status == true) {
        var data = value.data;
        setState(() {
          emailController.text = data!.email.toString();
          print(data!.email.toString());
        });
      }
    });
  }

  emailSave() {
    var emailid = emailController.text;
    if (emailid.isEmpty) {
      showCustomSnackBar(title: 'Email id', "Please enter your email id");
    } else if (!GetUtils.isEmail(emailid)) {
      showCustomSnackBar(title: 'Email id', "Please enter your valid email id");
    } else {
      setState(() {
        isLoading = true;
      });

      profileApi.emailUpdate(emailid).then((value) {
        if (value.status == true) {
          showCustomSnackBar(title: 'Email id', "Email update successfully");
        }
        setState(() {
          isLoading = false;
        });
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              // height: 200,
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
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: 'PERSONAL DETAILS',
                          size: 12,
                          fontweights: FontWeight.bold,
                          color: const Color.fromARGB(255, 117, 117, 117),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(10),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              // padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              emailSave();
                            },
                            child: isLoading
                                ? LoadingAnimationWidget.staggeredDotsWave(
                                    color: AppColor.primaryColor1,
                                    size: 25,
                                  )
                                : SmallText(
                                    text: 'SAVE',
                                    size: 12,
                                    color: Colors.blueAccent,
                                    fontweights: FontWeight.w900,
                                  )),
                      ],
                    ),
                    const Height(10),
                    CustomTextField(
                      labelText: 'Email id',
                      controller: emailController,
                      readOnlys: false,
                      hintTexts: 'example@gmail.com',
                      validator: (value) {
                        // if (value == null || value.isEmpty) {
                        //   return 'Enter your email id';
                        // } else if (!GetUtils.isEmail(value)) {
                        //   return 'Email is not valid';
                        // }
                      },
                    ),
                    const Height(15),
                  ],
                ),
              ),
            ),
            const Height(20),
            PackageCheckoutBox(
              title: widget.packageData.packageName!,
              code: " (${widget.packageData.packageCode}) ",
              pricing: "₹${widget.packageData.prices}",
              validity: widget.packageData.valid!,
              garments: widget.packageData.routineGarments!,
              buyPlan: () {},
              detaile: Column(
                children: [
                  GarmentText(
                    title: 'Routine Garments :',
                    qty: widget.packageData.routineGarments!,
                    icon: widget.packageData.routineGarments == '0'
                        ? Icons.close
                        : Icons.check,
                  ),
                  GarmentText(
                    title: 'Ironing :',
                    qty: widget.packageData.ironing!,
                    icon: widget.packageData.ironing == '0'
                        ? Icons.close
                        : Icons.check,
                  ),
                  GarmentText(
                    title: 'Steam Ironing :',
                    qty: widget.packageData.steamIroning!,
                    icon: widget.packageData.steamIroning == '0'
                        ? Icons.close
                        : Icons.check,
                  ),
                  GarmentText(
                    title: 'Wash + Ironing :',
                    qty: widget.packageData.washIroning!,
                    icon: widget.packageData.washIroning! == '0'
                        ? Icons.close
                        : Icons.check,
                  ),
                  GarmentText(
                    title: 'Dry Cleaning :',
                    qty: widget.packageData.dryCleaning!,
                    icon: widget.packageData.dryCleaning! == '0'
                        ? Icons.close
                        : Icons.check,
                  ),
                  GarmentText(
                    title: 'No. of Free Pickup :',
                    qty: widget.packageData.freeDelivery!,
                    icon: Icons.check,
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
