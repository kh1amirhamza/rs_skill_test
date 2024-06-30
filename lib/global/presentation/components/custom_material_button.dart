import 'package:flutter/material.dart';

import 'custom_text_widget.dart';

class CustomMaterialButton extends StatelessWidget {
  //AmirHamza
  final Color backgroundColor;
  final Function() onPressed;
  final String title;
  final MainAxisAlignment alignment;
  final double fontSize;
  final Color textColor;
  final double? height;
  final double width;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? borderColor;
  final FontWeight fontWeight;
  final Gradient? containerGradient;
  final double borderWidth;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final double spaceBetweenIconAndText;
  const CustomMaterialButton({
    super.key,
    this.backgroundColor = Colors.blue,

    /// todo Primary Color
    required this.onPressed,
    required this.title,
    this.alignment = MainAxisAlignment.spaceEvenly,
    this.fontSize = 14.0,
    this.textColor = Colors.white,
    this.height,
    this.width = double.maxFinite,
    this.padding = const EdgeInsets.fromLTRB(10, 8, 10, 8),
    this.borderRadius = 10.0,
    this.fontWeight = FontWeight.normal,
    this.containerGradient,
    this.borderWidth = 1.0,
    this.borderColor = Colors.white,
    this.prefixWidget,
    this.suffixWidget,
    this.spaceBetweenIconAndText = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: containerGradient,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: TextButton(
        
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStatePropertyAll(backgroundColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? Colors.white, // your color here
                width: borderWidth,
              ),
              borderRadius: BorderRadius.circular(borderRadius))),
        ),
        onPressed: () {
          onPressed();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: alignment,
          children: [
            if (prefixWidget != null) prefixWidget!,
            Padding(
              padding: padding,
              child: Text(title,
                  style: TextStyle(
                      fontSize: fontSize,
                      color: textColor,
                      fontWeight: fontWeight)),
            ),
            if (suffixWidget != null) suffixWidget!,
          ],
        ),
      ),
    );
  }
}

