import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;

class ChangePasswordController extends GetxController {
  var formKey = GlobalKey<FormState>();

  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isOldPasswordObscured = true;
  var isNewPasswordObscured = true;
  var isConfirmPasswordObscured = true;

  // Method to toggle password visibility
  void toggleOldPasswordVisibility() {
    isOldPasswordObscured = !isOldPasswordObscured;
    update();
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordObscured = !isNewPasswordObscured;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    update();
  }

  void onChangePassword() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        var url = Uri.http(ipAddress, 'SafalYatra/auth/changePassword.php');
        var response = await http.post(url, body: {
          'old_password': oldPasswordController.text,
          'new_password': newPasswordController.text,
          'confirm_password': confirmPasswordController.text,
          'token': Memory.getToken(),
          'role': Memory.getRole()
        });

        var result = jsonDecode(response.body);
        if (result['success']) {
          Get.back();
          Get.snackbar("Password", result['message'],
              backgroundColor: Colors.green, colorText: Colors.white);
          oldPasswordController.clear();
          newPasswordController.clear();
          confirmPasswordController.clear();
        } else {
          Get.snackbar("Password", result['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }

        // Perform sign up logic here
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to register user",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
