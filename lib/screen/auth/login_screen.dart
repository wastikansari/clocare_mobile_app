import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clocare/backend/api/authendication_api.dart';
import 'package:clocare/backend/controller/profile_controller.dart';
import 'package:clocare/screen/bottom_navigation/bottom_navigation.dart';
import 'package:clocare/screen/widget/otp_box.dart';
import 'package:clocare/utiles/app_asset.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:clocare/screen/widget/button_widget.dart';
import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/screen/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthendicationApi authendicationApi = AuthendicationApi();

  TextEditingController phoneController = TextEditingController();

  bool isValidPhone = false;
  bool isValidName = false;
  bool isOtpVal = false;
  bool isLoginLoading = false;
  bool isOtpVisible = false;
  int _currentImageIndex = 0;

  var num1 = TextEditingController();
  var num2 = TextEditingController();
  var num3 = TextEditingController();
  var num4 = TextEditingController();
  var num5 = TextEditingController();
  var num6 = TextEditingController();

  int _seconds = 60;
  Timer? _timer;
  int otpget = 0;
  String shortNum = '0';

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_seconds == 0) {
            timer.cancel();
          } else {
            _seconds--;
          }
        },
      ),
    );
  }

  void resetTimer(number) {
    if (_seconds == 0) {
      if (_timer != null) {
        _timer!.cancel();
        _seconds = 60;
        startTimer();
        otpSend(number);
      }
    } else {
      showCustomSnackBar(title: 'OTP', "Please wait for 60 seconds OTP send");
    }
  }

  verifyLogin() async {
    int mobile = int.parse(phoneController.text.trim().toString());
    final String enterOtp =
        num1.text + num2.text + num3.text + num4.text + num5.text + num6.text;

    if (otpget.toString() == enterOtp) {
      login(mobile);
    } else {
      showCustomSnackBar(title: 'Error', 'Please enter valid OTP code');
    }
  }

  login(mobile) async {
    setState(() {
      isLoginLoading = true;
    });
    await authendicationApi.login(mobile).then((value) async {
      if (value.status == true) {
        String token = value.data!.accessToken.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(AppConstants.TOKEN, token);
        setState(() {
          isLoginLoading = false;
        });
        Get.find<ProfileController>().getProfileData();
        Get.to(const BottomNavigation());
      } else {
        setState(() {
          isLoginLoading = false;
        });
        showCustomSnackBar(title: 'Error', 'login fail');
      }
    });
  }

  getOtp() async {
    String userNumber = phoneController.text.trim();
    if (userNumber.isEmpty) {
      showCustomSnackBar(
          title: 'Mobile Number', 'Please enter your mobile number');
    } else if (userNumber.length == 10) {
      setState(() {
        isLoginLoading = true;
      });
      int number = int.parse(userNumber);
      await authendicationApi.numberCheck(number).then((value) async {
        if (value.status == true) {
          setState(() {
            isOtpVisible = true;
            isLoginLoading = false;
          });
          otpSend(number);
        } else {
          setState(() {
            isLoginLoading = false;
          });
          showCustomSnackBar(title: 'Status', value.data!.msg.toString());
        }
      });
    } else {
      showCustomSnackBar(
          title: 'Mobile Number', 'Please enter valid mobile number');
    }
  }

  final List<String> _imageUrls = [
    AppAsset.intro1,
    AppAsset.intro2,
    AppAsset.intro3,
    AppAsset.intro4,
    AppAsset.intro5,
  ];

  otpSend(number) async {
    await authendicationApi.otpVerification(number).then((value) {
      if (value.status == true) {
        startTimer();
        setState(() {
          otpget = value.data!.verificationCode!;
        });
      } else {
        showCustomSnackBar(title: 'Error', value.data!.msg.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: CarouselSlider(
                items: _imageUrls.map((url) {
                  return Image.asset(
                    url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    // height: size.height,
                    // width: size.width,
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: false, // Disable enlarging the center page
                  viewportFraction: 1.0,

                  // enlargeCenterPage: true,
                  // pageSnapping: false,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  height: double.infinity,
                  padEnds: false,
                  disableCenter: true,
                  // autoPlay: true,
                  onPageChanged: (index, _) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                ),
              ),
            ),
            Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: const Alignment(0.0, 0.4),
                    begin: const Alignment(0.0, -1),
                    colors: <Color>[
                      Colors.black12.withOpacity(0.5),
                      const Color.fromARGB(235, 0, 0, 0),
                    ],
                  ),
                )),
            Positioned(
              top: 150,
              left: size.width / 5,
              child: Center(child: Image.asset(AppAsset.logoWhite, height: 60)),
            ),
            Positioned(
              top: 50,
              left: 15,
              child: Center(
                  child: InkWell(
                onTap: () {
                  Get.back();
                  // setState(() {
                  //   isOtpVisible = false;
                  // });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(99, 148, 148, 148),
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.clear,
                        color: AppColor.backgroundColor,
                      ),
                    )),
              )),
            ),
            Visibility(
              visible: !isOtpVisible,
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFF1FE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: 'Login',
                          size: 25,
                          fontweights: FontWeight.bold,
                          color: AppColor.primaryColor1,
                        ),
                        const Height(20),
                        Align(
                          alignment: Alignment.center,
                          child: SmallText(
                            text: 'Please enter your registered mobile',
                            size: 13,
                            fontweights: FontWeight.w500,
                            color: AppColor.primaryColorDark,
                            overFlow: TextOverflow.visible,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SmallText(
                            text: 'number to login via OTP',
                            size: 13,
                            fontweights: FontWeight.w500,
                            color: AppColor.primaryColorDark,
                            overFlow: TextOverflow.visible,
                          ),
                        ),
                        const Height(30),
                        CustomTextField(
                          hintText: 'Mobile Number',
                          icon: Icons.phone,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            if (value.length == 10) {
                              setState(() {
                                isValidPhone = true;
                              });
                            } else {
                              setState(() {
                                isValidPhone = false;
                              });
                            }
                          },
                        ),
                        const Height(10),
                        SmallText(
                          text:
                              'An OTP will be sent to this number for verification.',
                          size: 9,
                          color: Colors.black,
                          overFlow: TextOverflow.visible,
                        ),
                        const Height(60),
                        ButtonWidget(
                            text: "GET OTP",
                            isLoding: isLoginLoading,
                            backgroundColor: isValidPhone
                                ? AppColor.primaryColor1
                                : const Color.fromARGB(137, 23, 79, 162),
                            onPressed: () {
                              getOtp();
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isOtpVisible,
              child: Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFF1FE),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(
                            text: 'Verfiy',
                            size: 25,
                            fontweights: FontWeight.bold,
                            color: AppColor.primaryColor1,
                          ),
                          const Height(20),
                          Align(
                            alignment: Alignment.center,
                            child: SmallText(
                              text: 'We have send a 6 digit OTP',
                              size: 13,
                              fontweights: FontWeight.w400,
                              color: AppColor.primaryColorDark,
                              overFlow: TextOverflow.visible,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SmallText(
                              text: 'to your mobile number',
                              size: 13,
                              fontweights: FontWeight.w400,
                              color: AppColor.primaryColorDark,
                              overFlow: TextOverflow.visible,
                            ),
                          ),
                          const Height(20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OtpBox(
                                controller: num1,
                              ),
                              OtpBox(
                                controller: num2,
                              ),
                              OtpBox(
                                controller: num3,
                              ),
                              OtpBox(
                                controller: num4,
                              ),
                              OtpBox(
                                controller: num5,
                              ),
                              OtpBox(
                                controller: num6,
                              ),
                            ],
                          ),
                          const Height(10),

                          Visibility(
                            visible: isOtpVisible,
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  const Height(10),
                                  SmallText(
                                    text: '$_seconds sec',
                                    fontweights: FontWeight.w500,
                                    size: 18,
                                    color: _seconds < 20
                                        ? Colors.red
                                        : AppColor.primaryColor1,
                                  ),
                                  const Height(16),
                                  RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "Didn't receive a OTP? ",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: InkWell(
                                            onTap: () {
                                              resetTimer(int.parse(
                                                  phoneController.text
                                                      .toString()));
                                            },
                                            child: Text(
                                              "Resend OTP",
                                              style: TextStyle(
                                                foreground: Paint()
                                                  ..shader =
                                                      const LinearGradient(
                                                    colors: <Color>[
                                                      // Color(0xffEEA4CE),
                                                      // Color(0xffC58BF2),
                                                      Color(0xFF174FA2),
                                                      Color(0xFF57B1E3)
                                                    ],
                                                  ).createShader(
                                                    const Rect.fromLTWH(
                                                        0.0, 0.0, 200.0, 70.0),
                                                  ),
                                                // color: const Color(0xffC58BF2),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Height(40),
                          ButtonWidget(
                              text: "Verify & Login",
                              isLoding: isLoginLoading,
                              backgroundColor: num1.text.isNotEmpty &&
                                      num2.text.isNotEmpty &&
                                      num3.text.isNotEmpty &&
                                      num4.text.isNotEmpty &&
                                      num5.text.isNotEmpty &&
                                      num6.text.isNotEmpty
                                  ? AppColor.primaryColor1
                                  : const Color.fromARGB(137, 23, 79, 162),
                              onPressed: () {
                                verifyLogin();
                              }),
                          // const Height(70),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
