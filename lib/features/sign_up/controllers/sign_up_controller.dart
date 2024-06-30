import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rs_skill_test/core/utils/constants.dart';
import 'package:rs_skill_test/global/presentation/components/custom_material_button.dart';
import 'package:rs_skill_test/global/presentation/components/custom_texfield.dart';
import 'package:rs_skill_test/global/presentation/components/custom_text_widget.dart';

import '../../../core/routes/routes.dart';
import '../data/repositories/sign_up_repository.dart';
import '../presentation/pages/otp_verification_page.dart';


class SignUpController extends GetxController {
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final businessNameController = TextEditingController();

  final TextEditingController otpController = TextEditingController();
  final otpKey = GlobalKey<FormState>();

  signUp() async {

    final signUpBody = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": phoneNumberController.text.trim(),
        "business_name": businessNameController.text.trim(),
        "business_type_id": 7,
    };

    EasyLoading.show();
    int? identifierID = await SignUpRepository().registration(signUpBody);
    if(identifierID!=null){
      Get.snackbar("Success", "OTP Send Success");
      showVerificationDialog(identifierID);
    }
}

  void showVerificationDialog(int identifierID){
    TextEditingController  otpTextController =  TextEditingController();
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
                     CustomText(text: "Verify OTP", fontSize: 16, fontWeight: FontWeight.bold,),
                    const SizedBox(height: 20,),
                    CustomTextField(
                      label: "OTP",
                      textAlign: TextAlign.center,
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      controller: otpTextController,
                      formKey: otpKey,
                      style: Style.circular,
                    ),
                    const SizedBox(height: 20,),

                    CustomMaterialButton(
                      textColor: Colors.white,
                      onPressed: () async {

                        if (otpKey.currentState!.validate())  {
                          EasyLoading.show();
                          var value =
                          await SignUpRepository().verifyOtp({
                            "identifier_id": identifierID,
                            "otp_code": otpTextController.text,
                          });
                          if (value != null) {
                            GetStorage().remove(signUpRes);
                            GetStorage().write(signUpRes, value.toJson());
                            GetStorage().write(accessToken, value.apiToken);
                            Get.snackbar("Success", "Sign up Successfully");
                            Get.offNamedUntil(Routes.mainPage, (route) => false);
                          }
                        }
                      }, title: "Verify", backgroundColor: Colors.green.shade700,),
                    const SizedBox(height: 10,),
                    CustomMaterialButton(
                      textColor: Colors.white,
                      onPressed: () async {
                        var value =
                            await SignUpRepository().resendOtp({
                          "email": emailController.text,
                          "phone": phoneNumberController.text,
                        });
                        if (value != null) {
                          Get.snackbar("Success", "${value}");
                          //Get.offNamedUntil(Routes.mainPage, (route) => false);
                        }
                      }, title: "Resend OTP", backgroundColor: Colors.blue,)
                  ],
                ),
              ),
            )
          ],
        ),
      barrierDismissible: true,
        );

  }
}
