import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/custom_button.dart';

import '../controllers/signup_page_controller.dart';

class SignupPageView extends GetView<SignupPageController> {
  const SignupPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<SignupPageController>(
        builder: (controller) {
          return Form(
            key: controller.signUpKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: Get.height * 0.8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Color.fromARGB(178, 0, 0, 0),
                              fontSize: 40,
                              fontFamily:
                                  'Agbalumo', // Specify the Changa One font
                            ),
                            children: [
                              TextSpan(
                                text: 'Safal',
                              ),
                              TextSpan(
                                text: 'Yatra',
                                style: TextStyle(
                                  color: AppColors.buttonColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        const Row(
                          children: [
                            Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
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
                                        const BorderSide(color: Colors.yellow),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: controller.role == "user"
                                      ? 'Full Name'
                                      : 'Company Name',
                                  labelText: controller.role == "user"
                                      ? 'Full Name'
                                      : 'Company Name',
                                  suffixIcon:
                                      const Icon(Icons.person, size: 30),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return controller.role == "user"
                                        ? "Please enter full name"
                                        : "Please enter company name";
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                          ],
                        ),

                        controller.role == "operator"
                            ? const SizedBox(height: 25)
                            : const SizedBox(height: 0),
                        if (controller.role == "operator")
                          Visibility(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        controller.registrationController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 14.0,
                                        horizontal: Get.width / 30,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.1),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.yellow),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: 'Company PAN Number',
                                      labelText: 'Company PAN Number',
                                      suffixIcon:
                                          const Icon(Icons.person, size: 30),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter company PAN number";
                                      } else {
                                        return null;
                                      }
                                    },
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.phoneController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: Get.width / 30,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.1),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Phone Number',
                                  labelText: 'Phone Number',
                                  suffixIcon: const Icon(Icons.phone,
                                      size: 30), // Add the phone icon as suffix
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter phone number";
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // Email input field
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.emailControllers,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: Get.width / 30,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.1),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Email',
                                  labelText: 'Email',
                                  suffixIcon: const Icon(Icons.email,
                                      size: 30), // Add the email icon as suffix
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter Email";
                                  } else if (!GetUtils.isEmail(value)) {
                                    return "Invalid email";
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                          ],
                        ),

                        controller.role == 'user'
                            ? const SizedBox(height: 05)
                            : const SizedBox(height: 25),

                        if (controller.role == 'user')
                          Visibility(
                            child: Row(
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
                                                      activeColor:
                                                          Color(0xFFF57C00),
                                                      onChanged: (value) {
                                                        if (value != null) {
                                                          controller
                                                              .selectGender(
                                                                  value);
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
                                                      activeColor:
                                                          Color(0xFFF57C00),
                                                      onChanged: (value) {
                                                        if (value != null) {
                                                          controller
                                                              .selectGender(
                                                                  value);
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
                                                      activeColor:
                                                          Color(0xFFF57C00),
                                                      onChanged: (value) {
                                                        if (value != null) {
                                                          controller
                                                              .selectGender(
                                                                  value);
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
                          ),

                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.addressControllers,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: Get.width / 30,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.1),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: controller.role == 'user'
                                      ? 'Address'
                                      : 'Company Location',
                                  labelText: controller.role == 'user'
                                      ? 'Address'
                                      : 'Company Location',
                                  suffixIcon: Icon(MdiIcons.mapMarkerOutline,
                                      size: 30), // Add the email icon as suffix
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return controller.role == 'user'
                                        ? "Please enter Address"
                                        : "Please enter comnpany location";
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // Password input field
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
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
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                obscureText:
                                    controller.isConfirmPasswordObscured,
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                          ],
                        ),
                        // Forgot Password link

                        const SizedBox(height: 45),

                        // Login button
                        Obx(() => CustomButton(
                              title: "Sign Up",
                              isLoading: controller.isLoading.value,
                              onTap: controller.signUp,
                            )),

                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                                onPressed: Get.back,
                                child: const Text(
                                  "LOG IN",
                                  style: TextStyle(
                                      color: AppColors.buttonColor,
                                      fontSize: 18),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        const SizedBox(height: 40),

                        // Login button
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
