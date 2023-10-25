import 'package:clocare/screen/basket/basket_garment_screen.dart';
import 'package:clocare/screen/widget/button_widget.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer' as logDev;

class BasketPage extends StatefulWidget {
  const BasketPage({
    super.key,
  });

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  placeOrder() {
    Get.to(const BasketGarmentScreen(), transition: Transition.rightToLeft);
  }

  final basketBox = Hive.box('basketBox');

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0, right: 15, left: 15, bottom: 20),
        child: basketBox.get('BASKETLIST') == null
            ? PlaceOrder(
                onTap: () {
                  placeOrder();
                },
              )
            : const BasketData());
  }
}

class BasketData extends StatefulWidget {
  const BasketData({
    super.key,
  });

  @override
  State<BasketData> createState() => _BasketDataState();
}

class _BasketDataState extends State<BasketData> {
  bool isVisibal = false;

  final basketBox = Hive.box('basketBox');

  @override
  Widget build(BuildContext context) {
    var data = basketBox.get('BASKETLIST')[1];
    final String totalPrice = data['price'].toString();
    final String item = data['items'].toString();
    final String service = basketBox.get('BASKETLIST')[0].length.toString();

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            height: 450,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.boxColor,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: AppColor.primaryColor1, width: 1),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(children: [
                      TextBox(
                        title: 'Order Amount:',
                        value: '₹$totalPrice',
                      ),
                      const Height(8),
                      TextBox(
                        title: 'Total Clothes:',
                        value: item,
                      ),
                      const Height(8),
                      TextBox(
                        title: 'Service',
                        value: service,
                      ),
                    ]),
                  ),
                ),
                // const Height(15),
                Expanded(
                  child: ListView.builder(
                    itemCount: basketBox.get('BASKETLIST')[0].length,
                    itemBuilder: (context, serviceIndex) {
                      final service =
                          basketBox.get('BASKETLIST')[0][serviceIndex];
                      final serviceName = service['service_name'];
                      final gtypes = service['gtype'];
                      final image = service['service_icon'].toString();
                      int itm = 0;
                      for (final gtype in gtypes) {
                        var items = gtype['items'];
                        for (final item in items) {
                          itm = itm + int.parse(item['item_qty'].toString());
                        }
                      }
                      return ExpansionTile(
                        title: SmallText(
                          text: serviceName,
                          fontweights: FontWeight.w500,
                          color: AppColor.appBarColor,
                          size: 16,
                        ),
                        subtitle: SmallText(text: '${itm.toString()} items'),
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColor.backgroundColor,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: SvgPicture.network(
                              '${AppConstants.BASE_URL1}/uploads/$image',
                              // ignore: deprecated_member_use
                              color: AppColor.primaryColor1,
                            ),
                          ),
                        ),
                        children: gtypes.map<Widget>((gtype) {
                          final gtypeName = gtype['gtype_name'];
                          final items = gtype['items'];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(gtypeName),
                              subtitle: Column(
                                children: items.map<Widget>((item) {
                                  final garment = item['item_name'];
                                  final price = item['item_price'];
                                  final image = item['item_icon'];
                                  final qtn = item['item_qty'];

                                  return ListTile(
                                    title: Text(garment),
                                    leading: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            72,
                                            139,
                                            207,
                                            255), //AppColor.boxShadowColor,
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Image.network(
                                            '${AppConstants.BASE_URL1}/uploads/$image'),
                                      ),
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SmallText(text: 'Price: $price'),
                                        SmallText(
                                          text: 'Qty: $qtn',
                                          color: AppColor.primaryColor1Greey,
                                          size: 12,
                                        ),
                                        // Text('Price: $price, qtn: $qtn'),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  final String title;
  final String value;

  const TextBox({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmallText(
          text: title,
          size: 14,
          color: Colors.white,
          // fontweights: FontWeight.w400,
        ),
        SmallText(
          text: value,
          size: 14,
          color: const Color.fromARGB(234, 255, 255, 255),
          // fontweights: FontWeight.w400,
        ),
      ],
    );
  }
}

class BtnBasket extends StatelessWidget {
  final String title;
  final Color bg;
  final Color textColor;
  final Function onTap;
  const BtnBasket({
    super.key,
    required this.title,
    required this.bg,
    required this.onTap,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      height: 50,
      width: double.infinity,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            color: bg,
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
          // decoration: BoxDecoration(
          //   border: Border.all(color: AppColor.boxColor),
          //   color: bg,
          //   borderRadius: BorderRadius.circular(8),

          // ),
          child: Align(
              child: Text(
            title,
            style: TextStyle(
              color: textColor,
              // foreground: Paint()..shader,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          )),
        ),
      ),
    ));
  }
}

class PlaceOrder extends StatelessWidget {
  final Function onTap;
  const PlaceOrder({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                onTap();
              },
              child: DottedBorder(
                // borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                padding: const EdgeInsets.all(6),
                dashPattern: const [5, 3],
                color: AppColor.primaryColor1,
                strokeWidth: 1,
                child: Center(
                    child: SmallText(
                  text: 'Your Basket is Empty',
                  size: 15,
                  color: Colors.black54,
                )),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(60),
          child: SizedBox(
            height: 45,
            width: 150,
            child: InkWell(
              onTap: () {
                onTap();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border:
                        Border.all(color: AppColor.primaryColor1, width: 1)),
                child: Center(
                  child: SmallText(
                    text: 'Place Order',
                    size: 14,
                    color: AppColor.primaryColor1,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
