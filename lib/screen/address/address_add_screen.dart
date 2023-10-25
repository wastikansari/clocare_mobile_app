import 'package:clocare/backend/api/address_api.dart';
import 'package:clocare/backend/current_location.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/button_widget.dart';
import 'package:clocare/screen/widget/dropdown_button.dart';
import 'package:clocare/screen/widget/show_custom_snackbar.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/screen/widget/text_field.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddressAddScreen extends StatefulWidget {
  const AddressAddScreen({super.key});

  @override
  State<AddressAddScreen> createState() => _AddressAddScreenState();
}

class _AddressAddScreenState extends State<AddressAddScreen> {
  AddressApi addressApi = AddressApi();
  GetCurrentLocation getCurrentLocation = GetCurrentLocation();
  int selectBox = -1;
  bool isLoading = false;
  bool isLoadingButton = false;
  bool isVisibel = false;
  bool statusChecked = false;
  var flatController = TextEditingController();
  var societyController = TextEditingController();
  var landmarkController = TextEditingController();
  var pincodeController = TextEditingController();
  var selectCity = '';
  var selectState = 'Gujarat';
  String address = '';
  List addressType = ['Home', 'Work', 'Hostel/PG', 'Other'];
  var selectAddressType = '';
  var city = [
    'Vadodara',
    'Ahmedabad',
  ];

  var state = [
    'Gujarat',
  ];

  static const LatLng _kMapCenter =
      LatLng(22.305247140700075, 73.17318915391476);

  static const CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  getLocation() {
    setState(() {
      isLoading = true;
    });
    getCurrentLocation.getCurrentLocation().then((value) {
      print('mmmmmmmmmmmmmmm ${value.name}');
      setState(() {
        address =
            '${value.street}, ${value.subLocality}, ${value.thoroughfare}, ${value.locality}, ${value.administrativeArea}, ${value.country}, ${value.postalCode}';
        // societyController.text = value.Street;
        // landmarkController.text = value.Sublocality;
        // _selectedCity = value.Locality;
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  saveAddress() async {
    String flatNo = flatController.text.trim();
    String street = societyController.text.trim();
    String landMark = landmarkController.text.trim();
    int stateId = 9;
    String stateName = selectState;
    String cityId = '7';
    String cityName = selectCity;
    String pincodeId = '0';
    String pincodeNo = pincodeController.text.trim();
    String addressType = selectAddressType;
    String addressLabel = 'Pickup';
    bool status = statusChecked;

    if (addressType.isEmpty) {
      showCustomSnackBar(title: 'Address Type', 'Please select address type');
    } else if (flatNo.isEmpty) {
      showCustomSnackBar(
          title: 'Room no', 'Please enter your Flat no / Room no');
    } else if (street.isEmpty) {
      showCustomSnackBar(
          title: 'Society', 'Please enter your Society / Street');
    } else if (landMark.isEmpty) {
      showCustomSnackBar(
          title: 'Landmark', 'Please enter your Landmark / Area');
    } else if (cityName.isEmpty) {
      showCustomSnackBar(title: 'City', 'Please select your city');
    } else if (pincodeNo.isEmpty) {
      showCustomSnackBar(title: 'Pincode', 'Please enter your Area pincode');
    } else {
      setState(() {
        isLoadingButton = true;
      });
      await addressApi
          .addressCreate(
        flatNo,
        street,
        landMark,
        stateId,
        stateName,
        cityId,
        cityName,
        pincodeId,
        pincodeNo,
        addressType,
        addressLabel,
        status,
      )
          .then((value) {
        if (value.status == true) {
          setState(() {
            isLoadingButton = false;
          });
          Get.back();
        } else {
          setState(() {
            isLoadingButton = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomFold(
        appBar: 'Add Address',
        isShowBack: true,
        bodys: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SmallText(
                //   text: 'Add Address',
                //   size: 20,
                //   color: Colors.black,
                //   fontweights: FontWeight.w500,
                // ),
                const Height(20),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.boxColor,
                    // color: const Color.fromARGB(24, 23, 79, 162),
                    // border: Border.all(
                    //     color: const Color.fromARGB(129, 23, 79, 162), width: 1),
                    // borderRadius: const BorderRadius.all(Radius.circular(15)),

                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColor.boxColor, width: 1),
                    // color: const Color(0xFFF9F8FF),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(29, 185, 185, 185),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(2),
                    child: GoogleMap(
                      // myLocationButtonEnabled: true,
                      // myLocationEnabled: true,
                      // initialCameraPosition: _kInitialPosition,
                      initialCameraPosition: _kInitialPosition,
                      // onMapCreated: onMapCreated,
                      mapType: MapType.normal,
                    ),
                  ),
                ),
                const Height(10),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      getLocation();
                      setState(() {
                        isVisibel = !isVisibel;
                      });
                    },
                    child: Container(
                      height: 38,
                      width: 145,
                      decoration: BoxDecoration(
                        color: AppColor.backgroundColor,

                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white, width: 1),
                        // color: const Color(0xFFF9F8FF),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(29, 185, 185, 185),
                            blurRadius: 6.0,
                            spreadRadius: 2.0,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.my_location_outlined,
                            size: 19,
                            color: AppColor.primaryColor1,
                          ),
                          const Widths(5),
                          SmallText(
                            text: 'Use current location',
                            color: AppColor.primaryColor1,
                            fontweights: FontWeight.w500,
                            size: 11,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Height(10),
                Visibility(
                  visible: isVisibel,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 1),
                        color: const Color(0xFFF9F8FF),
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
                        padding: const EdgeInsets.all(12),
                        child: address.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(20),
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: AppColor.primaryColor1,
                                  size: 35,
                                ),
                              )
                            : SmallText(
                                text: address,
                                overFlow: TextOverflow.visible,
                                color: Colors.black,
                                fontweights: FontWeight.w400,
                              ),
                      ),
                    ),
                  ),
                ),
                SmallText(
                  text: 'Add Address',
                  size: 18,
                  color: Colors.black,
                  fontweights: FontWeight.w500,
                ),
                const Height(10),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: addressType.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                          top: 8,
                        ),
                        child: BoxType(
                          backgroundColor: selectBox == index
                              ? AppColor.primaryButtonColor
                              : AppColor.backgroundColor,
                          textColor:
                              selectBox == index ? Colors.white : Colors.black,
                          title: addressType[index],
                          onTap: () {
                            setState(() {
                              selectBox = index;
                              selectAddressType = addressType[index];
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                const Height(20),
                CustomTextField1(
                  hintText: 'Hous no / Flat no',
                  icon: Icons.room,
                  controller: flatController,
                ),
                const Height(20),
                CustomTextField1(
                  hintText: 'Street / Society',
                  icon: Icons.holiday_village_outlined,
                  controller: societyController,
                ),
                const Height(20),
                CustomTextField1(
                  hintText: 'Landmark / Area',
                  icon: Icons.area_chart_outlined,
                  controller: landmarkController,
                ),
                const Height(20),
                CustomDropDown(
                  hintColor: selectCity.isEmpty ? Colors.grey : Colors.black,
                  icon: Icons.location_city,
                  hintText: selectCity.isEmpty ? 'Select City' : selectCity,
                  items: city.map((String city) {
                    return DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (values) {
                    setState(() {
                      selectCity = values.toString();
                    });
                  },
                ),
                const Height(20),
                CustomDropDown(
                  hintColor: selectState.isEmpty ? Colors.grey : Colors.black,
                  icon: Icons.map_outlined,
                  hintText: selectState.isEmpty ? 'Select State' : selectState,
                  items: state.map((String state) {
                    return DropdownMenuItem(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                  onChanged: (values) {
                    setState(() {
                      selectState = values.toString();
                    });
                  },
                ),
                // CustomTextField1(
                //   hintText: 'State',
                //   icon: Icons.maps_home_work_rounded,
                //   controller: pincodeController,
                //   keyboardType: TextInputType.number,
                // ),
                const Height(20),
                CustomTextField1(
                  hintText: 'Pincode',
                  icon: Icons.area_chart_outlined,
                  controller: pincodeController,
                  keyboardType: TextInputType.number,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: SmallText(
                    text: 'Save as Primary Address',
                    color: Colors.black,
                    fontweights: FontWeight.w400,
                  ),
                  activeColor: AppColor.primaryColor1,
                  value: statusChecked,
                  onChanged: (newValue) {
                    setState(() {
                      statusChecked = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const Height(20),
                ButtonWidget(
                    text: "Save Address",
                    // isLoding: isLoginLoading,
                    // backgroundColor: isValidPhone
                    // ? AppColor.primaryColor1
                    // : const Color.fromARGB(137, 23, 79, 162),
                    onPressed: () {
                      saveAddress();
                    }),
              ],
            ),
          ),
        ));
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
