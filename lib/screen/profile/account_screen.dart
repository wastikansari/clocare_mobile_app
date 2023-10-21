import 'package:bottom_picker/bottom_picker.dart';
import 'package:clocare/backend/api/profile_api.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/custom_text_field.dart';
import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  ProfileApi profileApi = ProfileApi();
  bool isEditing = true;
  bool isEmailVarify = true;
  bool isLoading = false;
  String user = 'Clocare';
  String number = '';
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  void _toggleEditing() {
    print('value 1 $isEditing');
    if (isEditing == false) {
      print('value 2 $isEditing');
      updateProfile();
    } else {
      print('value 3 $isEditing');
      setState(() {
        isEditing = false;
      });
    }
  }

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
          number = data!.mobile.toString();
          user = data.name.toString();
          userController.text = data.name.toString();
          phoneNumberController.text = data.mobile.toString();
          emailController.text = data.email.toString();
          isEmailVarify = data.emailVerified!;
          dobController.text = data.dob.toString();
        });
      }
    });
  }

  updateProfile() async {
    String name = userController.text.trim();
    String email = emailController.text.trim();
    String gender = '';
    String dob = dobController.text;

    if (name.isEmpty) {
      showCustomSnackBar(title: 'Name', 'Please enter name');
    } else if (email.isEmpty) {
      showCustomSnackBar(title: 'Email', 'Please enter your email id');
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar(title: 'Email', 'Email is not valid');
    } else if (dob.isEmpty) {
      showCustomSnackBar(title: 'Date of Birth', 'Please enter your DOB');
    } else {
      setState(() {
        isLoading = true;
      });
      print('data to save $name and $email and $gender and $dob');
      await profileApi.profileUpdate(name, email, gender, dob).then((value) {
        if (value.status == true) {
          getData();
          showCustomSnackBar(title: 'Profile', 'profile update successfully');
          setState(() {
            isEditing = true;
            isLoading = false;
          });
        } else {
          setState(() {
            isEditing = true;
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomFold(
      appBar: 'Account',
      isShowBack: true,
      bodys: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
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
                                text: user[0],
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
                              text: user,
                              fontweights: FontWeight.w500,
                              size: 18,
                              color: Colors.white,
                            ),
                            const Height(5),
                            SmallText(
                              text: '+91 $number',
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
                  padding: const EdgeInsets.all(20),
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
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {
                                _toggleEditing();
                              },
                              child: isLoading
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: AppColor.primaryColor1,
                                      size: 25,
                                    )
                                  : SmallText(
                                      text: isEditing ? 'EDIT' : 'SAVE',
                                      size: 12,
                                      color: Colors.blueAccent,
                                      fontweights: FontWeight.w900,
                                    )),
                        ],
                      ),
                      const Height(20),
                      CustomTextField(
                        hintTexts: 'name',
                        labelText: 'username',
                        controller: userController,
                        readOnlys: isEditing,
                      ),
                      const Height(24),
                      CustomTextField(
                        labelText: 'Phone no',
                        controller: phoneNumberController,
                        readOnlys: true,
                        suffix: SmallText(
                          text: 'verify',
                          color: Colors.blueAccent,
                          fontweights: FontWeight.bold,
                        ),
                        hintTexts: '88-33-333-333',
                      ),
                      const Height(24),
                      CustomTextField(
                        labelText: 'Email id',
                        controller: emailController,
                        readOnlys: isEditing,
                        hintTexts: 'example@gmail.com',
                        suffix: SmallText(
                          text: isEmailVarify ? 'verify' : 'not-verify',
                          color: Colors.blueAccent,
                          fontweights: FontWeight.bold,
                        ),
                      ),
                      // const Height(24),
                      // CustomTextField(
                      //   labelText: 'gender',
                      //   controller: emailController,
                      //   readOnlys: true,
                      //   suffix: const Icon(
                      //     IconlyLight.arrow_down_2,
                      //     color: Colors.blueAccent,
                      //     size: 15,
                      //   ),
                      //   hintTexts: 'male',
                      //   onTaps: () {
                      //     if (!isEditing) {
                      //       bottomSheetGender(context);
                      //     }
                      //   },
                      // ),
                      const Height(24),
                      CustomTextField(
                        labelText: 'Date of birth',
                        controller: dobController,
                        readOnlys: true,
                        hintTexts: 'dd-mm-yy',
                        onTaps: () {
                          if (!isEditing) {
                            bottomSheet(context);
                          }
                        },
                      ),
                      const Height(24),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bottomSheet(context) {
    // print('bbbbbb call 1');
    BottomPicker.date(
      title: "Set your Birthday",
      titlePadding: const EdgeInsets.all(5),
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: AppColor.primaryColor1),
      onSubmit: (index) {
        setState(() {
          String dobs = index.toString().split(' ')[0].toString();
          dobController.text = dobs;
        });
      },
      buttonWidth: MediaQuery.of(context).size.width / 1.5,
    ).show(context);
  }

  // bottomSheetGender(context) {
  //   showModalBottomSheet(
  //       backgroundColor: Colors.white,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(20),
  //         ),
  //       ),
  //       context: context,
  //       builder: (context) {
  //         return Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: <Widget>[
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   SmallText(
  //                     text: 'Gender',
  //                     size: 16,
  //                     color: AppColor.primaryColor1,
  //                     fontweights: FontWeight.w500,
  //                   ),
  //                   InkWell(
  //                       onTap: () {
  //                         Get.back();
  //                       },
  //                       child: const Icon(Icons.close)),
  //                 ],
  //               ),
  //               const Height(30),
  //               Padding(
  //                 padding: const EdgeInsets.all(15),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     CircleBox(
  //                         title: 'Male',
  //                         icon: Icon(
  //                           Icons.male,
  //                           color: AppColor.appBarColor,
  //                         ),
  //                         onPressed: () {

  //                           // setState(() {
  //                           //   isSelectGender =2;
  //                           // });
  //                         }),
  //                     CircleBox(
  //                         title: 'Female',
  //                         icon: Icon(
  //                           Icons.female,
  //                           color: AppColor.appBarColor,
  //                         ),
  //                         onPressed: () {
  //                           // setState(() {});
  //                         }),
  //                     CircleBox(
  //                         title: 'Other',
  //                         icon: Icon(
  //                           Icons.open_with_rounded,
  //                           color: AppColor.appBarColor,
  //                         ),
  //                         onPressed: () {
  //                           // setState(() {});
  //                         }),
  //                   ],
  //                 ),
  //               ),
  //               const Height(20),
  //             ],
  //           ),
  //         );
  //       });
  // }
}

class CircleBox extends StatelessWidget {
  final String title;

  final Widget icon;
  final Function onPressed;
  final Color borderColor;
  const CircleBox(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.borderColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 1),
              borderRadius: BorderRadius.circular(15)),
          child: IconButton(
              icon: icon,
              onPressed: () {
                onPressed();
              }),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(
              color: AppColor.appBarColor, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}











// import 'package:flutter/material.dart';



// class AccountScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Profile App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ProfileScreen(),
//     );
//   }
// }

// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   bool isEditing = false;
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();

//   @override
//   void dispose() {
//     usernameController.dispose();
//     emailController.dispose();
//     phoneNumberController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Screen'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Personal Details',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Username:',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 isEditing
//                     ? ElevatedButton(
//                         onPressed: _toggleEditing,
//                         child: Text('Save'),
//                       )
//                     : TextButton(
//                         onPressed: _toggleEditing,
//                         child: Text('Edit'),
//                       ),
//               ],
//             ),
//             TextFormField(
//               controller: usernameController,
//               readOnly: !isEditing,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Email ID:',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             TextFormField(
//               controller: emailController,
//               readOnly: !isEditing,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Phone Number:',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             TextFormField(
//               controller: phoneNumberController,
//               readOnly: !isEditing,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _toggleEditing() {
//     setState(() {
//       isEditing = !isEditing;
//     });
//   }
// }

