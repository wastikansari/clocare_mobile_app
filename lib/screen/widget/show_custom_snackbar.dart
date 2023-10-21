import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,
    {bool isError = true, String title = 'Error'}) {
  Get.snackbar(title, message,
      titleText: SmallText(
        text: title,
        color: Colors.black87,
        fontweights: FontWeight.bold,
        size: 16,
      ),
      messageText: SmallText(
        text: message,
        color: Colors.black87,
        fontweights: FontWeight.w500,
      ),
      colorText: Colors.black,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColor.backgroundColor);
}
