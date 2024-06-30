import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../global/presentation/components/custom_image_view.dart';
import '../../../../global/presentation/components/custom_material_button.dart';
import '../../../../global/presentation/components/custom_texfield.dart';
import '../../../../global/presentation/components/custom_text_view.dart';
import '../../controllers/sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneNumberKey = GlobalKey<FormState>();
    final emailKey = GlobalKey<FormState>();
    final nameKey = GlobalKey<FormState>();
    final businessNameKey = GlobalKey<FormState>();



    return Scaffold(
      appBar: AppBar(title: const Text("Registration")),
      body: GetBuilder<SignUpController>(builder: (controller) {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(30, 0
                        , 30, 10),
                    padding: const EdgeInsets.fromLTRB(10, 0
                        , 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: CustomImageView(
                            imageType: CustomImageType.assets,
                            imageData: "assets/images/signup.png",
                            height: 150,
                            width: 150,
                            borderWidth: 0,
                          ),
                        ),
                        // if (Get.width < 600)
                        //   const SizedBox(
                        //     height: 20,
                        //   ),

                        CustomTextField(
                          label: "Name",
                          labelTextSize: 14,
                          labelColor: lightTextColor,
                          isRequired: true,
                          formKey: nameKey,
                          controller: controller.nameController,
                          style: Style.circular,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        CustomTextField(
                          label: "Business Name",
                          labelTextSize: 14,
                          labelColor: lightTextColor,
                          isRequired: true,
                          formKey: businessNameKey,
                          controller: controller.businessNameController,
                          style: Style.circular,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        CustomTextField(
                          label: "Email",
                          labelTextSize: 14,
                          labelColor: lightTextColor,
                          isRequired: true,
                          formKey: emailKey,
                          keyboardType: TextInputType.emailAddress,
                          controller: controller.emailController,
                          //style: Style.circular,
                          errorMessage: "Enter valid email address!",
                          style: Style.circular,
                        ),

                        const SizedBox(
                          height: 7,
                        ),
                        CustomTextField(
                          label: "Mobile no.",
                          //padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                          labelTextSize: 14,
                          labelColor: lightTextColor,
                          isRequired: true,
                          formKey: phoneNumberKey,
                          // paddingBetweenIconAndContent: 0,
                          keyboardType: TextInputType.phone,
                          maxLength: 11,
                          style: Style.circular,
                          controller: controller.phoneNumberController,
                          //style: Style.circular,
                          prefixIcon: CountryCodePicker(
                            onChanged: print,
                            initialSelection: 'BD',
                            builder: (CountryCode? c) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    c!.flagUri!,
                                    package: 'country_code_picker',
                                    width: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    size: 20,
                                  )
                                ],
                              );
                            },
                          ),
                          hint: "Your number",
                        ),
                        const SizedBox(
                          height: 30,
                        ),


                        CustomMaterialButton(
                          width: double.maxFinite,
                          borderRadius: 35,
                          padding: const EdgeInsets.fromLTRB(10,5,10,5),
                          onPressed: () {

                            //controller.showVerificationDialog(2);
                            if (
                            nameKey.currentState!.validate() &&
                            businessNameKey.currentState!.validate() &&
                                emailKey.currentState!.validate() &&
                                phoneNumberKey.currentState!.validate()) {
                              controller.signUp();
                            }
                          },
                          title: "Submit",
                          textColor: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          backgroundColor: primaryColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        forgerAndCreateAccount(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
              ),
            ),


          ],
        );
      }),
    );
  }

  Widget forgerAndCreateAccount() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomTextView(
              text: "Do you have any account?",
              textViewStyle: CustomTextViewStyle.large,
              textAlign: TextAlign.center,
            ),
            CustomTextView(
              text: "Login in your account.",
              textViewStyle: CustomTextViewStyle.medium,
              textColor: Colors.grey.shade700,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomMaterialButton(
              onPressed: () {
                Get.toNamed(Routes.signIn);
              },
              title: "Log In Now".toUpperCase(),
              textColor: Colors.white,
              fontSize: 16,
              //fontWeight: FontWeight.bold,
              backgroundColor: primaryColor,
              //borderColor: primaryColor,
              borderRadius: 35,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );
}
// DropdownButtonFormField<String>(
// isExpanded: true,
// decoration: const InputDecoration(
// hintText: "Select Role",
// focusedBorder: OutlineInputBorder(
// borderSide: BorderSide(color: Colors.grey)),
// enabledBorder: OutlineInputBorder(
// borderSide: BorderSide(color: Colors.grey)),
// errorBorder: OutlineInputBorder(
// borderSide: BorderSide(color: Colors.red)),
// focusedErrorBorder: OutlineInputBorder(
// borderSide: BorderSide(color: Colors.red)),
// contentPadding: EdgeInsets.all(10),
// ),
// // value: postAdBloc.subCategory,
// items: ["Owner", "Prospect", "Agent/Professional"]
//     .map<DropdownMenuItem<String>>((e) {
// return DropdownMenuItem<String>(
// value: e,
// child: Text(e),
// );
// }).toList(),
// onChanged: (String? value) {},
// ),
