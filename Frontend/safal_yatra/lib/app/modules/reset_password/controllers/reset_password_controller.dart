import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'dart:convert';

import 'package:safal_yatra/utils/constant.dart';

class ResetPasswordController extends GetxController {
  var formKey = GlobalKey<FormState>();

  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isNewPasswordObscured = true;
  var isConfirmPasswordObscured = true;

  // Method to toggle password visibility

  void toggleNewPasswordVisibility() {
    isNewPasswordObscured = !isNewPasswordObscured;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    update();
  }

  Map<String, dynamic>? userDetail;

  @override
  void onInit() {
    super.onInit();
    userDetail = Get.arguments
        as Map<String, dynamic>?; // Assign the arguments to 'userDetail'
    print(userDetail?['email']);
  }

  void onResetPassword() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        var url = Uri.http(ipAddress, 'SafalYatra/auth/resetPassword.php');
        var response = await http.post(url, body: {
          'email': userDetail?['email'],
          'password': newPasswordController.text,
          'role': userDetail?['role'],
        });

        var result = jsonDecode(response.body);
        if (result['success']) {
          Get.offAllNamed(Routes.LOGIN_PAGE,
              arguments: {'role': result['role']});

          Get.snackbar("Password", result['message'],
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar("Password", result['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }

        // Perform sign up logic here
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to reset password",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
