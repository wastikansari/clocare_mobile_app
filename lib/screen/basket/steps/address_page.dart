import 'package:clocare/backend/api/address_api.dart';
import 'package:clocare/backend/model/address_model.dart';
import 'package:clocare/routes/routes.dart';
import 'package:clocare/screen/address/address_screen.dart';
import 'package:clocare/screen/address/address_update_screen.dart';
import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/app_asset.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddressPage extends StatefulWidget {
  final Function(Map) callback;
  const AddressPage({super.key, required this.callback});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  AddressApi addressApi = AddressApi();

  int isSelectAddress = -1;

  // void sendDataToParent() {
  //   setState(() {

  //     widget.callback(pickupformatAddress);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Height(20),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.boxColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 2),
                // color: const Color(0xFFF9F8FF),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.boxShadowColor,
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0.0, 0.0),
                  )
                ],
              ),
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.addressAdd);
                },
                child: Center(
                    child: SmallText(
                  text: 'Add address',
                  fontweights: FontWeight.w500,
                  color: AppColor.appBarColor,
                )),
              ),
            ),
            const Height(30),
            FutureBuilder<AddressModel>(
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
                            String? addressType = allData[index].addressType;
                            String? addressLabel = allData[index].addressLabel;
                            bool? status = allData[index].status;
                            String? formatAddress =
                                allData[index].formatAddress;
                            // widget.callback(pickupformatAddress);
                            // if (status == true) {
                            //   pickupformatAddress = formatAddress!;
                            // }
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
                                bgColor: isSelectAddress == index
                                    ? const Color.fromARGB(146, 172, 205, 255)
                                    : AppColor.boxColor,
                                onTap: () {
                                  setState(() {
                                    isSelectAddress = index;
                                    Map data = {
                                      'addressName': formatAddress,
                                      'addressId': addressId,
                                    };

                                    widget.callback(data);
                                  });
                                },
                              ),
                            );
                          });
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Height(10),
                          Image.asset(
                            AppAsset.address,
                            height: 240,
                          ),
                          SmallText(
                            text: 'No address found',
                          ),
                          const Height(5),
                          SmallText(
                            text: 'Please add your address for order pickup',
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
                }),
          ],
        ),
      ),
    );
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
}
