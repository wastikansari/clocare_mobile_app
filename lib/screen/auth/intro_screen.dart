import 'package:carousel_slider/carousel_slider.dart';
import 'package:clocare/routes/routes.dart';
import 'package:clocare/screen/auth/login_screen.dart';
import 'package:clocare/screen/auth/registration_screen.dart';
import 'package:clocare/utiles/app_asset.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  int _currentImageIndex = 0;

  final List<String> _imageUrls = [
    AppAsset.intro1,
    AppAsset.intro2,
    AppAsset.intro3,
    AppAsset.intro4,
    AppAsset.intro5,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var d = size.width;
    return Scaffold(
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

            // Image.asset(
            //   AppAsset.intro1,
            //   fit: BoxFit.cover,
            // ),
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
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Container(
                      height: 52,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color: const Color.fromARGB(223, 239, 241, 254),
                            width: 2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.login);
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Color.fromARGB(223, 239, 241, 254),
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don’t have an account yet? ",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: size.height * 0.019,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.register);
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColor.primaryColor2,
                                  foreground: Paint()
                                    ..shader = const LinearGradient(
                                      colors: <Color>[
                                        Color(0xFF174FA2),
                                        Color(0xFF57B1E3),
                                      ],
                                    ).createShader(
                                      const Rect.fromLTWH(
                                          0.0, 0.0, 200.0, 70.0),
                                    ),
                                  fontSize: size.height * 0.019,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialIcon(
                          icon: 'asset/images/linkedin.png',
                          colors: Colors.blue,
                          onTap: () async {
                            await launch(
                                "https://www.linkedin.com/company/clocareindia/");
                          },
                        ),
                        SocialIcon(
                          icon: 'asset/images/insta.png',
                          colors: Colors.orange,
                          onTap: () async {
                            await launch(
                                "https://www.instagram.com/clocareindia/");
                          },
                        ),
                        SocialIcon(
                          icon: 'asset/images/facebook.png',
                          colors: Color.fromARGB(255, 60, 89, 151),
                          onTap: () async {
                            await launch(
                                "https://www.facebook.com/clocareindia/");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String icon;
  final Color colors;
  final Function onTap;

  const SocialIcon({
    Key? key,
    required this.icon,
    required this.colors,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colors),
        ),
        child: Image.asset(
          icon,
          height: 13,
        ),
      ),
    );
  }
}
