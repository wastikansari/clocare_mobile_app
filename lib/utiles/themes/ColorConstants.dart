import 'package:flutter/material.dart';

class ColorConstants {
  static Color gray50 = hexToColor('#e9e9e9');
  static Color gray100 = hexToColor('#bdbebe');
  static Color gray200 = hexToColor('#929293');
  static Color gray300 = hexToColor('#666667');
  static Color gray400 = hexToColor('#505151');
  static Color gray500 = hexToColor('#242526');
  static Color gray600 = hexToColor('#202122');
  static Color gray700 = hexToColor('#191a1b');
  static Color gray800 = hexToColor('#121313');
  static Color gray900 = hexToColor('#0e0f0f');
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(int.parse(hex.substring(1), radix: 16) +
      (hex.length == 7 ? 0xFF000000 : 0x00000000));
}

class AppColor {
  static Color appBarColor = Color(0xFF292c31);
  static Color primaryColor1 = Color(0xFF174FA2);
  static Color primaryButtonColor = Color.fromARGB(229, 51, 106, 188);
  static Color primaryColor2 = Color(0xFF57B1E3);
  static Color textFromColor = Color(0xffF7F8F8);
  static Color primaryColor1Greey = Color.fromARGB(255, 56, 105, 180);
  static Color primaryColorDark = Color.fromARGB(105, 23, 79, 162);
  static Color primaryColor2Dark = Color.fromARGB(141, 87, 178, 227);
  static Color backgroundColor = Color(0xFFEFF1FE);
  static Color boxColor = Color(0xFFF9F8FF);

  static Color boxShadowColor = Color.fromARGB(43, 197, 197, 197);
}
