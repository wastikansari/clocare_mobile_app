import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpBox extends StatelessWidget {
  final TextEditingController controller;
  Function(String)? onChanged;
  OtpBox({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
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
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(color: AppColor.primaryColor1),
        decoration: const InputDecoration(
          hintText: '-',
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          border: InputBorder.none,
        ),
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          } else {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
