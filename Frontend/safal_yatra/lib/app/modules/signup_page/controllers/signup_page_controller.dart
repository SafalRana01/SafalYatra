import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/utils/constant.dart';

class SignupPageController extends GetxController {
  var role = Get.arguments['role'];
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final registrationController = TextEditingController();
  final emailControllers = TextEditingController();
  final addressControllers = TextEditingController();
  final passwordControllers = TextEditingController();
  final rePasswordController = TextEditingController();
  final signUpKey = GlobalKey<FormState>();

  var response;
  var url;

  var isPasswordObscured = true;
  var isConfirmPasswordObscured = true;
  var isLoading = false.obs;

  // Gender selection variable
  var selectedGender = ''.obs;

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    update();
  }

  void selectGender(String value) {
    selectedGender.value = value;
    update();
    print(value);
  }

  void signUp() async {
    try {
      if (signUpKey.currentState?.validate() ?? false) {
        isLoading.value = true;

        if (role == "user") {
          url = Uri.http(ipAddress, 'SafalYatra/auth/register.php');
        } else if (role == "operator") {
          url = Uri.http(ipAddress, 'SafalYatra/auth/registerCarOperator.php');
        } else {
          Get.snackbar("Error", "Failed to register",
              backgroundColor: Colors.red, colorText: Colors.white);
        }

        response = await http.post(url, body: {
          'fullName': nameController.text,
          'name': nameController.text,
          'phone': phoneController.text,
          'email': emailControllers.text,
          'password': passwordControllers.text,
          'address': addressControllers.text,
          'registration_number': registrationController.text,
          'location': addressControllers.text,
          'gender': selectedGender.value, // Include gender in the request
        });

        var result = jsonDecode(response.body);
        print(result);
        if (result['success']) {
          String role = result['role'];
          String activationCode = result['activation_code'];
          String email = result['email'];

          Get.toNamed(Routes.OTP_VALIDATE, arguments: {
            'activation_code': activationCode,
            'role': role,
            'email': email
          });

          Get.snackbar("Registration", result['message'],
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar("Registration", result['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to register user",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
