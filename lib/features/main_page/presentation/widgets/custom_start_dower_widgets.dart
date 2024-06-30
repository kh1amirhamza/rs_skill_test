import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rs_skill_test/features/branch/controllers/branch_controller.dart';
import 'package:rs_skill_test/features/customer_suplier/controllers/customer_supplier_controller.dart';
import 'package:rs_skill_test/features/customer_suplier/presentation/pages/customer_supplier_create_page.dart';
import 'package:rs_skill_test/features/customer_suplier/presentation/pages/customer_supplier_list_page.dart';
import 'package:rs_skill_test/features/transaction/controllers/transaction_controller.dart';
import 'package:rs_skill_test/features/transaction/presentation/pages/transaction_create_update_page.dart';
import 'package:rs_skill_test/global/presentation/components/custom_dropdown_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../global/presentation/components/custom_image.dart';

class CustomStartDower extends StatelessWidget {
  CustomStartDower({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double statusBarHeight = MediaQuery.paddingOf(context).top;
    const double kDrawerHeaderHeight = 160.0 + 1.0; // bottom edge

    return Drawer(
      //backgroundColor: primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  height: statusBarHeight + kDrawerHeaderHeight,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: Divider.createBorderSide(context,
                          color: primaryColor, width: 1.5),
                    ),
                  ),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0)
                        .add(EdgeInsets.only(top: statusBarHeight)),
                    decoration: const BoxDecoration(color: Colors.white),
                    //margin: const EdgeInsets.only(bottom: 8.0),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    child: DefaultTextStyle(
                      style: theme.textTheme.bodyLarge!,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: const CustomImage(
                          path: "assets/images/retinasoft.png",
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: primaryColor,
                      ),
                      color: Colors.black12,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GetBuilder<BranchController>(
              init: Get.find<BranchController>(),
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: CustomDropDownButton(
                    labelTextSize: 14,
                    label: "Branch",
                      //style: Style.circular,
                      initialSelectedValue: controller.selectedBranch,
                      dropDownMenuItems: controller.dropdownBranchItems,
                      onChange: (int? newValue){

                        controller.selectedBranch = newValue;
                        GetStorage().write(branchKey, newValue);
                        // if(controller.selectedBranchId!=-1){
                        //   controller.getCustomerSuppliers("${controller.selectedBranchId}", "${controller.selectedUserType[0]==true?0:1}");
                        // }
                        controller.update();
                      }, isRequired: true,),
                );
              }),
          // const SizedBox(
          //   height: 10,
          // ),
          ListTile(
            leading: const Icon(Icons.dashboard_customize_outlined),
            title: const Text('Create Customer/Supplier', style: TextStyle(fontSize: 14),),
            onTap: () {
              // Handle the tap
              Navigator.pop(context);
              Get.find<CustomerSupplierController>().isUpdate = false;
              Get.to(() =>  CustomerSupplierCreatePage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.group_work_outlined),
            title: const Text('Create Branch', style: TextStyle(fontSize: 14),),
            onTap: () {
              // Handle the tap
              Navigator.pop(context);
              Get.find<BranchController>().showCreateUpdateBranchDialog();
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: const Text('Create Transaction', style: TextStyle(fontSize: 14),),
            onTap: () {
              // Handle the tap
              Navigator.pop(context);
              Get.find<TransactionController>().isUpdate = false;
              Get.to(() => const TransactionCreateUpdatePage());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: primaryColor,
            ),
            title: const Text('Logout', style: TextStyle(fontSize: 14),),
            onTap: () {
              Get.back();
              GetStorage().remove(logInRes);
              GetStorage().remove(signUpRes);
              GetStorage().remove(accessToken);
              Get.offNamedUntil(Routes.signIn, (route) => false);
            },
          ),
        ],
      ),
    );
  }

  ///Launch url
  Future<void> urlLaunch(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
          mode: LaunchMode.externalApplication);
    }
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Colors.red, // Change this to your desired color
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
    );
  }
}
