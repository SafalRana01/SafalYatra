import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/custom_button.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2FA),
      appBar: AppBar(
        toolbarHeight: 90,
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
                  size: 30,
                ),
              ),
              const Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(width: 40),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: Get.height * 0.7,
          ),
          child: GetBuilder<ChangePasswordController>(
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: Padding(
                  padding: EdgeInsets.all(
                    Get.width / 25,
                  ),
                  child: Column(
                    children: [
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          AppColors
                              .backGroundColor, // Set the desired color for filtering
                          BlendMode.darken,
                        ),
                        child: Image.asset(
                          'lib/assets/images/reset_password.jpg',
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Your password must be at least 8 characters and should include a combination of numbers, letters (uppercase and lowercase), and special characters (!&@%).',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter current password';
                                }
                                return null;
                              },
                              obscureText: controller.isOldPasswordObscured,
                              controller: controller.oldPasswordController,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14.0,
                                  horizontal: Get.width / 30,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.buttonColor,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(controller.isOldPasswordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    controller.toggleOldPasswordVisibility();
                                  },
                                ),
                                hintText: 'Current Password',
                                labelText: 'Current Password',
                                labelStyle: TextStyle(fontSize: 18),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              obscureText: controller.isNewPasswordObscured,
                              controller: controller.newPasswordController,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: Get.width / 30,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    // Set the focused border here
                                    borderSide: BorderSide(
                                      color: AppColors
                                          .buttonColor, // Set the desired focus color here
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(controller.isNewPasswordObscured
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      controller.toggleNewPasswordVisibility();
                                    },
                                  ),
                                  hintText: 'New Password',
                                  labelText: 'New Password',
                                  labelStyle: TextStyle(fontSize: 18)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter current password';
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
                                if (!value.contains(RegExp(
                                    r'[!@#$%^&*()_+{}\[\]:;<>,.\/?~-]'))) {
                                  return 'Password must contain at least one symbol';
                                }

                                // If all requirements are met, return null (no error)
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              obscureText: controller.isConfirmPasswordObscured,
                              controller: controller.confirmPasswordController,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: Get.width / 30,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    // Set the focused border here
                                    borderSide: BorderSide(
                                      color: AppColors
                                          .buttonColor, // Set the desired focus color here
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        controller.isConfirmPasswordObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                    onPressed: () {
                                      controller
                                          .toggleConfirmPasswordVisibility();
                                    },
                                  ),
                                  hintText: 'Confirm Password',
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(fontSize: 18)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter confirm password";
                                } else if (value !=
                                    controller.newPasswordController.text) {
                                  return "Passwords do not match";
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      persistentFooterButtons: [
        CustomButton(
            title: 'Change Password',
            onTap: () {
              controller.onChangePassword();
            })
      ],
    );
  }
}
