import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  bool? obscureTexts;
  Function(String)? onChanged;
  final Widget? suffixIcon;
  TextInputType? keyboardType;

  CustomTextField(
      {super.key,
      required this.hintText,
      required this.icon,
      this.suffixIcon,
      this.onChanged,
      required this.controller,
      this.obscureTexts = false,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      height: size.height * 0.07,
      decoration: BoxDecoration(
        // color: const Color.fromARGB(24, 23, 79, 162),
        // border: Border.all(
        //     color: const Color.fromARGB(129, 23, 79, 162), width: 1),
        // borderRadius: const BorderRadius.all(Radius.circular(15)),

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
      child: Center(
        child: TextField(
          keyboardType: keyboardType,
          obscureText: obscureTexts!,
          onChanged: (String) {
            onChanged!(String);
          },
          controller: controller,
          style: const TextStyle(color: Colors.black),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              // errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              // contentPadding: EdgeInsets.only(
              //   top: size.height * 0.028,
              // ),
              hintText: hintText,
              prefixIcon: Icon(
                icon,
                color: Colors.grey,
              ),
              suffixIcon: suffixIcon),
        ),
      ),
    );
    ;
  }
}

class CustomTextField1 extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  bool? obscureTexts;
  Function(String)? onChanged;
  final Widget? suffixIcon;
  TextInputType? keyboardType;

  CustomTextField1(
      {super.key,
      required this.hintText,
      required this.icon,
      this.suffixIcon,
      this.onChanged,
      required this.controller,
      this.obscureTexts = false,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      height: size.height * 0.06,
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
      child: Center(
        child: TextField(
          keyboardType: keyboardType,
          obscureText: obscureTexts!,
          onChanged: (String) {
            onChanged!(String);
          },
          controller: controller,
          style: const TextStyle(color: Colors.black),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              // errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
              border: InputBorder.none,
              // contentPadding: EdgeInsets.only(
              //   top: size.height * 0.028,
              // ),
              hintText: hintText,
              prefixIcon: Icon(
                icon,
                color: AppColor.primaryColor1,
                size: 15,
              ),
              suffixIcon: suffixIcon),
        ),
      ),
    );
    ;
  }
}

class CustomTextFieldForm extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final IconData icon;
  final Widget? suffixIcon;
  final Widget? widget;
  final TextInputType? keyboardType;

  const CustomTextFieldForm(
      {super.key,
      required this.hintText,
      required this.icon,
      this.suffixIcon,
      this.controller,
      this.widget,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.025),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.06,
        decoration: const BoxDecoration(
          color: Color(0xffF7F8F8),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: keyboardType,
                readOnly: widget == null ? false : true,
                autofocus: false,
                controller: controller,
                style: const TextStyle(color: Colors.black),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(

                    // errorStyle: const TextStyle(height: 0),
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xffADA4A5),
                    ),
                    border: InputBorder.none,
                    // contentPadding: EdgeInsets.only(
                    //   top: size.height * 0.028,
                    // ),
                    hintText: hintText,
                    prefixIcon: Icon(
                      icon,
                      color: const Color(0xff7B6F72),
                      size: 19,
                    ),
                    suffixIcon: suffixIcon),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: widget == null
                  ? Container()
                  : Expanded(
                      child: Container(
                        child: widget,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
