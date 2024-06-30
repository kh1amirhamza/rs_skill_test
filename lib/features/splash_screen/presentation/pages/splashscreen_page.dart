import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rs_skill_test/core/utils/constants.dart';

import '../../../../core/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  GetStorage box  = GetStorage();

  @override
  void initState() {
    super.initState();
    box ??= GetStorage();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    // Navigate to the home page after the animation is complete
    Future.delayed(const Duration(seconds: 3), () {
      // Get.toNamed(Routes.mainPage); // Replace with your home page
      if(box.read(logInRes)!=null || box.read(signUpRes)!=null){
        Get.offNamedUntil(Routes.mainPage, (route) => false);
      }else{
        Get.offNamedUntil(Routes.signIn, (route) => false);
      }
      // Replace with your home page
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: _animation.value *
                (MediaQuery.of(context).size.height / 2 - 50),
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Transform.scale(
              scale: _animation.value * 2.5,
              child: Image.asset(
                'assets/images/retinasoft.png',
                height: 100,
                width: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
