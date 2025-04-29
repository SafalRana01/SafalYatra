import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';

class LoginPageController extends GetxController {
  var role = Get.arguments['role'];
  var response;
  var url;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordObscured = true;

  // Method to toggle password visibility

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    update();
  }

  void logIn() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        if (role == "user") {
          url = Uri.http(ipAddress, 'SafalYatra/auth/login.php');
        } else if (role == "operator") {
          url = Uri.http(ipAddress, 'SafalYatra/auth/loginCarOperator.php');
        } else if (role == "driver") {
          url = Uri.http(ipAddress, 'SafalYatra/auth/loginDriver.php');
        } else if (role == "admin") {
          url = Uri.http(ipAddress, 'SafalYatra/auth/loginAdmin.php');
        } else {
          Get.snackbar("Error", "Failed to login",
              backgroundColor: Colors.red, colorText: Colors.white);
        }

        response = await http.post(url, body: {
          'email': emailController.text,
          'password': passwordController.text
        });

        var result = jsonDecode(response.body);
        if (result['success']) {
          Memory.saveToken(result['token']);
          Memory.saveRole(result['role']);
          if (result['role'] == "user") {
            Get.offAllNamed(Routes.MAIN_SCREEN);
          } else if (result['role'] == "operator") {
            Get.offAllNamed(Routes.OPERATOR_MAIN);
          } else if (result['role'] == "driver") {
            Get.offAllNamed(Routes.DRIVER_MAIN);
          } else if (result['role'] == "admin") {
            Get.offAllNamed(Routes.ADMIN_MAIN);
          } else {
            Get.snackbar("Error", "Failed to go to main screen",
                backgroundColor: Colors.red, colorText: Colors.white);
          }

          Get.snackbar("Login", result['message'],
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar("Login", result['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }

        // Perform sign up logic here
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to login user",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
