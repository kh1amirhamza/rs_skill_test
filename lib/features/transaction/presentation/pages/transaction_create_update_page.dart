import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rs_skill_test/features/transaction/controllers/transaction_controller.dart';
import 'package:rs_skill_test/global/presentation/components/custom_image_view.dart';

import '../../../../core/utils/constants.dart';
import '../../../../global/presentation/components/custom_dropdown_button.dart';
import '../../../../global/presentation/components/custom_texfield.dart';

class TransactionCreateUpdatePage extends StatefulWidget {
  const TransactionCreateUpdatePage({super.key});

  @override
  State<TransactionCreateUpdatePage> createState() =>
      _TransactionCreateUpdatePageState();
}

class _TransactionCreateUpdatePageState
    extends State<TransactionCreateUpdatePage> {
  GlobalKey<FormState> selectedCustomerSupplierKey = GlobalKey<FormState>();
  GlobalKey<FormState> transactionTypeKey = GlobalKey<FormState>();
  GlobalKey<FormState> amountKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(Get.find<TransactionController>().isUpdate){
        Get.find<TransactionController>().loadTransactionData();
      }
    });
    return GetBuilder<TransactionController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(controller.isUpdate
              ? 'Update Transaction'
              : 'Create Transaction'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                if (!controller.isUpdate)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ToggleButtons(
                            direction: Axis.horizontal,
                            onPressed: (int index) {
                              setState(() async {
                                // The button that is tapped is set to true, and the others to false.
                                for (int i = 0;
                                    i < controller.selectedUserType.length;
                                    i++) {
                                  controller.selectedUserType[i] = i == index;
                                }

                                if (controller.customerSupplierController.customerSupplierResModel != null) {
                                  controller.customerSupplierController.customerSupplierResModel!.customers
                                      .customers
                                      .clear();
                                }
                                if (controller.transactionsResponseModel != null) {
                                  controller.transactionsResponseModel!.transactions
                                      .transactions
                                      .clear();
                                }
                                await controller.getDropdownCustomerSupplierItems();
                              });
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            selectedBorderColor: primaryColor,
                            selectedColor: Colors.white,
                            fillColor: primaryColor,
                            color: Colors.black,
                            constraints: BoxConstraints(
                              minHeight: 35.0,
                              minWidth: (Get.width / 2) - 30,
                            ),
                            isSelected: controller.selectedUserType,
                            children: controller.userType,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      CustomDropDownButton(
                        labelTextSize: 14,
                        label: controller.selectedUserType[0] == true
                            ? "Customer"
                            : "Supplier",
                        //style: Style.circular,
                        formKey: selectedCustomerSupplierKey,
                        initialSelectedValue: controller.selectedCustomerSupplier,
                        dropDownMenuItems: controller.dropdownCustomerSupplierItems,
                        onChange: (int? newValue) async {
                          controller.selectedCustomerSupplier =  newValue;
                          await controller.getTransactions();
                        },
                        isRequired: true,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  label: "Amount",
                  isRequired: true,
                  labelTextSize: 14,
                  controller: controller.amountController,
                  formKey: amountKey,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDropDownButton(
                  labelTextSize: 14,
                  label: "Transaction Type",
                  //style: Style.circular,
                  formKey: transactionTypeKey,
                  initialSelectedValue: controller.transactionType,
                  dropDownMenuItems: const [
                    DropdownMenuItem(value: 0, child: Text('You get')),
                    DropdownMenuItem(value: 1, child: Text('You gave')),
                  ],
                  onChange: (int? newValue) async {
                    controller.transactionType =  newValue;
                  },
                  isRequired: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  label: "Details",
                  isRequired: true,
                  labelTextSize: 14,
                  controller: controller.detailsController,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  maxLines: 3,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  label: "Bill No",
                  isRequired: true,
                  labelTextSize: 14,
                  controller: controller.billNoController,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () => DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2030, 6, 7), onChanged: (date) {
                    var outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
                    var outputDate = outputFormat.format(date);

                    controller.transactionDateController.text = outputDate;
                  }, onConfirm: (date) {
                    setState(() {});
                  }, onCancel: () {
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.en),
                  child: Text(controller.transactionDateController.text.isEmpty
                      ? 'Pick Date Time'
                      : controller.transactionDateController.text),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.pickImage(),
                  child: Text('Pick Image'),
                ),

                Obx(() => (controller.selectedImage.value == null && !controller.isUpdate)
                    ? Center(child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                      child: Text('No image selected.'),
                    ))
                    : CustomImageView(
                    imageType: controller.selectedImage.value != null?
                CustomImageType.file: CustomImageType.network,
                  imageData: controller.selectedImage.value != null?
                  controller.selectedImage.value!.path : controller.transaction!.imageFullPath,
                ))
                //Image.file(controller.selectedImage.value!))
                ,

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () => controller.isUpdate
                      ? controller.updateTransaction()
                      : controller.createTransaction(),
                  child: Text(controller.isUpdate ? 'Update' : 'Submit'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
