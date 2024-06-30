import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.transparent),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 5))
                  ]),
              child: Form(
                // key: bloc.formKey,
                child: Column(
                  children: [
                    Text(
                      "Enter your email address and your password will be reset and emailed to you.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "Email Address",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        )),
                    TextFormField(
                      // controller: bloc.nameCtr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: "Enter your email",
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            onPressed: () {
                              // Utils.closeKeyBoard(context);
                              // bloc.updateAccInfo();
                            },
                            child: const Text(
                              "Send",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w400),
                            ),
                          )
                      ),
                    ),

                    RichText(
                      text: TextSpan(
                        text: "Send me back to the ",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18),
                        children: <TextSpan>[
                          const TextSpan(text: " "),
                          TextSpan(
                              text: "Sign In ",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: 18,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                // Get.toNamed(Routes.signIn);
                                Get.back();
                              }
                          ),
                          TextSpan(
                              text: "screen ",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
