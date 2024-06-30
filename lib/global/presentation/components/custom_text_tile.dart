import 'package:flutter/material.dart';

class CustomTextTile extends StatelessWidget {
  final String? title;
  final String? description;
  final double titleTextSize;
  final double descriptionTextSize;
  final Color titleTextColor;
  final Color descriptionTextColor;
  final FontWeight titleFontWeight;
  final FontWeight descriptionFontWeight;
  final double spaceBetween;
  final Axis axis;
  final Widget? titleWidget;
  final Widget? descriptionWidget;
  const CustomTextTile({
    super.key,
    this.title,
    this.description,
    this.titleTextSize = 16.0,
    this.descriptionTextSize = 14.0,
    this.titleTextColor = Colors.grey,
    this.descriptionTextColor = Colors.black,
    this.titleFontWeight = FontWeight.bold,
    this.descriptionFontWeight = FontWeight.normal,
    this.spaceBetween = 5,
    this.axis = Axis.vertical,
    this.titleWidget,
    this.descriptionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return axis == Axis.vertical
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: body(axis),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: body(axis),
          );
  }

  List<Widget> body(Axis axis) => [
        titleWidget != null
            ? titleWidget!
            : Text(
                textAlign: TextAlign.start,
                title!,
                style: TextStyle(
                    fontSize: titleTextSize,
                    fontWeight: titleFontWeight,
                    color: titleTextColor),
              ),
        if (description != null && description!.isNotEmpty)
          SizedBox(
            height: axis == Axis.vertical ? spaceBetween : 0,
            width: axis == Axis.horizontal ? spaceBetween : 0,
          ),
        descriptionWidget != null
            ? descriptionWidget!
            : (description != null && description!.isNotEmpty)
                ? Text(
                    textAlign: TextAlign.start,
                    description!,
                    style: TextStyle(
                        fontSize: descriptionTextSize,
                        fontWeight: descriptionFontWeight,
                        color: descriptionTextColor),
                  )
                : const SizedBox(),
      ];
}
