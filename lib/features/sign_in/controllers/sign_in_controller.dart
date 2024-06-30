import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rs_skill_test/features/sign_in/data/models/login_res_model.dart';

import '../../../core/routes/routes.dart';
import '../../../core/utils/constants.dart';
import '../../../global/presentation/components/custom_material_button.dart';
import '../../../global/presentation/components/custom_texfield.dart';
import '../../../global/presentation/components/custom_text_widget.dart';
import '../data/repositories/sign_in_repository.dart';

class SignInController extends GetxController {
  final identifierController = TextEditingController(text: "testaccount@gmail.com");

  sendLogInOtp() async {
    final body = {
      "identifier": identifierController.text.trim(),
    };

    EasyLoading.show();
    var data = await SignInRepository().sendLogInOtp(body);
    if (data != null) {
    Get.snackbar("Success", "OTP Send Success");
    showVerificationDialog(identifierController.text);
      // await GetStorage().remove(userProfileKey);
      // await GetStorage().write(userProfileKey, data);
      // Get.offNamedUntil(Routes.mainPage, (route) => false);
    }
  }


  void showVerificationDialog(String identifier){
    TextEditingController  otpTextController =  TextEditingController(text: "123456");
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
                        LogInResponseModel? value =
                        await SignInRepository().logIn({
                          "identifier": identifier,
                          "otp_code": otpTextController.text,
                        });
                        if (value != null) {
                          GetStorage().remove(logInRes);
                          GetStorage().write(logInRes, value.toJson());
                          GetStorage().write(accessToken, value.user.apiToken);
                          Get.snackbar("Success", value.description);
                          Get.offNamedUntil(Routes.mainPage, (route) => false);
                        }
                      }
                    }, title: "Verify", backgroundColor: Colors.green.shade700,),
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
}
