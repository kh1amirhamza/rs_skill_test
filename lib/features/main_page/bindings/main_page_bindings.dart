import 'package:get/get.dart';
import 'package:rs_skill_test/features/branch/controllers/branch_controller.dart';

import 'package:rs_skill_test/features/profile/controllers/profile_controller.dart';
import 'package:rs_skill_test/features/transaction/controllers/transaction_controller.dart';

import '../../customer_suplier/controllers/customer_supplier_controller.dart';

class MainPageBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => BranchController(), fenix: true);
    Get.lazyPut(() => CustomerSupplierController(), fenix: true);
    Get.lazyPut(() => TransactionController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
