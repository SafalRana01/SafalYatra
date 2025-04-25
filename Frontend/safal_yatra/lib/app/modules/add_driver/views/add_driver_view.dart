import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/custom_button.dart';

import '../controllers/add_driver_controller.dart';

class AddDriverView extends GetView<AddDriverController> {
  const AddDriverView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.buttonColor,
        automaticallyImplyLeading: false,
        title: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const Text(
                'Add Driver',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Inter",
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
      body: Form(
        key: controller.addDriverKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: Get.height * 0.9,
            ),
            child: GetBuilder<AddDriverController>(
              builder: (controller) {
                return Padding(
                  padding: EdgeInsets.all(
                    Get.width / 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Driver Details:',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: controller.nameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: Get.width / 30,
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Driver Name',
                          labelText: 'Driver Name',
                          suffixIcon: const Icon(Icons.person, size: 30),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter driver name";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(height: 25),

                      TextFormField(
                        controller: controller.phoneController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: Get.width / 30,
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Driver Phone Number',
                          labelText: ' Driver Phone Number',
                          suffixIcon: const Icon(Icons.phone,
                              size: 30), // Add the phone icon as suffix
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter driver phone number";
                          } else if (!value.isNum) {
                            return "Invalid phone number.";
                          } else if (value.length != 10) {
                            return "Please enter 10 digit number";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(height: 25),

                      TextFormField(
                        controller: controller.licenseControllers,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: Get.width / 30,
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'License Number',
                          labelText: 'License Number',
                          suffixIcon: Icon(MdiIcons.cardAccountDetailsOutline,
                              size: 33),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter driver license number";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(height: 25),

                      // Email input field

                      TextFormField(
                        controller: controller.emailControllers,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: Get.width / 30,
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Driver Email',
                          labelText: 'Driver Email',
                          suffixIcon: const Icon(Icons.email,
                              size: 30), // Add the email icon as suffix
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter driver email";
                          } else if (!GetUtils.isEmail(value)) {
                            return "Invalid email";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(height: 25),

                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width /
                                      45), // Adjust the left padding
                              child: Row(
                                children: [
                                  const Text(
                                    "Gender:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                    child: Obx(() {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Radio<String>(
                                                value: 'Male',
                                                groupValue: controller
                                                    .selectedGender.value,
                                                activeColor: Color(0xFFF57C00),
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    controller
                                                        .selectGender(value);
                                                  }
                                                },
                                              ),
                                              const Text('Male'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio<String>(
                                                value: 'Female',
                                                groupValue: controller
                                                    .selectedGender.value,
                                                activeColor: Color(0xFFF57C00),
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    controller
                                                        .selectGender(value);
                                                  }
                                                },
                                              ),
                                              const Text('Female'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio<String>(
                                                value: 'Other',
                                                groupValue: controller
                                                    .selectedGender.value,
                                                activeColor: Color(0xFFF57C00),
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    controller
                                                        .selectGender(value);
                                                  }
                                                },
                                              ),
                                              const Text('Other'),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      TextFormField(
                        controller: controller.ageController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: Get.width / 30,
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Driver Age',
                          labelText: ' Driver Age',
                          suffixIcon: const Icon(Icons.person,
                              size: 30), // Add the phone icon as suffix
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter driver age";
                          } else if (!value.isNum) {
                            return "Invalid age.";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(height: 25),

                      TextFormField(
                        controller: controller.experienceController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: Get.width / 30,
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Driver Experience',
                          labelText: ' Driver Experience',
                          suffixIcon: Icon(MdiIcons.certificateOutline,
                              size: 30), // Add the phone icon as suffix
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter driver experience";
                          } else if (!value.isNum) {
                            return "Invalid experience.";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(height: 25),

                      // Password input field
                      TextFormField(
                        obscureText: controller.isPasswordObscured,
                        controller: controller.passwordControllers,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: Get.width / 30,
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(controller.isPasswordObscured
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              controller.togglePasswordVisibility();
                            },
                          ),
                          hintText: 'Password',
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }

                          // Check if password is at least 8 characters long
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }

                          // Check if password contains at least one uppercase letter
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'Password must contain at least one uppercase letter';
                          }

                          // Check if password contains at least one lowercase letter
                          if (!value.contains(RegExp(r'[a-z]'))) {
                            return 'Password must contain at least one lowercase letter';
                          }

                          // Check if password contains at least one digit
                          if (!value.contains(RegExp(r'[0-9]'))) {
                            return 'Password must contain at least one digit';
                          }

                          // Check if password contains at least one symbol
                          if (!value.contains(
                              RegExp(r'[!@#$%^&*()_+{}\[\]:;<>,.\/?~-]'))) {
                            return 'Password must contain at least one symbol';
                          }

                          // If all requirements are met, return null (no error)
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        obscureText: controller.isConfirmPasswordObscured,
                        controller: controller.rePasswordController,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: Get.width / 30,
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(controller.isConfirmPasswordObscured
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              controller.toggleConfirmPasswordVisibility();
                            },
                          ),
                          hintText: 'Confirm Password',
                          labelText: 'Confirm Password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter confirm password";
                          } else if (value !=
                              controller.passwordControllers.text) {
                            return "Passwords do not match";
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        CustomButton(title: 'Add Driver', onTap: controller.onAddDriver)
      ],
    );
  }
}
