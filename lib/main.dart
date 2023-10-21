import 'package:clocare/backend/controller/garment_controller.dart';
import 'package:clocare/backend/controller/profile_controller.dart';
import 'package:clocare/routes/routes.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Get.lazyPut(() => ProfileController());
  Get.lazyPut(() => GarmentController());
  WidgetsFlutterBinding.ensureInitialized();
  // init the hive
  await Hive.initFlutter();

  // open a box
  await Hive.openBox('basketBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.find<ProfileController>().getProfileData();
    Get.find<GarmentController>().getGarmentList();
    return GetMaterialApp(
      theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
        thumbColor: MaterialStateProperty.all(Colors.grey[500]),
      )),
      debugShowCheckedModeBanner: false,
      title: AppConstants.APP_NAME,
      getPages: RouteHelper.routes,
      // home: MerchantApp(),
      // /AddressScreen(),
      // ContainerList()
      // TabBarExample()
      // BottomNavigation()
      // AirtelAppBarScreen()
      // SplashScreen(),
    );
  }
}
