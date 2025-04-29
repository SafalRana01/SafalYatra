import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/utils/constant.dart';

import 'package:http/http.dart' as http;

class ForgetOtpValidateController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  Map<String, dynamic>? userDetail;

  @override
  void onInit() {
    errorController = StreamController<ErrorAnimationType>();
    super.onInit();
    userDetail = Get.arguments
        as Map<String, dynamic>?; // Assign the arguments to 'userDetail'
  }

  @override
  void onClose() {
    errorController?.close();
    super.onClose();
  }

  var isLoading = false.obs;

  void onVerifyOTP() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        isLoading.value = true;
        var url = Uri.http(ipAddress, 'SafalYatra/OTP/verifyOTP.php');
        var response = await http.post(url, body: {
          'otp': textEditingController.text,
          'email': userDetail?['email'],
          'role': userDetail?['role'],
        });

        var result = jsonDecode(response.body);
        if (result['success']) {
          var role = result['role'];
          Get.toNamed(
            Routes.RESET_PASSWORD,
            arguments: {'email': userDetail?['email'], 'role': role},
          );
          Get.snackbar("OTP", result['message'],
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar("OTP", result['message'],
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
