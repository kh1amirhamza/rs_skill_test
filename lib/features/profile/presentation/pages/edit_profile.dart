import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs_skill_test/core/utils/constants.dart';
import 'package:rs_skill_test/features/profile/controllers/profile_controller.dart';
import 'package:rs_skill_test/global/presentation/components/custom_material_button.dart';

import '../../../../global/presentation/components/custom_dropdown_button.dart';
import '../../../../global/presentation/components/custom_image_view.dart';
import '../../../../global/presentation/components/custom_texfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  GlobalKey<FormState> businessTypeKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ProfileController>().loadProfileData();
    });
    return GetBuilder<ProfileController>(builder: (controller){
      return Scaffold(
        appBar: AppBar(title: const Text("Edit Profile"),),
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 20),
            
              Stack(
                alignment: Alignment.center,
                children: [
                  Obx(() => Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: CustomImageView(
                          isOval: true,
                          height: 130,
                          boxFit: BoxFit.cover,
                          width: 130,
                          imageType: controller.selectedImage.value != null?
                          CustomImageType.file: CustomImageType.network,
                          imageData: controller.selectedImage.value != null?
                          controller.selectedImage.value!.path :
                          controller.profileResponseModel!.responseUser.imageFullPath,
                        ),
                      )
                  ),),
              
              
                  Positioned(
                    bottom: 0,
                      child: SizedBox(
                        width: 110,
                        child: CustomMaterialButton(
                          borderWidth: 0,
                          backgroundColor: primaryColor,
                            onPressed: ()=>controller.pickImage()
                            , title: 'Choose Image',
                          padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                          borderRadius: 15,
                        ),
                      )
                  )
              
                ],
              ),
            
              const SizedBox(
                height: 20,
              ),
            
              CustomTextField(
                label: "Name",
                isRequired: true,
                labelTextSize: 14,
                controller: controller.nameController,
                formKey: nameKey,
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              ),
              const SizedBox(
                height: 10,
              ),
            
              CustomDropDownButton(
                labelTextSize: 14,
                label: "Business Type",
                formKey: businessTypeKey,
                initialSelectedValue: controller.businessType,
                dropDownMenuItems: controller.dropdownBusinessTypeItems,
                onChange: (int? newValue) async {
                  controller.businessType =  newValue;
                  controller.update();
                },
                isRequired: true,
              ),
            
            
            
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if(nameKey.currentState!.validate()
                        && businessTypeKey.currentState!.validate()){
                          controller.updateProfile();
                        }
                      },
                      child: const Text("Update Profile"),
                    ),
                  ),
                ],
              ),
            ]),
          )
      ));
    });
  }
}
