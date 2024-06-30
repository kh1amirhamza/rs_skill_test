import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/functions.dart';

class CustomTextView extends StatefulWidget {
  //AmirHamza
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextOverflow? overflow;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final CustomTextViewStyle textViewStyle;
  final bool? softWrap;
  final TextAlign? textAlign;
  final int? maxLines;
  const CustomTextView(
      {required this.text,
      this.fontSize,
      this.fontWeight,
      this.textColor,
      this.overflow,
      this.fontFamily,
      this.fontStyle,
      this.textViewStyle = CustomTextViewStyle.medium,
      this.softWrap,
      this.textAlign,
      this.maxLines,
      super.key});

  @override
  State<CustomTextView> createState() => _CustomTextViewState();
}

class _CustomTextViewState extends State<CustomTextView> {
  @override
  Widget build(BuildContext context) {
    bool isSmall = widget.textViewStyle == CustomTextViewStyle.small;
    bool isMedium = widget.textViewStyle == CustomTextViewStyle.medium;
    bool isLarge = widget.textViewStyle == CustomTextViewStyle.large;

    // bool isTablet = isDeviceTablet(context);
    //
    // double? fontSize = isCustom
    //     ? widget.fontSize
    //     : isSmall
    //         ? (isTablet ? 18 : 12)
    //         : isMedium
    //             ? (isTablet ? 26 : 16)
    //             : isLarge
    //                 ? (isTablet ? 36 : 20)
    //                 : (isTablet ? 50 : 26);

    double? fontSize = widget.fontSize ??
        (isSmall
            ? 12
            : isMedium
                ? 16
                : isLarge
                    ? 20
                    : 26);

    Color? color =
        widget.textColor ?? (Get.isDarkMode ? Colors.white : Colors.black);

    return Text(
      widget.text,
      textAlign: widget.textAlign,
      softWrap: widget.softWrap,
      // textScaler: TextScaler.linear(isTablet ? 2.0 : 1.0),
       textScaler: TextScaler.linear( 1.0),
      maxLines: widget.maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: widget.fontWeight,
        color: color,
        overflow: widget.overflow,
        fontFamily: widget.fontFamily,
        fontStyle: widget.fontStyle,
      ),
    );
  }
}

enum CustomTextViewType { richText, normal }

enum CustomTextViewStyle { small, medium, large, extraLarge }
