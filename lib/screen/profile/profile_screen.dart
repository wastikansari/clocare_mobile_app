import 'package:clocare/backend/api/profile_api.dart';
import 'package:clocare/backend/controller/profile_controller.dart';
import 'package:clocare/backend/model/login_model.dart';
import 'package:clocare/routes/routes.dart';
import 'package:clocare/screen/home/home_screen.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileApi profileApi = ProfileApi();
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.get(AppConstants.TOKEN));

    prefs.remove(AppConstants.TOKEN);
    print(prefs.get(AppConstants.TOKEN));

    Get.offAllNamed(Routes.intro);
  }

  LoginModel loginModel = LoginModel();

  ProfileController profileController = Get.put(ProfileController());

  String userName = 'Clocare';
  String phone = '';
  int walletBalance = 0;
  int unpaidBalance = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    profileApi.profileData().then((value) {
      if (value.status == true) {
        var data = value.data;
        setState(() {
          phone = data!.mobile.toString();
          userName = data.name.toString();
          walletBalance = data.walletBalance!;
          unpaidBalance = data.unpaidBalance!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('dddddddddddd ${loginModel.data}');
    return CustomFold(
        appBar: 'Profile',
        leading: IconButtonWidet(
          icon: IconlyLight.wallet,
          onPress: () {
            Get.toNamed(Routes.wallet);
          },
        ),
        bodys: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 18, 112, 245),
                        Color(0xFF174FA2),
                      ]),
                      color: AppColor.appBarColor,
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
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blueAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Center(
                                    child: SmallText(
                                  text: userName[0].toString(),
                                  size: 28,
                                  color: Colors.white,
                                )),
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                text: userName,
                                fontweights: FontWeight.w500,
                                size: 18,
                                color: Colors.white,
                              ),
                              const Height(5),
                              SmallText(
                                text: '+91 $phone',
                                size: 12,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                const Height(30),
                Container(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textBox(
                          title: 'wallet amount',
                          amount: '$walletBalance',
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: AppColor.primaryColor1,
                        ),
                        textBox(
                          title: 'Unpaid amount',
                          amount: unpaidBalance.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                const Height(30),
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
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, right: 20, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SmallText(
                        //   text: 'SETTING',
                        //   color: const Color.fromARGB(255, 155, 162, 207),
                        //   fontweights: FontWeight.w500,
                        // ),
                        // const Height(20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTileBox(
                              title: 'account',
                              icon: IconlyLight.profile,
                              onTap: () {
                                Get.toNamed(
                                  Routes.account,
                                );
                                // Get.to(const AccountScreen(),
                                //     transition: Transition.rightToLeft,
                                //     arguments: userProfile);
                              },
                            ),
                            ListTileBox(
                              title: 'my address',
                              icon: IconlyLight.location,
                              onTap: () {
                                Get.toNamed(Routes.address);
                              },
                            ),
                            ListTileBox(
                              title: 'orders',
                              icon: IconlyLight.chart,
                              onTap: () {
                                Get.toNamed(Routes.orders);
                              },
                            ),
                            ListTileBox(
                              title: 'wallet',
                              icon: IconlyLight.wallet,
                              onTap: () {
                                Get.toNamed(Routes.wallet);
                              },
                            ),
                            ListTileBox(
                              title: 'notification',
                              icon: IconlyLight.notification,
                              onTap: () {
                                Get.toNamed(Routes.notification);
                              },
                            ),
                            ListTileBox(
                              title: 'coupons',
                              icon: IconlyLight.bag,
                              onTap: () {
                                Get.toNamed(Routes.coupons);
                              },
                            ),
                            ListTileBox(
                              title: 'refer a earn',
                              icon: IconlyLight.add_user,
                              onTap: () {
                                Get.toNamed(Routes.refer);
                              },
                            ),
                            ListTileBox(
                              title: 'transactions',
                              icon: IconlyLight.activity,
                              onTap: () {
                                Get.toNamed(Routes.transactions);
                              },
                            ),
                            ListTileBox(
                              title: 'subscriptions',
                              icon: IconlyLight.category,
                              onTap: () {
                                Get.toNamed(Routes.subscriptions);
                              },
                            ),
                            ListTileBox(
                              title: 'rate card',
                              icon: IconlyLight.arrow_right_square,
                              onTap: () {
                                Get.toNamed(Routes.rateCard);
                              },
                            ),
                            ListTileBox(
                              title: 'Logout',
                              icon: IconlyLight.logout,
                              onTap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Logout'),
                                    content: const Text(
                                        'Do you really wants to logout?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'No'),
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          logout();

                                          Navigator.pop(context, 'Yes');
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Height(40),
                Container(
                  alignment: Alignment.center,
                  child: SmallText(
                    text: 'Version 2.0.1',
                    color: Colors.grey,
                    fontweights: FontWeight.w500,
                    size: 11,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}

class textBox extends StatelessWidget {
  final String title;
  final String amount;
  const textBox({
    super.key,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmallText(
          text: '₹$amount',
          size: 16,
          fontweights: FontWeight.w500,
          color: AppColor.primaryColor1,
        ),
        const Height(10),
        // SmallText(text: 'Wallet Balances', ),
        SmallText(
          text: title,
          size: 12,
          fontweights: FontWeight.w500,
          color: AppColor.appBarColor, // const Color.fromARGB(157, 0, 0, 0),
        ),
      ],
    );
  }
}       

class CustumListTile extends StatelessWidget {
  final String title;
  final Function onTap;
  final Widget icon;
  const CustumListTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(
          color: Color.fromARGB(255, 238, 238, 238),
        ),
      ),
      elevation: 0,
      shadowColor: Colors.grey,
      child: ListTile(
        leading: icon,
        title: Text(title),
        tileColor: Colors.white,
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}

class ListTileBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  const ListTileBox({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.black87,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.white, width: 0.1),
                  color: const Color(0xFFe7e7ff),
                ),
                child: Icon(
                  icon,
                  size: 24,
                ),
              ),
              const Widths(18),
              SmallText(
                text: title,
                size: 15,
                fontweights: FontWeight.w500,
                color: AppColor.appBarColor,//Color.fromARGB(189, 0, 0, 0),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
