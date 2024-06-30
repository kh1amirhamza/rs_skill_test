import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;

class CustomTextField extends StatefulWidget {
  //AmirHamza
  final String? label;
  final Color? labelColor;
  final double? labelTextSize;
  final FontWeight? labelFontWeight;
  final bool enableLabel;
  final Color? textColor;
  final TextAlign? textAlign;
  final String? hint;
  final double? hintTextSize;
  final Color? hintTextColor;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Gradient? gradient;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? errorMessage;
  final Key? formKey;
  final Color? underlineColor;
  final Color? fillColor;
  final Color? shadowColor;
  final bool enableUnderline;
  final bool? filled;
  //final bool? heightDisable;
  final bool isRequired;
  final int maxLength;
  final int maxLines;
  final bool? isReadOnly;
  final bool? enableBorder;
  final double? borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final TextInputAction? textInputAction;
  //final String? prefixText;
  final Widget? prefixIcon;
  //final TextStyle? prefixTextStyle;
  // final String? suffixText;
  final Widget? suffixIcon;
  //final TextStyle? suffixTextStyle;
  final double paddingBetweenIconAndContent;
  final Style style;
  final TextStyle? errorTextStyle;
  final Widget? prefixWidget;
  final Function(String text)? onTextChanged;
  final VoidCallback? onTap;

  const CustomTextField(
      {this.label,
      this.labelTextSize = 12,
      this.labelFontWeight,
      this.hintTextSize = 16,
      this.hintTextColor = Colors.grey,
      this.height,
      this.textColor,
      this.textAlign,
      this.hint,
      this.padding = const EdgeInsets.fromLTRB(10, 8, 10, 8),
      this.prefixWidget,
      this.gradient,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.errorMessage,
      this.formKey,
      this.fillColor,
      this.shadowColor,
      this.labelColor = Colors.black,
      this.filled = false,
      //this.heightDisable = true,
      this.underlineColor,
      this.borderRadius = 5.0,
      this.isReadOnly = false,
      this.enableBorder = false,
      this.borderColor = Colors.grey,
      this.borderWidth = 1.0,
      this.textInputAction,
      this.enableUnderline = true,
      this.isRequired = false,
      this.maxLength = -1,
      this.maxLines = 1,
      this.onTextChanged,
      this.onTap,
      this.enableLabel = true,
      //this.prefixText,
      this.prefixIcon,
      //this.prefixTextStyle,
      //this.suffixText,
      this.suffixIcon,
      //this.suffixTextStyle,
      this.paddingBetweenIconAndContent = 20.0,
      this.style = Style.circular,
      this.errorTextStyle = const TextStyle(fontSize: 12, color: Colors.red),
      super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passwordVisible = false;

  String errorText = '';

  @override
  Widget build(BuildContext context) {
    // if (true) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.enableLabel)
          widget.label != null
              ? Row(
                  children: [
                    Text("${widget.label}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: widget.labelColor,
                            fontSize: widget.labelTextSize ?? 12.sp,
                            fontWeight:
                                widget.labelFontWeight ?? FontWeight.normal)),
                    Text(widget.isRequired ? ' *' : '',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: widget.labelTextSize ?? 12.sp,
                            fontWeight: FontWeight.w600)),
                  ],
                )
              : const SizedBox(),
        if (widget.enableLabel) const SizedBox(height: 2),
        Container(
          decoration: widget.style == Style.regular
              ? BoxDecoration(
                  border: Border.all(
                      color: (widget.enableBorder! ||
                              widget.style == Style.regular)
                          ? widget.borderColor!
                          : Colors.transparent,
                      width: widget.borderWidth),
                  borderRadius:
                      (widget.enableBorder! || widget.style == Style.regular)
                          ? BorderRadius.circular(widget.borderRadius!)
                          : BorderRadius.zero,
                )
              : BoxDecoration(
                  borderRadius:  BorderRadius.circular((45.0/widget.maxLines)<25.0?25.0:(45.0/widget.maxLines)),
                  color: widget.fillColor ?? Colors.white,
                  gradient: widget.gradient,
                  boxShadow: [
                    BoxShadow(
                      color: widget.shadowColor ?? Colors.grey.shade300,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(1, 2),
                    ),
                    BoxShadow(
                      color: widget.shadowColor ?? Colors.grey.shade300,
                      spreadRadius: 0.5,
                      blurRadius: 0.5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
          //padding: widget.padding ?? const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: body(),
        ),
        if (errorText.isNotEmpty)
          Container(
              padding: const EdgeInsets.only(top: 7, left: 10),
              child: Text(
                errorText,
                style: widget.errorTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ))
      ],
    );

  }

  Widget textField() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Form(
              key: widget.formKey,
              child: Container(
                height:
                    widget.height, //widget.heightDisable == true ? 45.0: null,
                alignment: Alignment.center,
                padding: widget.padding,
                color: widget.fillColor,
                child: TextFormField(
                  textAlign: widget.textAlign??TextAlign.start,
                  textInputAction:
                      widget.textInputAction ?? TextInputAction.next,
                  style: TextStyle(
                      color: widget.textColor, fontSize: widget.hintTextSize),
                  onTap: widget.onTap,
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: widget.isReadOnly ?? false,
                  maxLines: widget.maxLines == 0 ? null : widget.maxLines,
                  maxLength: widget.maxLength,
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  onChanged: widget.onTextChanged ??
                      (text) {
                        setState(() {
                          if (widget.isRequired && text.isEmpty) {
                            errorText =
                                "${widget.label ?? "This field"} is required!";
                          } else {
                            errorText = '';
                          }
                          print("errorText: $text");
                        });
                      },
                  obscureText:
                      (widget.keyboardType == TextInputType.visiblePassword &&
                          !passwordVisible),
                  validator: (text) {
                    setState(() {
                      if (widget.isRequired) {
                        if (text == null || text.isEmpty) {
                          errorText =
                              "${widget.label ?? "This field"} is required!";
                        } else if (widget.keyboardType ==
                                TextInputType.emailAddress &&
                            !EmailValidator.validate(text)) {
                          errorText = "Enter valid email address";
                        } else if (widget.keyboardType ==
                                TextInputType.visiblePassword &&
                            text.length < 6) {
                          errorText = "Password length minimum 6 digit.";
                        } else {
                          errorText = '';
                        }
                      }
                    });
                    if (widget.isRequired && (text == null || text.isEmpty)) {
                      Get.snackbar("Warning!",
                          "${widget.label ?? "This field"} can't be empty!");
                    } else if (widget.isRequired && errorText.isNotEmpty) {
                      Get.snackbar("Warning!", errorText);
                    }
                    return errorText.isEmpty ? null : '';
                  },
                  decoration: InputDecoration(
                    hintText: widget.hint ??
                        (widget.label != null
                            ? "Enter ${(widget.label ?? '').toLowerCase()}"
                            : null),
                    fillColor: widget.fillColor,
                    filled: widget.filled,
                    border: InputBorder.none,
                    counterText: '',
                    hintStyle: TextStyle(
                        color: widget.hintTextColor,
                        fontSize: widget.hintTextSize,
                        fontWeight: FontWeight.w400),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    //prefixText: widget.prefixText,
                    errorStyle:
                        const TextStyle(height: 0, color: Colors.transparent),
                    prefixIcon: widget.prefixIcon == null
                        ? null
                        : Padding(
                            padding: EdgeInsets.only(
                                right: widget.paddingBetweenIconAndContent),
                            child: widget.prefixIcon,
                          ),
                    //prefixStyle: widget.prefixTextStyle,
                    prefixIconConstraints: widget.prefixIcon == null
                        ? null
                        : const BoxConstraints(
                            //maxHeight: 18,
                            minHeight: 0),
                    //suffixText: widget.suffixText,
                    suffixIcon: widget.suffixIcon == null
                        ? null
                        : Padding(
                            padding: EdgeInsets.only(
                                left: widget.paddingBetweenIconAndContent),
                            child: widget.suffixIcon,
                          ),
                    //suffixStyle: widget.suffixTextStyle,
                    // prefix:widget.prefixWidget==  null ? null : widget.prefixWidget,
                    suffixIconConstraints: widget.suffixIcon == null
                        ? null
                        : const BoxConstraints(minHeight: 0),
                  ),
                ),
              ),
            ),
          ),
          if (widget.keyboardType == TextInputType.visiblePassword)
            SizedBox(
              height: 20,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Update the state i.e. toggle the state of passwordVisible variable
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
            )
        ],
      );

  Widget body() => Column(
        children: [
          textField(),
          if ((widget.keyboardType != TextInputType.visiblePassword) &&
              (widget.style != Style.circular) &&
              widget.enableUnderline)
            const SizedBox(
              height: 0,
            ),
          if (widget.enableUnderline && (widget.style != Style.circular))
            Divider(
              color: widget.underlineColor ?? Colors.grey.shade300,
              height: 1,
            ),
        ],
      );
}

enum Style { regular, circular }
