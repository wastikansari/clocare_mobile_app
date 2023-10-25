import 'dart:async';
import 'package:clocare/routes/routes.dart';
import 'package:clocare/utiles/app_asset.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();

  //   Timer(const Duration(seconds: 3), () async {
  //     Get.offAllNamed(Routes.intro);
  //   });
  // }



    @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      _checkLogedIn();
    });
  }

  void _checkLogedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final tkn = prefs.getString(AppConstants.TOKEN);
    print('token is $tkn');
    if (tkn != null && tkn.isNotEmpty) {
      Get.offAllNamed(Routes.bottomNavigation);
    } else {
       Get.offAllNamed(Routes.intro);
      // Get.offAllNamed(Routes.onBoardingScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(80),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppAsset.logo,
              ),
              // fit: BoxFit.cover
            ),
          ),
        ),
      ),
    );
  }
}
