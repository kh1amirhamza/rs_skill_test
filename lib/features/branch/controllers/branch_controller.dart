import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rs_skill_test/features/branch/data/models/branch_res_model.dart';
import 'package:rs_skill_test/features/branch/data/repositories/branch_repo.dart';

import '../../../core/utils/constants.dart';
import '../../../global/presentation/components/custom_material_button.dart';
import '../../../global/presentation/components/custom_texfield.dart';
import '../../../global/presentation/components/custom_text_widget.dart';

class BranchController extends GetxController{

  BranchResponseModel? branchResponseModel;
  //int selectedBranchId = -1;
  List<DropdownMenuItem<int>> dropdownBranchItems = [];
  int? selectedBranch;
  @override
  onInit(){
    super.onInit();
    selectedBranch = GetStorage().read(branchKey);
    getDropdownBranchItems();
  }

  getBranches() async {
    EasyLoading.show();
    var data = await BranchRepo().getBranches();
    if(data!=null){
      branchResponseModel==null;
      branchResponseModel = data;
      update();
    }
  }

  getDropdownBranchItems() async {
    dropdownBranchItems.clear();
    await getBranches();
    if(branchResponseModel!=null){
      // for(int i=0; i<branchResponseModel!.branches.branches.length; i++){
      //   dropdownBranchItems.add(DropdownMenuItem(value: i,
      //       child: Text(branchResponseModel!.branches.branches[i].name)));
      // }
      dropdownBranchItems.addAll(branchResponseModel!.branches.branches.map((e) =>
          DropdownMenuItem(value: e.id, child: Text(e.name))
      ).toSet());
      update();
    }
  }
  // int getBranchID(){
  //   Branch? branch =  branchResponseModel!.branches.branches.firstWhereOrNull((element) => element.name== selectedBranch);
  //   if(branch!=null){
  //     return branch.id;
  //   }else{
  //     return -1;
  //   }
  // }

  void showCreateUpdateBranchDialog({Branch? branch}){
    TextEditingController  branchNameTextController =  TextEditingController(
      text: branch!=null?branch.name:''
    );
    final otpKey = GlobalKey<FormState>();
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(50, 30, 50, 20),
              padding: const EdgeInsets.fromLTRB(30, 2, 20, 30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10,),
                  CustomText(text: branch==null?"Create Branch": "Update Branch", fontSize: 16, fontWeight: FontWeight.bold,),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    label: "Branch Name",
                    textAlign: TextAlign.center,
                    isRequired: true,
                    controller: branchNameTextController,
                    formKey: otpKey,
                    style: Style.circular,
                  ),
                  const SizedBox(height: 20,),

                  CustomMaterialButton(
                    textColor: Colors.white,
                    onPressed: () async {

                      if (otpKey.currentState!.validate())  {
                        EasyLoading.show();
                        String? value = branch==null?
                        await BranchRepo().createBranch({
                          "name": branchNameTextController.text,
                        })
                        :
                        await BranchRepo().updateBranch({
                          "name": branchNameTextController.text
                        }, "${branch.id}");


                        if (value != null) {
                          Get.snackbar("Success", "Branch Successfully ${branch==null? "Created": "Updated"}");
                          Navigator.pop(Get.context!);
                          getBranches();
                        }
                      }
                    }, title:branch==null? "Create": "Update", backgroundColor: Colors.green.shade700,),
                  const SizedBox(height: 10,),

                ],
              ),
            ),
          )
        ],
      ),
      barrierDismissible: true,
    );

  }


  void showDeleteBranchDialog({required Branch branch}){

    Get.defaultDialog(
      title: "Delete Branch",
      middleText: "Do you want to Delete \"${branch.name}\" Branch?",
      onConfirm: () async {
        String? value =
        await BranchRepo().deleteBranch("${branch.id}");

        if (value != null) {
          Get.snackbar("Success", "\"${branch.name}\" Branch Successfully Deleted");
          Navigator.pop(Get.context!);
          getBranches();
        }
      },
      onCancel: (){
        Get.back();
      },
     // confirm: Text("Delete"),
     // cancel: Text("Cancel"),
    );
  }

}