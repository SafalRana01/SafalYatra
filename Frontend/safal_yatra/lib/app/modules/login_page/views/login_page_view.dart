import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/custom_button.dart';

import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginPageController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.buttonColor,
          automaticallyImplyLeading: false,
          toolbarHeight: 40,
          title: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
              key: controller.formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Lottie.asset(
                          'lib/assets/animation/loginscreen.json',
                          // height: 300,
                          // width: 300
                          // fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Text(
                            'Welcome,',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            'Sign in to continue!',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.emailController,
                              textInputAction: TextInputAction.next,
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
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.mail,
                                  ),
                                  hintText: 'Email Address',
                                  labelText: 'Email Address',
                                  labelStyle: const TextStyle(fontSize: 16)),
                              validator: (Value) {
                                if (Value == null || Value.isEmpty) {
                                  return "Please enter email";
                                } else if (!GetUtils.isEmail(Value)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              obscureText: controller.isPasswordObscured,
                              controller: controller.passwordController,
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
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey,
                                    ),
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
                                  labelStyle: const TextStyle(
                                    fontSize: 16,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter password";
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
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.FORGOT_PASSWORD,
                                arguments: {'role': controller.role});
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: AppColors.buttonColor,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        title: "Login",
                        onTap: controller.logIn,
                      ),
                      const SizedBox(height: 10),
                      if (controller.role == "user" ||
                          controller.role == "operator")
                        Visibility(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Inter'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.SIGNUP_PAGE,
                                      arguments: {'role': controller.role});
                                },
                                child: const Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                      color: AppColors.buttonColor,
                                      fontSize: 18,
                                      fontFamily: 'Inter '),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
