import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SignInController());
  }
}
