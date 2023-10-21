import 'package:clocare/backend/api/address_api.dart';
import 'package:clocare/backend/model/address_model.dart';
import 'package:clocare/routes/routes.dart';
import 'package:clocare/screen/address/address_update_screen.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/app_asset.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  AddressApi addressApi = AddressApi();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    address();
  }

  address() {
    addressApi.addressList().then((value) {});
  }

  deleteAddress(addressId) {
    print('deleteAddress 1');
    // int id = int.parse(addressId);
    addressApi.addressDelete(addressId).then((value) {
      if (value.status == true) {
        showCustomSnackBar(title: 'Delete', 'Address delete successfully');
      }
    });
  }

  editAddress(
    addressId,
    flatNo,
    street,
    landMark,
    stateName,
    cityName,
    pincodeNo,
    addressType,
    addressLabel,
    status,
  ) {
    print('dddddddddd');

    Get.to(
        AddressUpdateScreen(
          addressId: addressId,
          flatNo: flatNo,
          street: street,
          landMark: landMark,
          stateName: stateName,
          cityName: cityName,
          pincodeNo: pincodeNo,
          addressType: addressType,
          addressLabel: addressLabel,
          status: status,
        ),
        transition: Transition.rightToLeft);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomFold(
          appBar: 'My Address',
          isShowBack: true,
          bodys: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: FutureBuilder<AddressModel>(
                    future: addressApi.addressList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var allData = snapshot.data!.data;
                        if (allData!.isNotEmpty) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: allData!.length,
                              itemBuilder: (BuildContext context, int index) {
                                String? addressId = allData[index].sId;
                                String? flatNo = allData[index].flatNo;
                                String? street = allData[index].street;
                                String? landMark = allData[index].landmark;
                                String? stateName = allData[index].stateName;
                                String? cityName = allData[index].cityName;
                                String? pincodeNo = allData[index].pincodeNo;
                                String? addressType =
                                    allData[index].addressType;
                                String? addressLabel =
                                    allData[index].addressLabel;
                                bool? status = allData[index].status;
                                String? formatAddress =
                                    allData[index].formatAddress;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: AddressBoxWidget(
                                    addressType: addressType!,
                                    address: formatAddress!,
                                    status: status!,
                                    deleteOnTap: () {
                                      Get.back();
                                      deleteAddress(addressId);
                                    },
                                    editOnTap: () {
                                      Get.back();
                                      print('edit');
                                      editAddress(
                                        addressId,
                                        flatNo,
                                        street,
                                        landMark,
                                        stateName,
                                        cityName,
                                        pincodeNo,
                                        addressType,
                                        addressLabel,
                                        status,
                                      );
                                    },
                                  ),
                                );
                              });
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Height(150),
                              Image.asset(
                                AppAsset.address,
                                height: 240,
                              ),
                              SmallText(
                                text: 'No address found',
                              ),
                              const Height(5),
                              SmallText(
                                text:
                                    'Please add your address for order pickup',
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                child: SmallText(
                                  text: 'Refresh',
                                  fontweights: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          );
                        }
                      } else {
                        return LoadingAnimationWidget.fourRotatingDots(
                          color: AppColor.primaryColor2,
                          size: 20,
                        );
                      }
                    })),
          )),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: AppColor.primaryColor1,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [AppColor.primaryColor1, AppColor.primaryColor2])),
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        onPressed: () {
          Get.toNamed(Routes.addressAdd);
        },
      ),
    );
  }
}

class AddressBoxWidget extends StatelessWidget {
  final String addressType;
  final String address;
  final Function editOnTap;
  final Function deleteOnTap;
  final Function? onTap;
  final bool status;
  final Color? bgColor;
  const AddressBoxWidget({
    super.key,
    required this.addressType,
    required this.address,
    required this.editOnTap,
    required this.deleteOnTap,
    required this.status,
    this.onTap,
    this.bgColor = const Color(0xFFF9F8FF),
  });

  @override
  Widget build(BuildContext context) {
    bool isSelect = false;
    return InkWell(
      onTap: () {
        onTap!();
        // bottomSheetPage(context, editOnTap, deleteOnTap);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 4.0,
          //     color: Color.fromARGB(255, 228, 228, 228),
          //     spreadRadius: 01.0,
          //   ),
          // ],
          border: Border.all(color: Colors.white, style: BorderStyle.solid),
          color: bgColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFe7e7ff),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              IconlyLight.location,
                              size: 13,
                            ),
                          )),
                      const Widths(10),
                      SmallText(
                        overFlow: TextOverflow.visible,
                        text: addressType,
                        color: Colors.black,
                        fontweights: FontWeight.w500,
                        size: 15,
                      ),
                      const Widths(6),
                      SmallText(
                        overFlow: TextOverflow.visible,
                        text: status == true ? '(Default)' : '',
                        color: AppColor.primaryColor1,
                        fontweights: FontWeight.w500,
                        size: 12,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      print('eeeeeeeee');
                      bottomSheetPage(context, editOnTap, deleteOnTap);
                    },
                    child: const Icon(
                      Icons.more_vert,
                      size: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Height(10),
              Padding(
                padding: const EdgeInsets.all(5),
                child: SmallText(
                  overFlow: TextOverflow.visible,
                  text: address,
                  color: Colors.black,
                  // fontweights: FontWeight.w500,
                  size: 13,
                ),
              ),
              const Height(20),
              // Row(
              //   children: [
              //     Icon(Icons.edit, size: 16, color: Colors.blueAccent,),
              //     Widths(10),
              //     Icon(Icons.delete, size: 16, color: Colors.red,),
              //   ],
              // )
              // Row(
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         print('Edit');

              //         editOnTap();
              //       },
              //       child: Container(
              //         width: 60,
              //         height: 30,
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //               color: Colors.white, style: BorderStyle.solid),
              //           // color: const Color.fromARGB(145,228,241,252),
              //           color: AppColor.backgroundColor,
              //           borderRadius: const BorderRadius.all(
              //             Radius.circular(8),
              //           ),
              //         ),
              //         child: Center(
              //           child: SmallText(
              //             text: 'Edit',
              //             color: AppColor.primaryColor1,
              //           ),
              //         ),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 15,
              //     ),
              //     InkWell(
              //       onTap: () {
              //         print('DELETE');
              //         showDialog<String>(
              //           context: context,
              //           builder: (BuildContext context) => AlertDialog(
              //             title: const Text('Delete'),
              //             content: const Text(
              //                 'Are you sure want to delete this address'),
              //             actions: <Widget>[
              //               TextButton(
              //                 onPressed: () => Navigator.pop(context, 'Cancel'),
              //                 child: const Text('Cancel'),
              //               ),
              //               TextButton(
              //                 onPressed: () {
              //                   deleteOnTap();
              //                   Navigator.pop(context, 'OK');
              //                 },
              //                 child: const Text('OK'),
              //               ),
              //             ],
              //           ),
              //         );
              //       },
              //       child: Container(
              //         width: 60,
              //         height: 30,
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //               color: Colors.white, style: BorderStyle.solid),
              //           // color: const Color
              //           //         .fromARGB(
              //           //     145,
              //           //     228,
              //           //     241,
              //           //     252),
              //           color: AppColor.backgroundColor,
              //           borderRadius: const BorderRadius.all(
              //             Radius.circular(8),
              //           ),
              //         ),
              //         child: Center(
              //           child: SmallText(
              //             text: 'Delete',
              //             color: const Color.fromARGB(255, 209, 20, 6),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  void bottomSheetPage(BuildContext context, editOnTap, deleteOnTap) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        // backgroundColor: AppColor.appBarColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.appBarColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Height(20),
                  Container(
                    height: 5,
                    width: 45,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 128, 128, 128),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  const Height(20),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleBox(
                          title: 'Edit',
                          tooltip: 'update your address',
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            editOnTap();
                          },
                          bgColor: const Color.fromARGB(38, 0, 140, 255),
                        ),
                        const SizedBox(
                          width: 55,
                        ),
                        CircleBox(
                          title: 'Delete',
                          tooltip: 'delete the address',
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteOnTap();
                          },
                          bgColor: const Color.fromARGB(38, 253, 24, 8),
                        ),
                      ],
                    ),
                  ),
                  const Height(20),
                ],
              ),
            ),
          );
        });
  }
}

class BoxType extends StatelessWidget {
  Color backgroundColor;
  Color? textColor;
  final String title;

  Function onTap;
  BoxType(
      {super.key,
      required this.backgroundColor,
      required this.title,
      required this.onTap,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 20,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white, width: 1),
          color: backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(29, 185, 185, 185),
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: Offset(0.0, 0.0),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SmallText(
              text: title,
              color: textColor,
              fontweights: FontWeight.w500,
              size: 9,
            ),
          ),
        ),
      ),
    );
  }
}

class CircleBox extends StatelessWidget {
  final String title;
  final String tooltip;
  final Widget icon;
  final Function onPressed;
  final Color borderColor;
  final Color bgColor;
  const CircleBox(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed,
      required this.tooltip,
      this.borderColor = Colors.grey,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 2),
              color: bgColor,
              borderRadius: BorderRadius.circular(50)),
          child: IconButton(
              icon: icon,
              tooltip: tooltip,
              onPressed: () {
                onPressed();
              }),
          // Center(child: Icon(Icons.camera_alt_outlined)),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
