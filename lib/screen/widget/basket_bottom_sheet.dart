import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class BasketBottomSheet extends StatelessWidget {
  final String totalItems;
  final String totalPrice;
  final Function btnTap;

  const BasketBottomSheet(
      {super.key,
      required this.totalItems,
      required this.totalPrice,
      required this.btnTap});

  @override
  Widget build(BuildContext context) {
    return true
        ? Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 244, 244, 244),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    1.0,
                    1.0,
                  ),
                ),
              ],
              border:
                  Border.all(color: const Color.fromARGB(255, 221, 221, 221)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      badges.Badge(
                          badgeContent: Text(
                            totalItems,
                            style: const TextStyle(color: Colors.white),
                          ),
                          badgeStyle: const badges.BadgeStyle(
                            padding: EdgeInsets.all(7),
                            badgeColor: Colors.redAccent,
                          ),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 28,
                          )),
                      const SizedBox(
                        width: 25,
                      ),
                      SmallText(
                        text: '₹$totalPrice',
                        size: 18,
                        color: Colors.green[700],
                        fontweights: FontWeight.w500,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      btnTap();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor1,
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: SmallText(
                          text: '   Add basket   ',
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                // color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: AppColor.boxShadowColor,
                      blurRadius: 0.9,
                      spreadRadius: 0.5),
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  badges.Badge(
                      badgeContent: Text(
                        totalItems,
                        style: const TextStyle(color: Colors.white),
                      ),
                      badgeStyle: const badges.BadgeStyle(
                        padding: EdgeInsets.all(7),
                        badgeColor: Colors.redAccent,
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 28,
                        color: AppColor.backgroundColor,
                      )),
                  SmallText(
                    text: '\₹$totalPrice',
                    size: 18,
                    color: Colors.white,
                    fontweights: FontWeight.w500,
                  ),
                  InkWell(
                    onTap: () {
                      btnTap();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.backgroundColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18, right: 18, bottom: 10, top: 10),
                        child: Center(
                          child: SmallText(
                            text: 'Basket Save',
                            size: 15,
                            color: AppColor.primaryColor1,
                            fontweights: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
