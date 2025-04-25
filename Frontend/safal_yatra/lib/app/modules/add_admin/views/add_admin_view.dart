import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/custom_button.dart';

import '../controllers/add_admin_controller.dart';

class AddAdminView extends GetView<AddAdminController> {
  const AddAdminView({Key? key}) : super(key: key);
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
                'Add Admin',
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
        key: controller.addAdminKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: Get.height * 0.7,
            ),
            child: GetBuilder<AddAdminController>(
              builder: (controller) {
                return Padding(
                  padding: EdgeInsets.all(
                    Get.width / 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          AppColors
                              .backGroundColor, // Set the desired color for filtering
                          BlendMode.darken,
                        ),
                        child: Image.asset(
                          'lib/assets/images/addAdmin.png',
                          height: 260,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          'Enter Admin Details:',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: controller.nameController,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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
                          hintText: 'Admin Name',
                          labelText: 'Admin Name',
                          suffixIcon: const Icon(Icons.person, size: 30),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter admin name";
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
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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
                          hintText: 'Contact Number',
                          labelText: 'Contact Number',
                          suffixIcon: const Icon(Icons.phone,
                              size: 30), // Add the phone icon as suffix
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter admin contact number";
                          } else if (!value.isNum) {
                            return "Invalid phone number.";
                          } else if (value.length != 10) {
                            return "Please enter 10 digit number";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(height: 25),

                      TextFormField(
                        controller: controller.emailControllers,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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
                          hintText: 'Admin Email',
                          labelText: 'Admin Email',
                          suffixIcon: const Icon(Icons.email,
                              size: 30), // Add the email icon as suffix
                        ),
                        // Add email validation
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter admin email";
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
                        // Add password validation
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
                            // Toggle password visibility
                            onPressed: () {
                              controller.toggleConfirmPasswordVisibility();
                            },
                          ),
                          hintText: 'Confirm Password',
                          labelText: 'Confirm Password',
                        ),
                        // Check if password and confirm password match
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
      // button for adding admin
      persistentFooterButtons: [
        CustomButton(title: 'Add Admin', onTap: controller.onAddAdmin)
      ],
    );
  }
}
