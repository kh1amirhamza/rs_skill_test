import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs_skill_test/core/utils/utils.dart';

import '../../../../core/utils/constants.dart';
import '../../../../global/presentation/components/custom_animated_snackbar.dart';
import '../../../../global/services/functions.dart';
import '../../../branch/controllers/branch_controller.dart';
import '../../../main_page/controllers/main_page_controller.dart';
import '../../controllers/customer_supplier_controller.dart';
import 'customer_supplier_create_page.dart';

class CustomerSupplierListPage extends StatefulWidget {
  const CustomerSupplierListPage({super.key});

  @override
  State<CustomerSupplierListPage> createState() => _CustomerSupplierListPageState();
}

class _CustomerSupplierListPageState extends State<CustomerSupplierListPage> {

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<CustomerSupplierController>().getCustomerSuppliers();
    });

    return GetBuilder<CustomerSupplierController>(
        builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Customers & Suppliers'),
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
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => controller.getCustomerSuppliers()
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20,5,20,20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int index) {
                        setState(() {
                          // The button that is tapped is set to true, and the others to false.
                          for (int i = 0;
                          i < controller.selectedUserType.length;
                          i++) {
                            controller.selectedUserType[i] = i == index;
                          }
                          controller.userType = index;
                          //controller.selectedBranch = "Select Branch";
                          if (controller.customerSupplierResModel != null) {
                            controller.customerSupplierResModel!.customers
                                .customers
                                .clear();
                          }
                          controller.getCustomerSuppliers();
                        });
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: primaryColor,
                      selectedColor: Colors.white,
                      fillColor: primaryColor,
                      color: Colors.black,
                      constraints: BoxConstraints(
                        minHeight: 35.0,
                        minWidth: (Get.width / 2) - 45,
                      ),
                      isSelected: controller.selectedUserType,
                      children: controller.userTypes,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                controller.customerSupplierResModel == null?
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: GetBuilder<BranchController>(
                      builder: (branchController) {
                        return Text(branchController.selectedBranch==null?
                        "Branch not selected!\nSelect first from the left drawer!":
                            'No customers/suppliers found!', textAlign: TextAlign.center,);
                      }
                    ),
                    ),
                  ),
                ):
                //const Expanded(child: Center(child: Text('No customers/suppliers found'))):
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.customerSupplierResModel!.customers.customers.length,
                    itemBuilder: (context, index) {
                      var customer = controller.customerSupplierResModel!.customers.customers[index];
                      return ListTile(

                        title: Text(customer.name),
                        subtitle: Text(customer.phone),
                        trailing: Column(
                          children: [
                            Text('Balance: ${customer.balance}'),
                            const SizedBox(height: 5,),
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              InkWell(
                                  onTap: (){
                                    controller.isUpdate = true;
                                    customer.type = controller.selectedUserType[0]?0:1;
                                    Get.to(() => CustomerSupplierCreatePage(), arguments: customer);
                                    //Get.find<BranchController>().showCreateUpdateBranchDialog(branch: branch);
                                  },
                                  child: const Icon(Icons.edit, size: 20, color: Colors.green, )),
                              const SizedBox(width: 15,),
                              InkWell(
                                  onTap: (){
                                    controller.showDeleteCustomerSupplierDialog(customer: customer);
                                  },
                                  child: const Icon(Icons.delete_forever, size: 20, color: Colors.red, )),
                            ],),
                          ],
                        ),
                        //onTap: () => Get.to(() => CustomerSupplierCreatePage(), arguments: customer),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.isUpdate = false;
              Get.to(() => CustomerSupplierCreatePage());
             // Get.to(() => TestWidget());
            } ,
            child: Icon(Icons.add),
          ),
        );
      }
    );
  }
}
