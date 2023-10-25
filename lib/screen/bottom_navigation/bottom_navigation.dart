import 'package:clocare/screen/basket/basket_screen.dart';
import 'package:clocare/screen/home/home_screen.dart';
import 'package:clocare/screen/orders/order_screen.dart';
import 'package:clocare/screen/package/package_screen.dart';
import 'package:clocare/screen/profile/profile_screen.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavigation extends StatefulWidget {
  final int? indexset;
  const BottomNavigation({super.key, this.indexset = 0});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
     OrderScreen(),
    const BasketScreen(
      visible: true,
    ),
    PackageScreen(),
    ProfileScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    // Color inactiveColor = Color.fromARGB(179, 184, 205, 241);
    Color inactiveColor = const Color.fromARGB(179, 87, 87, 87);
    Color activeColor = AppColor.primaryColor1;

    return [
      PersistentBottomNavBarItem(
        icon: const Icon(IconlyLight.home),
        title: ("Home"),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(IconlyLight.play),
        title: ("Order"),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(50),
          //   gradient: const LinearGradient(colors: [
          //     Color.fromARGB(255, 18, 112, 245),
          //     Color(0xFF174FA2),
          //   ]),
          // ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'asset/icons/cart.png',
                  // height: 20,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              // Positioned(
              //   right: 0,
              //   child: Container(
              //       decoration: BoxDecoration(
              //         color: const Color.fromARGB(109, 255, 255, 255),
              //         borderRadius: BorderRadius.circular(50),
              //         border: Border.all(color: Colors.yellow, width: 2),
              //         // color: const Color(0xFFF9F8FF),
              //         boxShadow: [
              //           BoxShadow(
              //             color: AppColor.boxShadowColor,
              //             blurRadius: 4.0,
              //             spreadRadius: 2.0,
              //             offset: const Offset(0.0, 0.0),
              //           )
              //         ],
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(3),
              //         child: SmallText(
              //           text: '15',
              //           color: Colors.red,
              //           size: 10,
              //           // fontweights: FontWeight.w500,
              //         ),
              //       )),
              // )
            ],
          ),
        ),
        title: ("Basket"),
        textStyle: TextStyle(color: activeColor),
        activeColorSecondary: activeColor,
        activeColorPrimary: AppColor.primaryColor1,
        inactiveColorPrimary: inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(IconlyLight.document),
        title: ("Package"),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(IconlyLight.profile),
        title: ("Profile"),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
      ),
    ];
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      currentIndex = widget.indexset!;
      print('currnt index $currentIndex');
      _controller = PersistentTabController(initialIndex: currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _screens[_currentIndex],
      bottomNavigationBar: PersistentTabView(
        context,
        controller: _controller,
        navBarHeight: 60,
        screens: _screens,
        items: _navBarsItems(),
        confineInSafeArea: true,
        // backgroundColor: AppColor.boxColor,
        backgroundColor: const Color.fromARGB(255, 253, 253, 254),
        //  backgroundColor: Colors.black,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: false,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        margin: const EdgeInsets.only(
          bottom: 5,
        ),
        decoration: NavBarDecoration(
          // border: Border(top: BorderSide(color: AppColor.appBarColor,width: 1 )),

          borderRadius: BorderRadius.circular(0),
          colorBehindNavBar: AppColor.boxColor,
        ),
        popAllScreensOnTapOfSelectedTab: false,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,
      ),
    );
  }
}
