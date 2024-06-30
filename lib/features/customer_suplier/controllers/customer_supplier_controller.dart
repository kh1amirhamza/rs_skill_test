import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:image_picker/image_picker.dart';
import 'package:rs_skill_test/features/customer_suplier/data/models/customer_supplier_res_model.dart';
import 'package:rs_skill_test/features/customer_suplier/data/repositories/customer_supplier_repo.dart';
import 'package:rs_skill_test/global/services/functions.dart';
import '../../../core/utils/constants.dart';
import '../../../global/presentation/components/custom_animated_snackbar.dart';
import '../../branch/controllers/branch_controller.dart';

class CustomerSupplierController extends GetxController {
  CustomerSupplierResModel? customerSupplierResModel;

  final name2Controller = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final areaController = TextEditingController();
  final postCodeController = TextEditingController();
  final cityController = TextEditingController();
  final city2Controller = TextEditingController();
  final stateController = TextEditingController();

  int userType = 0;
  File? selectedImage;
  String? selectedImageFilepPath;
  var isUpdate = false;
  var customerId = ''.obs;

  var customers = <Map<String, dynamic>>[].obs;
  final ImagePicker _picker = ImagePicker();
  Map<String, dynamic>? images;
  late final BranchController branchController;

  final List<bool> selectedUserType = <bool>[true, false];
  final List<Widget> userTypes = <Widget>[
    const Text('Customer'),
    const Text('Supplier')
  ];

  bool showOptionals = false;

  @override
  void onInit() {
    super.onInit();
    branchController = Get.find<BranchController>();
  }

  void pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update();
    }
  }

  void loadCustomerData() {
    Customer? customerData = Get.arguments;
    if (customerData != null) {
      nameController.text = customerData.name;
      phoneController.text = customerData.phone;
      userType = customerData.type ?? 0;
      isUpdate = true;
      update();
    }
  }

  getCustomerSuppliers({int? selectedUserType}) async {
    if (branchController.selectedBranch == null) return;
    EasyLoading.show();
    var data = await CustomerSupplierRepo().getCustomerSupplier(
        "${branchController.selectedBranch}", "${selectedUserType??userType}");
    if (data != null) {
      customerSupplierResModel = data;
      update();
    }
    EasyLoading.dismiss();
  }

  void clearForm() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    areaController.clear();
    postCodeController.clear();
    cityController.clear();
    stateController.clear();
    selectedImage = null;
    isUpdate = false;
    customerId.value = '';
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    areaController.dispose();
    postCodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    super.onClose();
  }

  createCustomerSupplier() async {
    final data = {
      'name': nameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'type': userType.toString(),
      'address': addressController.text,
      'area': areaController.text,
      'post_code': postCodeController.text,
      'city': cityController.text,
      'state': stateController.text,
    };
    if (selectedImage != null) {
      images = {
        'image': selectedImage!.path,
      };
    }
    EasyLoading.show();
    String? value = await CustomerSupplierRepo().createCustomerSupplier(
        data, "${branchController.selectedBranch}", images);
    EasyLoading.dismiss();
    if (value != null) {
      showCustomSnackBar("${userType == 0 ? "Customer" : "Supplier"} Successfully Created",);
      await getCustomerSuppliers();
      Navigator.of(Get.context!).pop();
      clearForm();
    }
  }

  updateCustomerSupplier() async {
    final data = {
      'name': nameController.text,
      'phone': phoneController.text,
      'type': userType.toString(),
    };
    EasyLoading.show();
    String? value = await CustomerSupplierRepo().updateCustomerSupplier(
        data, "${branchController.selectedBranch}", "${Get.arguments.id}");
    EasyLoading.dismiss();
    if (value != null) {
      showCustomSnackBar("${userType == 0 ? "Customer" : "Supplier"} Successfully Updated",);
      await getCustomerSuppliers();
      Navigator.of(Get.context!).pop();
      clearForm();
    }
  }

  void showDeleteCustomerSupplierDialog({required Customer customer}) {
    Get.defaultDialog(
      title: "Delete ${selectedUserType[0] ? "Customer" : "Supplier"}",
      middleText:
          "Do you want to Delete \"${customer.name}\"  ${selectedUserType[0] ? "Customer" : "Supplier"}?",
      onConfirm: () async {
        String? value = await CustomerSupplierRepo().deleteCustomerSupplier(
            "${branchController.selectedBranch}", "${customer.id}");
        if (value != null) {
          Get.snackbar("Success",
              "\"${customer.name}\"  ${selectedUserType[0] ? "Customer" : "Supplier"} Successfully Deleted");
          Navigator.pop(Get.context!);
          getCustomerSuppliers();
        }
      },
    );
  }
}
