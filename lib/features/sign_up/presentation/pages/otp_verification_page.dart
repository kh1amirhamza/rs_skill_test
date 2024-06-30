import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../global/presentation/components/custom_material_button.dart';
import '../../../../global/presentation/components/custom_text_view.dart';
import '../../controllers/sign_up_controller.dart';
import '../../data/repositories/sign_up_repository.dart';

class OtpVerificationPage extends StatelessWidget {
  // final String? otp;
  final String? email;
  final String? phone;
  final String? countryCode;
  OtpVerificationPage(
      {super.key, /*this.otp, */ this.email, this.phone, this.countryCode});

  SignUpController data = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Verify OTP"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
        padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(-1, -1), color: Colors.grey.shade300),
              BoxShadow(offset: const Offset(1, 2), color: Colors.grey.shade300)
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextView(
                  maxLines: 2,
                  text: "We've sent a 4-digit OTP in ${phone}",
                  textAlign: TextAlign.center,
                  textColor: Colors.grey.shade700,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // OtpTextField(
            //   numberOfFields: 4,
            //   handleControllers: (controllers) {
            //
            //   },
            //
            //   borderColor: Color(0xFF512DA8),
            //   showFieldAsBox: true,
            //   onCodeChanged: (String code) {},
            //   onSubmit: (String verificationCode) {}, // end onSubmit
            // ),

            Directionality(
              // Specify direction if desired
              textDirection: TextDirection.ltr,
              child: Pinput(
                controller: data.otpController,
                // focusNode: focusNode,
                // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                // listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                // validator: (value) {
                //   return value == '$otp'
                //       ? null : 'Invalid OTP';
                // },
                // onClipboardFound: (value) {
                //   debugPrint('onClipboardFound: $value');
                //   pinController.setText(value);
                // },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  // print('onCompleted: $pin');
                  // if(_formKey.currentState!.validate()){
                  //   setState(() {
                  //     isLoading = true;
                  //   });
                  //   widget.from=="verify_login"?fetchLoginDetails(context, widget.phone, widget.otp):
                  //   verifyCheckout(context, widget.orderId, widget.phone, widget.otp);
                  // }
                },
                onChanged: (value) {
                  print('onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomMaterialButton(
                    onPressed: () async {
                      if (data.otpController.text.isEmpty) {
                        Get.snackbar("Error", "Invalid OTP");
                      } else {
                        EasyLoading.show();
                        var value =
                            await SignUpRepository().verifyOtp({
                          "email": email,
                          "country_code": countryCode,
                          "mobile": phone,
                          "otp_num": data.otpController.text.trim(),
                        });
                        if (value != null) {
                          GetStorage().remove(signUpRes);
                          GetStorage().write(signUpRes, value.toJson());
                          GetStorage().write(accessToken, value.apiToken);
                          Get.offNamedUntil(Routes.mainPage, (route) => false);
                          Get.snackbar("Success", "${value}");
                          Get.offNamedUntil(Routes.mainPage, (route) => false);
                        }
                      }
                    },
                    title: "Enter".toUpperCase(),
                    textColor: Colors.white,
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                    backgroundColor: primaryColor,
                    borderRadius: 5,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 2,
                  child: CustomMaterialButton(
                    onPressed: () async {
                      EasyLoading.show();
                      await SignUpRepository().resendOtp({
                        "email": email,
                        "country_code": countryCode,
                        "mobile": phone,
                      }).then((value) {
                        if (value != null) {
                          Get.snackbar("Success", "${value}");
                          data.otpController.text = "";
                        }
                      });
                    },
                    title: "Request PIN again".toUpperCase(),
                    //textColor: Colors.white,
                    fontSize: 16,
                    borderRadius: 5,
                    //fontWeight: FontWeight.bold,
                    // backgroundColor: primaryColor,
                    //borderColor: primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
