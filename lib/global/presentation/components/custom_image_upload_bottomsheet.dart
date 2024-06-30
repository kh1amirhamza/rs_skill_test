import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomImageUploadBottomSheet extends StatelessWidget {
  final Function() onSelectCamera;
  final Function() onSelectGallery;
  const CustomImageUploadBottomSheet(this.onSelectCamera, this.onSelectGallery,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      width: Get.width.w,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                onSelectCamera();
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(Icons.photo_camera_outlined, color: Colors.blue),
                  SizedBox(width: 10.w),
                  Text(
                    'Take photo from camera',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () async {
                onSelectGallery();
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(Icons.image, color: Colors.blue),
                  SizedBox(width: 10.w),
                  Text(
                    'Pick image from device',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
