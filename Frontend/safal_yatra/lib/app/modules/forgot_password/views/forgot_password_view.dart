import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/custom_button.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
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
                'Forgot Password',
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: Get.height * 0.8,
          ),
          child: Form(
            key: controller.emailForm,
            child: Padding(
              padding: EdgeInsets.all(
                Get.width / 20,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    // child: Lottie.asset(
                    //   'lib/assets/animation/forgot_password.json',
                    //   // fit: BoxFit.contain,
                    // ),
                    child: ColorFiltered(
            colorFilter: ColorFilter.mode(
            AppColors.backGroundColor, // Blend color
              BlendMode.multiply,          // Apply Multiply blend mode
            ),
            child: Image.asset(
              'lib/assets/images/forget_password.jpg',
              height: 250,
              width: 800,
              fit: BoxFit.cover, // Adjust fit as needed
            ),
          ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Center(
                    child: Text(
                      'Please Enter Your Email Address To \n         Receive a Verification Code',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!GetUtils.isEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          controller: controller.emailController,
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
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                // Define border color and thickness here
                                color: Colors.blue, // Set desired border color
                                width: 5.0, // Set desired border thickness
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.backGroundColor,
                              ),
                            ),
                            suffixIcon: Icon(
                              MdiIcons.emailOutline,
                              color: const Color.fromARGB(255, 63, 112, 198),
                            ),
                            hintText: 'Email Address',
                            labelText: 'Email Address',
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Obx(() => CustomButton(
                      isLoading: controller.isLoading.value,
                      title: 'Send',
                      onTap: () {
                        controller.onSendOTP();
                      }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}