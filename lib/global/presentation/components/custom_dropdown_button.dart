import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomDropDownButton extends StatefulWidget {

  final String? label;
  final bool enableLabel;
  final Color labelColor;
  final double? labelTextSize;
  final FontWeight labelFontWeight;
  final bool isRequired;
  final GlobalKey<FormState>? formKey;
  final int? initialSelectedValue;
  final List<DropdownMenuItem<int>> dropDownMenuItems;
  final DropDownStyle style;
  final bool enableBorder;
  final Color fillColor;
  final Color? shadowColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Gradient? gradient;
//  final String errorText;
  final TextStyle errorTextStyle;
  final Function(int?) onChange;
  const CustomDropDownButton({
    super.key,
     this.label,
    this.enableLabel = true,
    this.labelColor = Colors.black,
    this.labelTextSize,
    this.labelFontWeight = FontWeight.normal,
    required this.isRequired,
    this.formKey,
    required this.initialSelectedValue,
    required this.dropDownMenuItems,
    this.style = DropDownStyle.circular,
    this.enableBorder = false,
    this.fillColor = Colors.white,
    this.shadowColor,
    this.borderColor = Colors.grey,
    this.borderWidth = 1.0,
    this.borderRadius = 5.0,
    this.gradient,
   // this.errorText = '',
    this.errorTextStyle = const TextStyle(fontSize: 12, color: Colors.red),
    required this.onChange
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {

  String errorText = '';


  @override
  Widget build(BuildContext context) {

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
                      fontWeight: widget.labelFontWeight )),
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
          decoration: widget.style == DropDownStyle.regular
              ? BoxDecoration(
            border: Border.all(
                color: (widget.enableBorder ||
                    widget.style == DropDownStyle.regular)
                    ? widget.borderColor
                    : Colors.transparent,
                width: widget.borderWidth),
            borderRadius:
            (widget.enableBorder || widget.style == DropDownStyle.regular)
                ? BorderRadius.circular(widget.borderRadius)
                : BorderRadius.zero,
          )
              : BoxDecoration(
            borderRadius: BorderRadius.circular(45.0),
            color: widget.fillColor,
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
       //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child:

          // Form(
          //     key: widget.formKey!,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         DropdownButtonFormField(
          //             decoration: InputDecoration(
          //               enabledBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(color: Colors.blue, width: 2),
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //               border: OutlineInputBorder(
          //                 borderSide: BorderSide(color: Colors.blue, width: 2),
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //               filled: true,
          //               fillColor: Colors.blueAccent,
          //             ),
          //             validator: (value) => value == null ? "Select a country" : null,
          //             dropdownColor: Colors.blueAccent,
          //             value: widget.initialSelectedValue,
          //             onChanged: (int? newValue) {
          //               setState(() {
          //                 //widget.initialSelectedValue = newValue!;
          //               });
          //             },
          //             items: widget.dropDownMenuItems,),
          //         ElevatedButton(
          //             onPressed: () {
          //               if (widget.formKey!.currentState!.validate()) {
          //                 //valid flow
          //               }
          //             },
          //             child: Text("Submit"))
          //       ],
          //     )),


          Form(
            key: widget.formKey,
            child: DropdownButtonFormField<int>(
              hint: Text("Select ${widget.label??"Item"}"),
              //underline: const SizedBox(),
              isDense: true,
              isExpanded: true,
              elevation: 5,
              menuMaxHeight: 200,
              borderRadius: BorderRadius.circular(15),
              value: widget.initialSelectedValue,
              items: widget.dropDownMenuItems,
              onChanged: (newValue) async {
                setState(() {
                errorText= '';
              });
                widget.onChange(newValue);
              },
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                isDense: true,
                border: InputBorder.none,
                errorStyle:
                TextStyle(height: 0, color: Colors.transparent),
              ),

              validator: (text){
                setState(() {
                  if (widget.isRequired) {
                    if (text == null) {
                      errorText = "${widget.label ?? "This field"} is required!";
                    } else {
                      errorText = '';
                    }
                  }
                });
                if (widget.isRequired && (text == null)) {
                  Get.snackbar("Warning!",
                      "${widget.label ?? "This field"} must be selected!");
                } else if (widget.isRequired && errorText.isNotEmpty) {
                  Get.snackbar("Warning!", errorText);
                }
                return errorText.isEmpty ? null : '';
              },
            ),
          ),
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
}
enum DropDownStyle { regular, circular }
