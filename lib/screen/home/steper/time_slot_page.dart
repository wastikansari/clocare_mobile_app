import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class TimeSlotPage extends StatefulWidget {
  final Function(Map) callback;

  const TimeSlotPage({super.key, required this.callback});

  @override
  State<TimeSlotPage> createState() => _TimeSlotPageState();
}

class _TimeSlotPageState extends State<TimeSlotPage> {
  List<DateTime> pickupDate = [];
  List<DateTime> deliverDate = [];
  String currentMonthe = '';
  int isSelectPickupDate = 0;
  int isSelectTimePickupSlot = 1;
  int isSelectDeliverDate = 1;

  String selectPickupDate = '';
  String selectPickupTime = '9:00 AM - 2:00 PM';
  String selectDeliverDate = '';
  String selectDeliverTime = '';

  @override
  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    for (int i = 0; i < 5; i++) {
      pickupDate.add(currentDate.add(Duration(days: i)));
    }
    for (int i = 0; i < 5; i++) {
      deliverDate.add(currentDate.add(Duration(days: i)));
    }
    sendDataToParent();
  }

  void sendDataToParent() {
    setState(() {
      Map<String, String> data = {
        "pickup_date":
            DateFormat('dd-MMM-yyyy').format(pickupDate[isSelectPickupDate]),
        "pickup_time": selectPickupTime,
        "Delivery_date":
            DateFormat('dd-MMM-yyyy').format(deliverDate[isSelectDeliverDate]),
        "Delivery_time": selectPickupTime,
      };
      widget.callback(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textSlot(
              currentMonthe: currentMonthe,
              title: 'Pickup slot',
            ),
            const Height(15),
            Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.boxColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 1),
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
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: pickupDate.length,
                          itemBuilder: (context, index) {
                            final date = pickupDate[index];
                            final weekDay = DateFormat('EE').format(date);
                            final formattedDate = DateFormat('dd').format(date);
                            currentMonthe =
                                DateFormat('MMMM yyyy').format(date);
                            final fullDate =
                                DateFormat('dd-MMM-yyyy').format(date);
                            selectPickupDate = fullDate;
                            return InkWell(
                              onTap: () {
                                deliverDate.clear();
                                for (int i = 0; i < 5; i++) {
                                  deliverDate.add(date.add(Duration(days: i)));
                                }
                                setState(() {
                                  selectPickupDate = '';
                                  isSelectPickupDate = index;
                                  selectPickupDate = fullDate;
                                });
                                sendDataToParent();
                                print('pickup date $selectPickupDate');
                              },
                              child: Container(
                                margin: const EdgeInsets.all(6),
                                height: 40,
                                width: 43,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    color: isSelectPickupDate == index
                                        ? AppColor.primaryColor1
                                        : Colors.transparent,
                                    // color: AppColor.primaryColor1,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SmallText(
                                      text: formattedDate,
                                      size: 11,
                                      fontweights: FontWeight.w500,
                                      color: isSelectPickupDate == index
                                          ? Colors.white
                                          : AppColor.appBarColor,
                                    ),
                                    const Height(3),
                                    SmallText(
                                      text: weekDay,
                                      size: 11,
                                      color: isSelectPickupDate == index
                                          ? Colors.white
                                          : AppColor.appBarColor,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Height(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          timeSlot(
                            icon: Icons.wb_sunny_outlined,
                            timeslot: '9:00 AM - 2:00 PM',
                            bgColor: isSelectTimePickupSlot == 1
                                ? const Color.fromARGB(80, 255, 193, 7)
                                : const Color.fromARGB(106, 239, 241, 254),
                            onTap: () {
                              setState(() {
                                isSelectTimePickupSlot = 1;
                                selectPickupTime = "9:00 AM - 2:00 PM";
                              });
                              sendDataToParent();
                            },
                          ),
                          timeSlot(
                            icon: Icons.nightlight_outlined,
                            timeslot: '4:00 PM - 9:00 PM',
                            bgColor: isSelectTimePickupSlot == 2
                                ? const Color.fromARGB(80, 255, 193, 7)
                                : const Color.fromARGB(106, 239, 241, 254),
                            onTap: () {
                              setState(() {
                                isSelectTimePickupSlot = 2;
                                selectPickupTime = "4:00 PM - 9:00 PM";
                              });
                              sendDataToParent();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            const Height(25),
            textSlot(
              currentMonthe: currentMonthe,
              title: 'Delivery slot',
            ),
            const Height(15),
            Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.boxColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 1),
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
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // shrinkWrap: true,
                          itemCount: deliverDate.length,
                          itemBuilder: (context, index) {
                            final date = deliverDate[index];
                            final weekDay = DateFormat('EE')
                                .format(date); // Get week day name
                            final formattedDate = DateFormat('dd').format(date);
                            currentMonthe =
                                DateFormat('MMMM yyyy').format(date);
                            final fullDate =
                                DateFormat('dd-MMM-yyyy').format(date);
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  isSelectDeliverDate = index;
                                });
                                sendDataToParent();
                                print('ddddddddddd deli $isSelectDeliverDate');
                              },
                              child: Container(
                                margin: const EdgeInsets.all(6),
                                height: 40,
                                width: 43,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    color: isSelectDeliverDate == index
                                        ? AppColor.primaryColor1
                                        : Colors.transparent,
                                    // color: AppColor.primaryColor1,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SmallText(
                                      text: formattedDate,
                                      size: 11,
                                      fontweights: FontWeight.w500,
                                      color: isSelectDeliverDate == index
                                          ? Colors.white
                                          : AppColor.appBarColor,
                                    ),
                                    const Height(3),
                                    SmallText(
                                      text: weekDay,
                                      size: 11,
                                      color: isSelectDeliverDate == index
                                          ? Colors.white
                                          : AppColor.appBarColor,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Height(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          timeSlot(
                            icon: Icons.wb_sunny_outlined,
                            timeslot: '9:00 AM - 2:00 PM',
                            bgColor: isSelectTimePickupSlot == 1
                                ? const Color.fromARGB(80, 255, 193, 7)
                                : const Color.fromARGB(106, 239, 241, 254),
                            onTap: () {
                              setState(() {
                                isSelectTimePickupSlot = 1;
                                selectPickupTime = "9:00 AM - 2:00 PM";
                              });
                              sendDataToParent();
                            },
                          ),
                          timeSlot(
                            icon: Icons.nightlight_outlined,
                            timeslot: '4:00 PM - 9:00 PM',
                            bgColor: isSelectTimePickupSlot == 2
                                ? const Color.fromARGB(80, 255, 193, 7)
                                : const Color.fromARGB(106, 239, 241, 254),
                            onTap: () {
                              setState(() {
                                isSelectTimePickupSlot = 2;
                                selectPickupTime = "4:00 PM - 9:00 PM";
                              });
                              sendDataToParent();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ]),
    );
  }
}

class timeSlot extends StatelessWidget {
  final IconData icon;
  final String timeslot;
  final Color bgColor;
  final Function onTap;
  const timeSlot({
    super.key,
    required this.icon,
    required this.timeslot,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        // height: 40,
        // width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: bgColor,
            border: Border.all(color: const Color.fromARGB(39, 68, 137, 255))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFe7e7ff),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      icon,
                      size: 9,
                    ),
                  )),
              const Widths(5),
              SmallText(
                text: timeslot,
                size: 11,
                color: bgColor ==  AppColor.primaryColor1Greey ? AppColor.boxColor : AppColor.appBarColor,
                fontweights: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class textSlot extends StatelessWidget {
  final String title;
  const textSlot({
    super.key,
    required this.currentMonthe,
    required this.title,
  });

  final String currentMonthe;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const Widths(8),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallText(
              text: title,
              size: 18,
              fontweights: FontWeight.w500,
              color: AppColor.appBarColor,
            ),
            const Height(3),
            SmallText(
              text: currentMonthe,
              size: 10,
              color: AppColor.appBarColor,
            ),
          ],
        ),
      ],
    );
  }
}
