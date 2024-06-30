import 'package:get/get.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => SplashscreenController());
  }
}
