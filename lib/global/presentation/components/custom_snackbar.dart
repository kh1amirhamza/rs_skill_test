
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_text_widget.dart';



CustomSnackBar(
    String? message, {
      Color? textColor,
      Color? bgColor,
      Widget? child,
    }) {
  ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(
    SnackBar(
      backgroundColor: bgColor ?? Colors.blue,
      duration: const Duration(milliseconds: 800),
      elevation: 50,
      content: child ??
          CustomText(
            text: message.toString(),
            color: textColor ?? Colors.white,
          ),
    ),
  );
}