import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rs_skill_test/core/utils/constants.dart';
import 'package:rs_skill_test/features/branch/controllers/branch_controller.dart';
import 'package:rs_skill_test/features/branch/data/models/branch_res_model.dart';
import 'package:rs_skill_test/features/customer_suplier/controllers/customer_supplier_controller.dart';
import 'package:rs_skill_test/features/sign_in/data/models/login_res_model.dart';
import 'package:rs_skill_test/features/sign_up/data/models/sign_up_res_model.dart';
import 'package:rs_skill_test/features/transaction/data/models/transaction_res_model.dart';
import 'package:rs_skill_test/features/transaction/data/repositories/transactions_repo.dart';
import 'package:rs_skill_test/global/services/functions.dart';

import '../../customer_suplier/data/models/customer_supplier_res_model.dart';

class TransactionController extends GetxController {
  int? selectedCustomerSupplier;
  TransactionsResponseModel? transactionsResponseModel;
  late final BranchController branchController;
  late final CustomerSupplierController customerSupplierController;
  final List<bool> selectedUserType = <bool>[
    true,
    false,
  ];
  final List<Widget> userType = <Widget>[
    const Text('Customer'),
    const Text('Supplier')
  ];
  List<DropdownMenuItem<int>> dropdownCustomerSupplierItems = [];
  var selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  Map<String, dynamic>? images;
  Transaction? transaction;
  @override
  onInit() {
    super.onInit();
    clearForm();
    branchController = Get.find<BranchController>();
    customerSupplierController = Get.find<CustomerSupplierController>();
    getDropdownCustomerSupplierItems();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  final transactionDateController = TextEditingController();
  final detailsController = TextEditingController();
  final billNoController = TextEditingController();

  var isUpdate = false;
  var transactionId = ''.obs;
  var transactions = <Map<String, dynamic>>[].obs;
  int? transactionType;

  void pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void loadTransactionData() {
    transaction = Get.arguments;
    if (transaction != null) {
      amountController.text = transaction!.amount.toString();
      transactionType = transaction!.type;
      transactionDateController.text = transaction!.transactionDate.toIso8601String();
      detailsController.text = transaction!.details;
      billNoController.text = transaction!.billNo;
      transactionId.value = transaction!.id.toString();
      isUpdate = true;
      print("transactionType: $transactionType");
      update();
    }
  }
  void clearForm() {
    amountController.clear();
    transactionType=null;
    transactionDateController.clear();
    detailsController.clear();
    billNoController.clear();
    transactionId.value = '';
    selectedImage.value = null;
    isUpdate = false;

  }
  createTransaction() async {
    if (formKey.currentState!.validate()) {
      // var logInResJson = GetStorage().read(logInRes);
      // int customerId = 0;
      // if(logInResJson!=null){
      //   customerId = LogInResponseModel.fromJson(logInResJson).user.id;
      // }else{
      //   var signUpResJson = GetStorage().read(signUpRes);
      //   customerId = SignUpResponseModel.fromJson(signUpResJson).id;
      // }

      if (!isUpdate && selectedCustomerSupplier == -1) {
        Get.snackbar("Warning",
            "You need to select valid branch and ${selectedUserType[0] ? "Customer" : "Supplier"}");
        return;
      }else if(selectedImage.value==null){
        showCustomSnackBar("You need to select image");
        return;
      }
      final data = {
        'customer_id': '$selectedCustomerSupplier',
        'amount': amountController.text,
        'type': transactionType,
        'transaction_date': transactionDateController.text,
        'details': detailsController.text,
        'bill_no': billNoController.text,
      };
      final images = {
        'image': selectedImage.value!.path,
      };
      EasyLoading.show();
      String? value = await TransactionsRepo()
          .createTransaction(data, "${branchController.selectedBranch}", images);
      if (value != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text("Transaction successfully created")));
        showCustomSnackBar("Transaction successfully created");
        await getTransactions();
        Navigator.of(Get.context!).pop();
        clearForm();
      }
    }
  }

  updateTransaction() async {
    if (formKey.currentState!.validate()) {

      final data = {
        'amount': amountController.text,
        'type': transactionType,
        'transaction_date': transactionDateController.text,
        'details': detailsController.text,
        'bill_no': billNoController.text,
      };
      if(selectedImage.value!=null){
        images = {
          'image': selectedImage.value!.path,
        };
      }
      EasyLoading.show();
      String? value = await TransactionsRepo().updateTransaction(
          data, "${branchController.selectedBranch}", "${Get.arguments.id}", images);
      if (value != null) {
        showCustomSnackBar("Transaction successfully updated!");
        await getTransactions();
        Navigator.of(Get.context!).pop();
        clearForm();
      }
    }
  }



  @override
  void onClose() {
    amountController.dispose();
    transactionDateController.dispose();
    detailsController.dispose();
    billNoController.dispose();
    super.onClose();
  }


  // getCustomerID() {
  //   print("selectedCustomerSupplier:$selectedCustomerSupplier");
  //   Customer? customer = customerSupplierController
  //       .customerSupplierResModel!.customers.customers
  //       .firstWhereOrNull(
  //           (element) => "${element.id}" == selectedCustomerSupplier);
  //   if (customer != null) {
  //     return customer.id;
  //   } else {
  //     return -1;
  //   }
  // }

  getDropdownCustomerSupplierItems() async {
    print("getDropdownCustomerSupplierItems called");
    selectedCustomerSupplier= null;
    dropdownCustomerSupplierItems.clear();

    if (branchController.selectedBranch != -1) {
      await customerSupplierController.getCustomerSuppliers(selectedUserType: selectedUserType[0]?0:1);
      if (customerSupplierController.customerSupplierResModel != null) {
        dropdownCustomerSupplierItems.addAll(
            customerSupplierController.customerSupplierResModel!.customers.customers.map((e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.name)))
        );
        print("InitialValue: ${selectedCustomerSupplier},"
            " dropdownCustomerSupplierItemsLength: ${dropdownCustomerSupplierItems.length}");
        update();
      }
    } else {
      update();
    }
  }

  getTransactions() async {
    if (branchController.selectedBranch != -1 && selectedCustomerSupplier != -1) {
      EasyLoading.show();
      var data = await TransactionsRepo()
          .getTransactions("${branchController.selectedBranch}", "$selectedCustomerSupplier");
      transactionsResponseModel == null;
      if (data != null) {
        transactionsResponseModel = data;
        print("TransactionData is not null");
        update();
      } else {
        print("TransactionData is null");
        update();
      }
    }
  }

  // void showCreateUpdateBranchDialog({Branch? branch}){
  //   TextEditingController  branchNameTextController =  TextEditingController(
  //       text: branch!=null?branch.name:''
  //   );
  //   final otpKey = GlobalKey<FormState>();
  //   Get.dialog(
  //     Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Center(
  //           child: Container(
  //             margin: const EdgeInsets.fromLTRB(50, 30, 50, 20),
  //             padding: const EdgeInsets.fromLTRB(30, 2, 20, 30),
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(25)
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 const SizedBox(height: 10,),
  //                 CustomText(text: branch==null?"Create Branch": "Update Branch", fontSize: 16, fontWeight: FontWeight.bold,),
  //                 const SizedBox(height: 20,),
  //                 CustomTextField(
  //                   label: "Branch Name",
  //                   textAlign: TextAlign.center,
  //                   isRequired: true,
  //                   controller: branchNameTextController,
  //                   formKey: otpKey,
  //                   style: Style.circular,
  //                 ),
  //                 const SizedBox(height: 20,),
  //
  //                 CustomMaterialButton(
  //                   textColor: Colors.white,
  //                   onPressed: () async {
  //
  //                     if (otpKey.currentState!.validate())  {
  //                       EasyLoading.show();
  //                       String? value = branch==null?
  //                       await BranchRepo().createBranch({
  //                         "name": branchNameTextController.text,
  //                       })
  //                           :
  //                       await BranchRepo().updateBranch({
  //                         "name": branchNameTextController.text
  //                       }, "${branch.id}");
  //
  //
  //                       if (value != null) {
  //                         Get.snackbar("Success", "Branch Successfully ${branch==null? "Created": "Updated"}");
  //                         Navigator.pop(Get.context!);
  //                         getBranches();
  //                       }
  //                     }
  //                   }, title:branch==null? "Create": "Update", backgroundColor: Colors.green.shade700,),
  //                 const SizedBox(height: 10,),
  //
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //     barrierDismissible: true,
  //   );
  //
  // }

  void showDeleteTransactionDialog(
      { required int transactionID}) {
    Get.defaultDialog(
      title: "Delete Branch",
      middleText: "Do you want to delete \"${transactionID}\" transaction?",
      onConfirm: () async {
        String? value = await TransactionsRepo()
            .deleteTransaction("${branchController.selectedBranch}", "$transactionID");

        if (value != null) {

          Get.snackbar("Success",
              "\"$transactionId\" transaction successfully deleted");
          Navigator.pop(Get.context!);
          getTransactions();
        }
      },
      // confirm: Text("Delete"),
      // cancel: Text("Cancel"),
    );
  }
}
