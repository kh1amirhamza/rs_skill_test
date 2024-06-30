import 'dart:core';

import 'package:flutter/material.dart';

import 'custom_text_tile.dart';

class CustomImageTextTile extends StatelessWidget {
  final CustomTextTile customTextTile;
  final Widget prefixImage;
  final double prefixSpace;

  const CustomImageTextTile(
      {super.key,
      required this.customTextTile,
      required this.prefixImage,
      this.prefixSpace = 15.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        prefixImage,
        SizedBox(
          width: prefixSpace,
        ),
        customTextTile
      ],
    );
  }
}
