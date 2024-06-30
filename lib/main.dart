import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/routes/pages.dart';
import 'core/routes/routes.dart';
import 'core/utils/constants.dart';
import 'global/bindings/initial_bindings.dart';
import 'global/presentation/themes/theme_controller.dart';

Future<void> main() async {
  await GetStorage.init();
  Get.put(ThemeController());
  runApp(const MyApp());
  configLoading();
  // Set the status bar color globally
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Change this to your desired color
    statusBarBrightness: Brightness.light, // For iOS (light/dark)
    statusBarIconBrightness: Brightness.dark, // For Android (light/dark)
  ));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 55.0
    ..contentPadding = EdgeInsets.zero
    ..radius = 10.0
    ..boxShadow = [const BoxShadow(color: Colors.transparent)]
    ..progressColor = Colors.black
    ..backgroundColor = Colors.transparent
    ..indicatorColor = primaryColor
    ..textColor = Colors.yellow
    ..maskColor = Colors.grey.withOpacity(.3)
    ..maskType = EasyLoadingMaskType.custom
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: InitialBindings(),
          getPages: Pages.pages,
          home: child,
          navigatorKey: Get.key,
          // routingCallback: (routing) {
          //   if (routing?.current == Routes.splashScreen) {}
          // },
          initialRoute: Routes.splashScreen,
          builder: EasyLoading.init(),
        );
      },
      child: Pages.splashScreen,
    );

  }
}
