import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rs_skill_test/core/utils/constants.dart';
import 'package:rs_skill_test/features/profile/data/models/business_type_res_model.dart';
import 'package:rs_skill_test/features/profile/data/models/profile_res_model.dart';
import 'package:rs_skill_test/features/profile/data/repositories/profile_repo.dart';

import '../../../global/services/functions.dart';

class ProfileController extends GetxController {
  ProfileResponseModel? profileResponseModel;
  BusinessTypeResModel? businessTypeResModel;

  TextEditingController nameController = TextEditingController();

  int? businessType;
  List<DropdownMenuItem<int>> dropdownBusinessTypeItems = [];
  var selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  Map<String, dynamic>? images;

  @override
  onInit(){
    super.onInit();
    getProfile();
    getDropdownCustomerSupplierItems();
  }

  getProfile() async {
    EasyLoading.show();
    profileResponseModel = await ProfileRepo().getProfile();
    if(profileResponseModel!=null){
      update();
    }
  }

  updateProfile() async {
      final data = {
        'name': nameController.text,
        'business_type_id': businessType
      };
      if(selectedImage.value!=null){
        images = {
          'image': selectedImage.value!.path,
        };
      }
      EasyLoading.show();
      String? value = await ProfileRepo().updateProfile(
          data, images);
      if (value != null) {
        showCustomSnackBar("Profile successfully updated!");
        await getProfile();
        Navigator.of(Get.context!).pop();
        clearForm();
      }
  }

  getDropdownCustomerSupplierItems() async {
    print("getDropdownCustomerSupplierItems called");
    businessType = null;
    dropdownBusinessTypeItems.clear();
      await getBusinessTypes();
      if (businessTypeResModel != null) {
        dropdownBusinessTypeItems.addAll(
            businessTypeResModel!.businessTypes.map((e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.name)))
        );
        update();
      }

  }

  getBusinessTypes() async {
    EasyLoading.show();
    businessTypeResModel = await ProfileRepo().getBusinessTypes();
    if(businessTypeResModel!=null){
      update();
    }
  }


  void pickImage() async {
    chooseImage(scaffoldKey.currentState!.context, (imagePath){
        selectedImage.value = File(imagePath);
    }
    );
  }

  void loadProfileData() {
    clearForm();
    if (profileResponseModel != null) {
      nameController.text = profileResponseModel!.responseUser.name.toString();
      businessType = profileResponseModel!.responseUser.businessTypeId;
      update();
    }
  }
  void clearForm() {
    nameController.clear();
    businessType=null;
    selectedImage.value = null;
  }

}
