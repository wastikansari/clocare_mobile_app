import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function(Object?)? onChanged;
  final List<DropdownMenuItem<Object>> items;
  final Color hintColor;

  const CustomDropDown({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.items,
    required this.onChanged,
    required this.hintColor,
  }) : super(key: key);

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 12),
            child: Icon(
              icon,
              color: AppColor.primaryColor1,
              size: 19,
            ),
          ),
          Expanded(
            child: DropdownButton(
              padding: const EdgeInsets.all(9),
              isExpanded: true,
              hint: SmallText(
                text: hintText,
                size: 14,
                color: hintColor,
                fontweights: FontWeight.w400,
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 19,
              elevation: 4,
              underline: Container(
                height: 0,
              ),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFormDropDown extends StatelessWidget {
  final String hintText;
  final Function(Map<String, dynamic>?)? onChanged;
  final List<DropdownMenuItem<Map<String, dynamic>>>? items;
  final Color hintColor;
  final String title;

  const CustomFormDropDown(
      {super.key,
      required this.hintText,
      required this.title,
      required this.onChanged,
      required this.items,
      required this.hintColor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.015),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SmallText(
                text: title,
                fontweights: FontWeight.w500,
                size: 14,
              ),
              SmallText(
                text: '*',
                fontweights: FontWeight.w500,
                color: Colors.red,
                size: 14,
              ),
            ],
          ),
          const Height(8),
          Container(
            // width: size.width * 0.9,
            height: size.height * 0.07,
            decoration: BoxDecoration(
              color: AppColor.textFromColor,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: DropdownButton<Map<String, dynamic>>(
              padding: const EdgeInsets.all(9),
              isExpanded: true,
              hint: SmallText(
                text: hintText,
                size: 14,
                color: hintColor,
                fontweights: FontWeight.w400,
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 19,
              elevation: 4,
              underline: Container(
                height: 0,
              ),
              items: items,
              onChanged: onChanged,
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Padding(
            //         padding: const EdgeInsets.only(left: 12, right: 15),
            //         child: TextField(
            //           keyboardType: keyboardType,
            //           readOnly: widget == null ? false : true,
            //           autofocus: false,
            //           controller: controller,
            //           style: const TextStyle(color: Colors.black),
            //           textInputAction: TextInputAction.next,
            //           decoration: InputDecoration(
            //               // errorStyle: const TextStyle(height: 0),
            //               hintStyle: const TextStyle(
            //                 fontSize: 14,
            //                 color: Color(0xffADA4A5),
            //               ),
            //               border: InputBorder.none,
            //               // contentPadding: EdgeInsets.only(
            //               //   top: size.height * 0.028,
            //               // ),
            //               hintText: hintText,
            //               suffixIcon: suffixIcon),
            //         ),
            //       ),
            //     ),
            //     widget == null
            //         ? Container()
            //         : Container(
            //             child: widget,
            //           )
            //   ],
            // ),
          ),
        ],
      ),
    );
  }
}
