import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rs_skill_test/core/utils/constants.dart';

import '../presentation/components/custom_animated_snackbar.dart';
import '../presentation/components/custom_image_upload_bottomsheet.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
//Get external storage directory
  Directory directory = await getApplicationSupportDirectory();
//Get directory path
  String path = directory.path;
//Create an empty file to write PDF data
  File file = File('$path/$fileName');
//Write PDF data
  await file.writeAsBytes(bytes, flush: true);
//Open the PDF document in mobile
  OpenFile.open('$path/$fileName');
}

Future<XFile?> chooseImageMultipart({fromCamera = false}) async {
  final pickedFile = await ImagePicker().pickImage(
    source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    return XFile(pickedFile.path);
  }
  return null;
}

void showCustomImageUploadBottomSheet(
    context, Function() onSelectCamera, Function() onSelectGallery) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
    ),
    builder: (context) {
      return CustomImageUploadBottomSheet(onSelectCamera, onSelectGallery);
    },
  );
}

chooseImage(BuildContext context, Function(String imagePath) onChooseImage) {
  showCustomImageUploadBottomSheet(context, () async {
    XFile? selectedImage = await chooseImageMultipart(fromCamera: true);
    onChooseImage(selectedImage!.path);
  }, () async {
    XFile? selectedImage = await chooseImageMultipart();
    onChooseImage(selectedImage!.path);
  });
}

  showCustomSnackBar(String message,  {Alignment alignment  = Alignment.topCenter, double distance = 110 }) async {
    final snackBar = SnackBar(
      elevation: 0.0,
      content: CustomAnimatedSnackbar(message: message),
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.fromLTRB(20,
         0,// alignment==Alignment.topCenter?  Get.height-distance: distance,
          20,
      alignment==Alignment.topCenter? 
        Get.height-distance 
          : //Get.height-distance
        //  alignment==Alignment.bottomCenter?  distance :
          alignment==Alignment.center? (Get.height/2): distance, //(Get.height/2)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
    
     WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(scaffoldKey.currentState!.context).showSnackBar(snackBar);
  });
  }

