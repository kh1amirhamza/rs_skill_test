import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs_skill_test/core/utils/constants.dart';
import 'package:rs_skill_test/features/transaction/data/models/transaction_res_model.dart';
import 'package:rs_skill_test/features/transaction/presentation/pages/transaction_create_update_page.dart';
import 'package:rs_skill_test/features/transaction/presentation/widgets/transaction_list_item.dart';

import '../../../../global/presentation/components/custom_dropdown_button.dart';
import '../../../branch/controllers/branch_controller.dart';
import '../../../main_page/controllers/main_page_controller.dart';
import '../../controllers/transaction_controller.dart';
import '../widgets/transaction_item.dart';

class TransactionPage extends StatefulWidget {
 const TransactionPage({super.key});



  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  GlobalKey<FormState> selectedCustomerSupplierKey = GlobalKey<FormState>();

  TransactionController transactionController =
      Get.find<TransactionController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
        init: transactionController,
        builder: (TransactionController controller)  {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  scaffoldKey
                      .currentState!
                      .openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                )),
            title: const Text(
              "Transactions",
            ),
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            width: double.maxFinite,
            child: Column(
              // shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
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
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
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

                const SizedBox(
                  height: 25,
                ),

                // ///CustomerSupplier
                // Text(controller.selectedUserType[0] == true
                //     ? "Select Customer"
                //     : "Select Supplier", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),),
                // const SizedBox(height: 3,),
                // DropdownButton<String>(
                //   isDense: true,
                //   isExpanded: true,
                //   value: controller.selectedCustomerSupplier!,
                //   items: controller.dropdownCustomerSupplierItems,
                //   onChanged: (newValue) async {
                //     controller.selectedCustomerSupplier = controller
                //         .dropdownCustomerSupplierItems
                //         .firstWhere(
                //             (element) => "${element.value}" == newValue)
                //         .value;
                //     await controller.getTransactions();
                //     controller.update();
                //   },
                // ),
                const SizedBox(
                  height: 10,
                ),

                (controller.transactionsResponseModel == null ||
                    controller.transactionsResponseModel!.transactions
                        .transactions.isEmpty)?
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: GetBuilder<BranchController>(
                          builder: (branchController) {
                            return Text(branchController.selectedBranch==null?
                            "Branch not selected!\nSelect first from the left drawer!":
                            'No transaction found!', textAlign: TextAlign.center,);
                          }
                      ),
                    ),
                  ),
                )

                    : GridView.builder(
                    itemCount: controller.transactionsResponseModel!
                        .transactions.transactions.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Transaction transaction = controller
                          .transactionsResponseModel!
                          .transactions
                          .transactions[index];
                      return TransactionListItem(
                        transaction: transaction,
                      );
                    },
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (Get.width > 600
                          ? 2
                          : 1), // 2 columns for tablet, 1 for mobile
                      mainAxisSpacing: 3.0,
                      crossAxisSpacing: 3.0,
                      childAspectRatio: 2.0,
                    ))
              ],
            ),
          ),
          floatingActionButton: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle

            ),
            child: FloatingActionButton(onPressed: (){
              controller.isUpdate = false;
              controller.clearForm();
              Get.to(() => TransactionCreateUpdatePage());
            }, child: const Icon(Icons.add)),
          ),
        );
      }
    );
  }
}
