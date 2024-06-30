import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../global/presentation/components/custom_image_view.dart';
import '../../../../global/presentation/components/custom_material_button.dart';
import '../../../../global/presentation/components/custom_texfield.dart';
import '../../../../global/presentation/components/custom_text_view.dart';
import '../../controllers/sign_in_controller.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =  Get.find<SignInController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
            (Get.width < 600) ? "Sign In" : "Sign In & Access Your Account"),
        leading: const SizedBox(),
      ),
      body: GetBuilder<SignInController>(
         init:  controller,
          builder: (controller) {
            final identifierFormKey = GlobalKey<FormState>();
        return Row(
          children: [


            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(30, 0
                        , 30, 10),
                    padding: const EdgeInsets.fromLTRB(10, 0
                        , 10, 10),
                    child: Column(
                      children: [
                        // if (Get.width < 600)
                        const Align(
                          alignment: Alignment.topCenter,
                          child: CustomImageView(
                            imageType: CustomImageType.assets,
                            imageData: "assets/images/signup.png",
                            height: 250,
                            width: 200,
                            borderWidth: 0,
                          ),
                        ),
                        // if (Get.width < 600)
                        //   const SizedBox(
                        //     height: 20,
                        //   ),
                        if (Get.width < 600)
                          const CustomTextView(
                            text: "Sign in & access your account",
                            textViewStyle: CustomTextViewStyle.large,
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(
                          height: 20,
                        ),

                        CustomTextField(
                          label: "Identifier",
                          hint: "Enter Email / Phone Number",
                          labelTextSize: 14,
                          labelColor: lightTextColor,
                          isRequired: true,
                          formKey: identifierFormKey,
                          controller: controller.identifierController,
                          //style: Style.circular,
                          errorMessage: "Enter valid email address!",
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        CustomMaterialButton(
                          //width: 120,
                          onPressed: () {
                            if (identifierFormKey.currentState!
                                    .validate()) {
                              controller.sendLogInOtp();
                            }
                          },
                          title: "Log In".toUpperCase(),
                          textColor: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          backgroundColor: primaryColor,
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        if (Get.width < 600) createAccount()
                        //const Text("Forgot Your Password?"),
                      ],
                    )),
              ),
            ),
            // if (Get.width >= 600)
            //   const SizedBox(
            //     width: 20,
            //   ),
            if (Get.width >= 600) Expanded(child: createAccount()),
            if (Get.width >= 600)
              const SizedBox(
                width: 30,
              ),
          ],
        );
      }),
    );
  }

  Widget createAccount() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(
            height: 20,
          ),
          const CustomTextView(
            text: "If you don't have any account?",
            textViewStyle: CustomTextViewStyle.large,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomMaterialButton(
            onPressed: () {
              Get.toNamed(Routes.signUp);
            },
            title: "Create Account".toUpperCase(),
            textColor: Colors.white,
            fontSize: 16,
            //fontWeight: FontWeight.bold,
            backgroundColor: primaryColor,
            //borderColor: primaryColor,
          )
        ],
      );
}
