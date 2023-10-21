import 'package:clocare/screen/home/steper/time_slot_page.dart';
import 'package:clocare/screen/widget/box_widget.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';

class PickupSlot extends StatefulWidget {
  final Function(Map) callback;
  PickupSlot({super.key, required this.callback});

  @override
  State<PickupSlot> createState() => _PickupSlotState();
}

class _PickupSlotState extends State<PickupSlot> {
  List<String> day = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    // 'Sunday'
  ];

  var selectedOption;

  var isSelectTimePickupSlot = 0;
  var selectPickupTime = '';
  var selectDeliveryIndex = 0;
  var selectDeliveryValue = '';

  String selectedOptions = 'No option selected';

  void dataSend() {
    setState(() {
      Map<String, String> data = {
        "pickup_day": selectedOptions,
        'pickup_time': selectPickupTime,
        'delivery': selectDeliveryValue,
      };

      widget.callback(data);
    });
  }

  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // const Height(10),
            PickupBox(
              value: selectedOptions,
              onTap: () {
                _showBottomSheet(
                  context,
                );
              },
            ),
            const Height(20),
            Container(
                // height: 150,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallText(
                                  text: 'Select Pickup Slot',
                                  size: 15,
                                  fontweights: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                const Height(5),
                              ],
                            ),
                          ),
                          const Height(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              timeSlot(
                                icon: Icons.wb_sunny_outlined,
                                timeslot: '9:00 AM - 2:00 PM',
                                bgColor: isSelectTimePickupSlot == 1
                                    ? AppColor
                                        .primaryColor1Greey // const Color.fromARGB(80, 255, 193, 7)
                                    : const Color.fromARGB(106, 239, 241, 254),
                                onTap: () {
                                  setState(() {
                                    isSelectTimePickupSlot = 1;
                                    selectPickupTime = "9:00 AM - 2:00 PM";
                                  });
                                  dataSend();
                                },
                              ),
                              timeSlot(
                                icon: Icons.nightlight_outlined,
                                timeslot: '4:00 PM - 9:00 PM',
                                bgColor: isSelectTimePickupSlot == 2
                                    ? AppColor.primaryColor1Greey
                                    : const Color.fromARGB(106, 239, 241, 254),
                                onTap: () {
                                  setState(() {
                                    isSelectTimePickupSlot = 2;
                                    selectPickupTime = "4:00 PM - 9:00 PM";
                                  });
                                  dataSend();
                                },
                              ),
                            ],
                          ),
                        ]))),
            const Height(20),
            Container(
                // height: 150,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallText(
                                  text: 'Schedule delivery',
                                  size: 15,
                                  fontweights: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                const Height(5),
                                SmallText(
                                  text: 'Select suitable delivery option',
                                  size: 10,
                                  // fontweights: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 117, 117, 117),
                                ),
                              ],
                            ),
                          ),
                          const Height(20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              BoxWidget(
                                title: 'Delivery with next pickup',
                                icon: Icons.time_to_leave,
                                onTap: () {
                                  setState(() {
                                    selectDeliveryIndex = 1;
                                    selectDeliveryValue =
                                        "Delivery with next pickup";
                                  });
                                  dataSend();
                                },
                                textColor: selectDeliveryIndex == 1
                                    ? AppColor.backgroundColor
                                    : AppColor.appBarColor,
                                bg: selectDeliveryIndex == 1
                                    ? AppColor.primaryColor1Greey
                                    : const Color.fromARGB(106, 239, 241, 254),
                              ),
                              const Height(15),
                              BoxWidget(
                                title: '48 hour delivery',
                                icon: Icons.timer_sharp,
                                onTap: () {
                                  setState(() {
                                    selectDeliveryIndex = 2;
                                    selectDeliveryValue = "48 hour delivery";
                                  });
                                  dataSend();
                                },
                                textColor: selectDeliveryIndex == 2
                                    ? AppColor.backgroundColor
                                    : AppColor.appBarColor,
                                bg: selectDeliveryIndex == 2
                                    ? AppColor.primaryColor1Greey
                                    : const Color.fromARGB(106, 239, 241, 254),
                              ),
                            ],
                          ),
                        ]))),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      // backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10))),
          child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallText(
                    text: 'Select Pickup Day',
                    size: 15,
                    fontweights: FontWeight.w500,
                    color: Colors.black,
                  ),
                  const Height(15),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: day.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.white, width: 1),
                            color: selectedOption == index
                                ? AppColor.primaryColor1
                                : AppColor.boxColor,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.boxShadowColor,
                                blurRadius: 4.0,
                                spreadRadius: 2.0,
                                offset: const Offset(0.0, 0.0),
                              )
                            ],
                          ),
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -2),
                            title: SmallText(
                              text: day[index],
                              color: selectedOption == index
                                  ? Colors.white
                                  : const Color.fromARGB(255, 117, 117, 117),
                              size: 14,
                            ),
                            leading: Radio(
                              value: index,
                              activeColor: AppColor.backgroundColor,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value;
                                  selectedOptions = day[selectedOption];
                                });
                                dataSend();
                                Navigator.pop(context);
                                // dataSend();
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )),
        );
      },
    );
  }
}

class PickupBox extends StatefulWidget {
  final String value;
  final Function onTap;

  PickupBox({
    super.key,
    required this.value,
    required this.onTap,
  });

  @override
  State<PickupBox> createState() => _PickupBoxState();
}

class _PickupBoxState extends State<PickupBox> {
  @override
  Widget build(BuildContext context) {
    return CustomBox(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallText(
                    text: 'Select Pickup Day',
                    size: 15,
                    fontweights: FontWeight.w500,
                    color: Colors.black,
                  ),
                  const Height(5),
                  SmallText(
                    text: 'upto 1 day',
                    size: 12,
                    // fontweights: FontWeight.bold,
                    color: const Color.fromARGB(255, 117, 117, 117),
                  ),
                  const Height(20),
                  InkWell(
                    onTap: () {
                      widget.onTap();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(106, 239, 241, 254),
                          border: Border.all(
                              color: const Color.fromARGB(39, 68, 137, 255))),
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: Row(
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
                                      padding: EdgeInsets.all(6),
                                      child: Icon(
                                        Icons.watch_later_outlined,
                                        size: 11,
                                      ),
                                    )),
                                const Widths(12),
                                SmallText(
                                  text: widget.value,
                                  size: 13,
                                  color: widget.value == 'Selecte'
                                      ? const Color.fromARGB(255, 117, 117, 117)
                                      : AppColor.appBarColor,
                                  // fontweights: FontWeight.w500,
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              // size: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ])));
  }
}

class BoxWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bg;
  final Color textColor;
  final Function onTap;
  const BoxWidget(
      {super.key,
      required this.onTap,
      required this.title,
      required this.textColor,
      required this.icon,
      required this.bg});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: bg,
            border: Border.all(color: const Color.fromARGB(39, 68, 137, 255))),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
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
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          icon,
                          size: 11,
                        ),
                      )),
                  const Widths(12),
                  SmallText(text: title, size: 13, color: textColor
                      // fontweights: FontWeight.w500,
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
