// lib/bindings/initial_bindings.dart

import 'package:get/get.dart';
import '../../core/controllers/settings_controller.dart';
import '../../features/main_page/controllers/main_page_controller.dart';
import '../../features/splash_screen/controllers/splashscreen_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    //Get.put<ThemeController>(ThemeController());
    Get.put(SettingsController());
    Get.put(SplashscreenController());
    Get.put(MainPageController());
  }
}
