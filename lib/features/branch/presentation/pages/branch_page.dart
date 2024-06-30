import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs_skill_test/features/branch/controllers/branch_controller.dart';
import 'package:rs_skill_test/features/branch/data/models/branch_res_model.dart';

import '../../../../core/utils/constants.dart';
import '../../../main_page/controllers/main_page_controller.dart';

class BranchPage extends StatefulWidget {
  const BranchPage({super.key});

  @override
  State<BranchPage> createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage> {
  BranchController branchController = Get.find<BranchController>();
  @override
  Widget build(BuildContext context) {
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
        title: const Text("Branch"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => Get.find<BranchController>().getBranches(),
          ),
        ],
      ),
      body: GetBuilder<BranchController>(
        init: branchController,
        builder: (controller) {
          return
            branchController.branchResponseModel==null? const SizedBox():
          ListView.builder(
            itemCount: branchController.branchResponseModel!.branches.branches.length,
            itemBuilder: (context, index) {
              final branch = branchController.branchResponseModel!.branches.branches[index];
              return _buildBranchCard(branch);
            },
          );
        },
      ),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle

        ),
        child: FloatingActionButton(onPressed: (){
          Get.find<BranchController>().showCreateUpdateBranchDialog();
        }, child: const Icon(Icons.add)),
      ),
    );
  }
}

Widget _buildBranchCard(Branch branch) {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: ListTile(
      title: Text(branch.name),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        InkWell(
          onTap: (){
            Get.find<BranchController>().showCreateUpdateBranchDialog(branch: branch);
          },
            child: const Icon(Icons.edit, size: 20, color: Colors.green, )),
        const SizedBox(width: 15,),
        InkWell(
            onTap: (){
              Get.find<BranchController>().showDeleteBranchDialog(branch: branch);
            },
            child: const Icon(Icons.delete_forever, size: 20, color: Colors.red, )),
      ],),
      // Add any other widgets you want (e.g., icons, buttons, etc.)
    ),
  );
}

