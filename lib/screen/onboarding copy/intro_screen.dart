import 'package:avatar_glow/avatar_glow.dart';
import 'package:clocare/screen/auth/intro_screen.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var controller = PageController();
  bool isLastPage = false;

  next() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 3;
              });
            },
            children: [
              PagesWiget(
                img: Lottie.asset('asset/svg/intro.json', height: 350),
                title1: 'Join to Clocare',
                title2: 'Delivery partner',
                text1:
                    'Join our team of dedicated delivery heroes and make every laundry drop-off a breeze.',
              ),
              PagesWiget(
                img: Image.asset('asset/images/onboarding/page-1.png'),
                title1: 'Earn as You',
                title2: 'Deliver',
                text1:
                    'Turn your routes into earning routes. Maximize your income and enjoy the flexibility of being a part of our delivery family.',
              ),
              PagesWiget(
                img: Image.asset('asset/images/onboarding/page-2.png'),
                title1: 'Efficiency at Your',
                title2: 'Fingertips',
                text1:
                    "With our app, you're in control. Manage your deliveries with ease and ensure each garment reaches its destination right on time.",
              ),
              PagesWiget(
                img: Image.asset('asset/images/onboarding/page-3.png'),
                title1: 'Customer',
                title2: 'Happiness Delivered',
                text1:
                    'Your friendly service can bring smiles. Be the bridge between clean laundry and happy customers.',
              ),
            ],
          ),
          Positioned(
            bottom: 90,
            left: 30,
            child: Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 4,
                effect: WormEffect(
                    radius: 13,
                    dotHeight: 9,
                    dotWidth: 9,
                    dotColor: const Color.fromARGB(255, 207, 207, 207),
                    activeDotColor: AppColor.primaryColor1),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: isLastPage
                ? Center(
                    child: InkWell(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        var ff = prefs.setBool('showHome', true);
                        print('ddddddddddddd $ff');
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IntroScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.primaryColor1),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 60, right: 60, top: 17, bottom: 17),
                          child: Center(
                            child: SmallText(
                              text: 'Start',
                              size: 15,
                              fontweights: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: InkWell(
                    onTap: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    },
                    child: AvatarGlow(
                      glowColor: AppColor.primaryColor1,
                      endRadius: 60.0,
                      child: Material(
                        // Replace this child with your own
                        elevation: 0.0,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                            backgroundColor: AppColor.primaryColor1,
                            radius: 30.0,
                            child: const Center(
                                child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ))),
                      ),
                    ),
                  )),
          )
        ],
      ),
    );
  }
}

class PagesWiget extends StatelessWidget {
  final String title1;
  final String title2;
  final Widget img;
  final String text1;

  const PagesWiget({
    super.key,
    required this.img,
    required this.title1,
    required this.title2,
    required this.text1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Height(40),
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'asset/images/clocare-logo-original.png',
                  height: 27,
                )),
            const Height(20),
            Align(alignment: Alignment.center, child: img),
            const Height(50),
            SmallText(
              text: title1,
              size: 30,
              overFlow: TextOverflow.visible,
              fontweights: FontWeight.w500,
              color: AppColor.primaryColor1,
            ),
            SmallText(
              text: title2,
              size: 22,
              overFlow: TextOverflow.visible,
              fontweights: FontWeight.w500,
              color: Colors.black,
            ),
            const Height(20),
            Align(
              alignment: Alignment.bottomLeft,
              child: SmallText(
                text: text1,
                overFlow: TextOverflow.visible,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
