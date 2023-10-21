import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool readOnlys;
  final Widget? suffix;
  final String hintTexts;
  final Function? onTaps;
  final Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.readOnlys,
    required this.controller,
    this.suffix,
    required this.hintTexts,
    this.onTaps,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTap: () {
          onTaps!();
        },
        keyboardType: keyboardType,
        readOnly: readOnlys,
        controller: controller,
        style: const TextStyle(
          fontSize: 13,
        ),
        validator: (value) => validator!(value),
        decoration: InputDecoration(
          hintText: hintTexts,
          //  prefixIconConstraints:BoxConstraints(minWidth: 23, minHeight:65,),
          contentPadding: const EdgeInsets.all(14),
          hintStyle: const TextStyle(fontSize: 10.0),
          isDense: true,
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 12),
          // prefixIcon: Icon(
          //   Icons.person,
          // ),
          suffix: suffix,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.redAccent,
                width: 3,
              )),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              )),
        ));
  }
}
