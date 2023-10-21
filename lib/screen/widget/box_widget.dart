import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final Widget child;
  const CustomBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: child);
  }
}
