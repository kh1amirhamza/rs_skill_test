import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs_skill_test/core/utils/constants.dart';

class CustomAnimatedSnackbar extends StatefulWidget {
  final String message;

  const CustomAnimatedSnackbar({super.key, required this.message});

  @override
  _CustomAnimatedSnackbarState createState() => _CustomAnimatedSnackbarState();
}

class _CustomAnimatedSnackbarState extends State<CustomAnimatedSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  //late Animation<Alignment> alignmenntAnimation;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 700),
    );
    // alignmenntAnimation = AlignmentTween(begin: const Alignment(-1.0, -2.0), end: const Alignment(-1.0, -1.0)).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: Curves.easeOutCirc,
    //     reverseCurve: Curves.easeOutCirc,
    //   ) );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0), // Start from the top
      end: const Offset(0, -0.87), // Move to the center// Start from the top
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        if (mounted) {
          setState(() {
            // Your state change code goes here
          });
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print("Completed");
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (!_isDisposed) {
              _controller.reverse();
            }
          });
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      // AlignTransition

      //alignment: alignmenntAnimation,
      position: _offsetAnimation,
      child: Container(
        margin: EdgeInsets.only(
          top: Get.height,
          bottom: 0,
        ),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            //blendMode: BlendMode.dstIn,
            filter: ImageFilter.blur(
              sigmaX: 9.0,
              sigmaY: 9.0,
            ),

            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 70, // Minimum height
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    maxLines: 3,
                    widget.message,
                    style: const TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
