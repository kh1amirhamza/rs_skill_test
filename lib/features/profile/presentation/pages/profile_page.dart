import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rs_skill_test/features/profile/controllers/profile_controller.dart';
import 'package:rs_skill_test/features/profile/data/models/profile_res_model.dart';
import 'package:rs_skill_test/features/profile/presentation/pages/edit_profile.dart';
import 'package:rs_skill_test/global/presentation/components/custom_image_view.dart';
import 'package:rs_skill_test/global/presentation/components/custom_material_button.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../global/presentation/components/custom_image.dart';
import '../../../main_page/controllers/main_page_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
        actions: [
          InkWell(
            onTap: (){
              Get.to(()=> EditProfile());
            },
            child: Padding(padding: EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                    Icons.edit,
                    color: Colors.black,
                    ),
                const SizedBox(width: 5,),
                Text('Edit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
              ],
            )
                    ,
          ))],
        title: const Text("Profile"),
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          ProfileResponseModel? profile = controller.profileResponseModel;
          return controller.profileResponseModel==null?
              const SizedBox():
            SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: CustomImageView(
                      isOval: true,
                      height: 150,
                      boxFit: BoxFit.cover,
                      width: 150,
                      imageType: CustomImageType.network,
                      imageData: profile!.responseUser.imageFullPath,
                    )
                  ),

                  const SizedBox(height: 16),
                  Text(
                    profile.responseUser.name,
                    style: const TextStyle(
                      fontSize: 24, // Larger font size for the name
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    profile.responseUser.email,
                    style: TextStyle(color: Colors.grey), // Subdued email text color
                  ),
                  SizedBox(height: 8),
                  Text(
                    profile.responseUser.phone,
                    style: TextStyle(color: Colors.grey), // Subdued phone text color
                  ),
                  SizedBox(height: 24), // Increased spacing
                  const Text(
                    'Business Details:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Slightly smaller font size for business details
                    ),
                  ),
                  Text('Business Name: ${profile.responseUser.businessName}'),
                  Text('Business Type: ${profile.responseUser.businessType}'),
                  Text('Branch: ${profile.responseUser.branch}'),
                  const SizedBox(height: 60),

                  Center(
                    child: CustomMaterialButton(
                        width: 250,
                        onPressed: (){
                          GetStorage().remove(logInRes);
                          GetStorage().remove(signUpRes);
                          GetStorage().remove(accessToken);
                          Get.offNamedUntil(Routes.signIn, (route) => false);
                        },
                        title: "Log Out"),
                  ),

                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
