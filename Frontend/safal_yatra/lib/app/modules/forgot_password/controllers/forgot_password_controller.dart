import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'dart:convert';

import 'package:safal_yatra/utils/constant.dart';

class ForgotPasswordController extends GetxController {
  var emailController = TextEditingController();
  var emailForm = GlobalKey<FormState>();
  var isLoading = false.obs;
  String? userType;

  @override
  void onInit() {
    super.onInit();
    userType = Get.arguments?['role']; // Extract "role" from arguments
    print(userType);
  }

  void onSendOTP() async {
    try {
      if (emailForm.currentState?.validate() ?? false) {
        isLoading.value = true;

        var url = Uri.http(ipAddress, 'SafalYatra/OTP/sendOTP.php');

        var response = await http
            .post(url, body: {'email': emailController.text, 'role': userType});

        var result = jsonDecode(response.body);
        if (result['success']) {
          String email = result['email'];
          String role = result['role'];
          Get.toNamed(Routes.FORGET_OTP_VALIDATE,
              arguments: {'email': email, 'role': role});
          Get.snackbar("Email", result['message'],
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar("Email", result['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }

        // Perform sign up logic here
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to send OTP",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
