import 'package:clocare/screen/address/address_add_screen.dart';
import 'package:clocare/screen/address/address_screen.dart';
import 'package:clocare/screen/auth/login_screen.dart';
import 'package:clocare/screen/auth/registration_screen.dart';
import 'package:clocare/screen/auth/splash_screen.dart';
import 'package:clocare/screen/bottom_navigation/bottom_navigation.dart';
import 'package:clocare/screen/home/notification_screen.dart';
import 'package:clocare/screen/home/rate_card_screen.dart';
import 'package:clocare/screen/home/services_screen.dart';
import 'package:clocare/screen/offer/offer_screen.dart';
import 'package:clocare/screen/orders/order_screen.dart';
import 'package:clocare/screen/wallet/wallet_screen.dart';
import 'package:clocare/screen/profile/account_screen.dart';
import 'package:clocare/screen/profile/coupons_screen.dart';
import 'package:clocare/screen/profile/refer_earn_screen.dart';
import 'package:clocare/screen/profile/subscriptions_screen.dart';
import 'package:clocare/screen/wallet/transactions_screen.dart';
import 'package:get/get.dart';
import '../screen/auth/intro_screen.dart';
import '../screen/onboarding copy/intro_screen.dart';

abstract class Routes {
  static const String inital = "/"; // splash_screen
  static const String onBoardingScreen = "/onBoarding_screen";
  static const String intro = "/Intro_screen";
  static const String login = "/login_screen";
  static const String register = "/register_screen";
  static const String bottomNavigation = "/bottom-navigation";
  static const String notification = "/notification"; // Fix the typo here
  static const String account = "/account_screen";
  static const String wallet = "/wallet_screen";
  static const String coupons = "/coupons_screen";
  static const String refer = "/refer_screen";
  static const String transactions = "/transactions_screen";
  static const String subscriptions = "/subscriptions_screen";
  static const String address = "/address_screen";
  static const String addressAdd = "/address_add_screen";
  static const String rateCard = "/ratecard_screen";
  static const String service = "/service_screen";
  static const String orders = "/orders_screen";
  static const String offer = "/offer_screen";
}

class RouteHelper {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.inital,
      page: () => const SplashScreen(),
      transition: Transition.circularReveal
    ),
    GetPage(
      name: Routes.onBoardingScreen,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: Routes.intro,
      page: () => const IntroScreen(),
      transition: Transition.circularReveal
    ),
    GetPage(
        name: Routes.register,
        page: () => const RegistrationScreen(),
        transitionDuration: const Duration(seconds: 1),
        transition: Transition.circularReveal),
    GetPage(
        name: Routes.login,
        page: () => const LoginScreen(),
        transitionDuration: const Duration(seconds: 1),
        transition: Transition.circularReveal),
    GetPage(
      name: Routes.bottomNavigation,
      page: () => const BottomNavigation(),
    ),
    GetPage(
        name: Routes.notification,
        page: () => const NotificationsScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.wallet,
        page: () => const WalletScreen(),
        // transitionDuration: const Duration(seconds: 1),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.account,
        page: () => const AccountScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.coupons,
        page: () => const CouponsScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.refer,
        page: () => const ReferScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.transactions,
        page: () => TransactionsScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.subscriptions,
        page: () => const SubscriptionsScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.address,
        page: () => const AddressScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.addressAdd,
        page: () => const AddressAddScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.rateCard,
        page: () => const RateCardScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.addressAdd,
        page: () => const AddressAddScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.service,
        page: () => const ServicesScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.orders,
        page: () => OrderScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.offer,
        page: () => const OfferScreen(),
        transition: Transition.rightToLeft)
  ];
}
