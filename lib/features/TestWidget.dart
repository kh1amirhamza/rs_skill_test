import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs_skill_test/features/customer_suplier/controllers/customer_supplier_controller.dart';

import '../global/presentation/components/custom_dropdown_button.dart';
import '../global/presentation/components/custom_image_view.dart';
import '../global/presentation/components/custom_material_button.dart';
import '../global/presentation/components/custom_texfield.dart';
import '../global/services/functions.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {

  GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  GlobalKey<FormState> name2Key = GlobalKey<FormState>();
  GlobalKey<FormState> phoneKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> addressKey = GlobalKey<FormState>();
  GlobalKey<FormState> areaKey = GlobalKey<FormState>();
  GlobalKey<FormState> cityKey = GlobalKey<FormState>();
  GlobalKey<FormState> city2Key = GlobalKey<FormState>();
  GlobalKey<FormState> stateKey = GlobalKey<FormState>();
  GlobalKey<FormState> postCodeKey = GlobalKey<FormState>();
  GlobalKey<FormState> userTypeKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerSupplierController>(
        init: Get.find<CustomerSupplierController>(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(controller.isUpdate
                  ? 'Update Customer/Supplier'
                  : 'Create Customer/Supplier'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    CustomTextField(
                      label: "Name",
                      isRequired: true,
                      labelTextSize: 14,
                      controller: controller.nameController,
                      formKey: nameKey,
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    ),


                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      label: "Phone Number",
                      isRequired: true,
                      labelTextSize: 14,
                      controller: controller.phoneController,
                      formKey: phoneKey,
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    CustomDropDownButton(
                      labelTextSize: 14,
                      label: "Who is the person?",
                      //style: Style.circular,
                      formKey: userTypeKey,
                      initialSelectedValue: controller.userType,
                      dropDownMenuItems: const [
                        DropdownMenuItem(value: 0, child: Text('Customer')),
                        DropdownMenuItem(value: 1, child: Text('Supplier')),
                      ],
                      onChange: (int? newValue) {
                        controller.userType = newValue!;
                        controller.update();
                      },
                      isRequired: true,
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    if (!controller.isUpdate)
                      Row(
                        children: [
                          Expanded(
                            child: CustomMaterialButton(
                              backgroundColor: Colors.white,
                              // borderColor: Colors.grey,
                              fontWeight: FontWeight.bold,
                              alignment: MainAxisAlignment.spaceBetween,
                              textColor: Colors.grey.shade700,
                              onPressed: () {
                                controller.showOptionals =
                                !controller.showOptionals;
                                controller.update();
                              },
                              title: "- Add Address & Details (Optional)",

                              suffixWidget: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(controller.showOptionals
                                    ? Icons.arrow_drop_up_outlined
                                    : Icons.arrow_drop_down_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),

                    Visibility(
                      visible: true,//controller.showOptionals,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: const SizedBox(
                              height: 10,
                            ),
                          ),

                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: CustomTextField(
                              label: "Email Address",
                              labelTextSize: 14,
                              controller: controller.emailController,
                              formKey: emailKey,
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: const SizedBox(
                              height: 10,
                            ),
                          ),
                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: CustomTextField(
                              label: "Address",
                              labelTextSize: 14,
                              controller: controller.addressController,
                              formKey: addressKey,
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            ),
                          ),
                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: const SizedBox(
                              height: 10,
                            ),
                          ),
                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: CustomTextField(
                              label: "Area",
                              labelTextSize: 14,
                              controller: controller.areaController,
                              formKey: areaKey,
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            ),
                          ),
                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: const SizedBox(
                              height: 10,
                            ),
                          ),
                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: CustomTextField(
                              label: "Post Code",
                              labelTextSize: 14,
                              controller: controller.postCodeController,
                              formKey: postCodeKey,
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            ),
                          ),
                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: const SizedBox(
                              height: 10,
                            ),
                          ),
                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: CustomTextField(
                              label: "City",
                              labelTextSize: 14,
                              controller: controller.cityController,
                              formKey: cityKey,
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            ),
                          ),
                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: const SizedBox(
                              height: 10,
                            ),
                          ),
                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: CustomTextField(
                              label: "State",
                              isRequired: true,
                              labelTextSize: 14,
                              controller: controller.stateController,
                              formKey: stateKey,
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            ),
                          ),

                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: const SizedBox(
                              height: 10,
                            ),
                          ),

                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        chooseImage(context, (imagePath) {
                                          controller.selectedImageFilepPath = imagePath;
                                          controller.update();
                                        }),
                                    //controller.pickImage(),
                                    child: const Text('Pick Image'),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: const SizedBox(
                              height: 5,
                            ),
                          ),

                          Visibility(
                            visible: !controller.isUpdate && controller.showOptionals,
                            child: CustomImageView(
                              borderWidth: 0,
                              imageType:controller.selectedImageFilepPath != null
                                  ? CustomImageType.file
                                  : CustomImageType.network,
                              imageData: controller.selectedImageFilepPath ??
                                  "https://www.example.com/example.jpg",
                              placeHolderType: PlaceHolderType.person,
                              isOval: true,
                              filterQuality: FilterQuality.high,
                              boxFit: BoxFit.cover,
                              height: 110,
                              width: 110,
                            ),
                          ),
                          // ,
                          // Image.file(controller.selectedImage!),
                        ],
                      ),
                    ),


                    // controller.selectedImageFilepPath == null
                    //     ? const Text('No image selected.')
                    //     : CustomImageView(
                    //   borderWidth: 0,
                    //   imageType:controller.selectedImageFilepPath != null
                    //       ? CustomImageType.file
                    //       : CustomImageType.network,
                    //   imageData: controller.selectedImageFilepPath ??
                    //       "https://www.example.com/example.jpg",
                    //   placeHolderType: PlaceHolderType.person,
                    //   isOval: true,
                    //   filterQuality: FilterQuality.high,
                    //   boxFit: BoxFit.cover,
                    //   height: 110,
                    //   width: 110,
                    // ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (
                              //   name2Key.currentState!.validate() &&
                              nameKey.currentState!.validate() &&
                                  phoneKey.currentState!.validate() &&
                                  userTypeKey.currentState!.validate()) {
                                controller.isUpdate
                                    ? controller.updateCustomerSupplier()
                                    : controller.createCustomerSupplier();
                              }
                            },
                            child: Text(controller.isUpdate ? 'Update' : 'Submit'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
