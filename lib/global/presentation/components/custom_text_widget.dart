import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  // Jubayer
  final String? text;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? wordSpacing;
  final double? horizontal;
  final double? letterSpacing;
  final TextDirection? textDirection;
  final TextDecoration? decoration;
  TextOverflow? overflow;
  Paint? foreground;
  FontStyle? fontStyle;
  CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.maxLines,
    this.fontWeight,
    this.textAlign,
    this.textDirection,
    this.wordSpacing,
    this.horizontal=3,
    this.letterSpacing,
    this.decoration,
    this.overflow,
    this.foreground,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: horizontal??3,vertical: 1),
      child: Text('$text',
          softWrap: false,
          style: TextStyle(
            decoration: decoration,
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.normal,
            color: color ?? Colors.black,
            wordSpacing: wordSpacing,
            letterSpacing: letterSpacing,
            foreground: foreground,
            fontStyle: fontStyle,
          ),
          maxLines: maxLines,
          textAlign: textAlign,
          textDirection: textDirection,
          overflow: TextOverflow.ellipsis),
    );
  }
}