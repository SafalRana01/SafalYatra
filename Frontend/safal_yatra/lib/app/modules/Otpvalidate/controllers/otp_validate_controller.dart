import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/utils/constant.dart';

class OtpValidateController extends GetxController {
  var role = Get.arguments['role'];
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  Map<String, dynamic>? code; // Define 'code' to hold arguments

  @override
  void onInit() {
    errorController = StreamController<ErrorAnimationType>();
    super.onInit();
    code = Get.arguments
        as Map<String, dynamic>?; // Assign the arguments to 'code'
    print(code);
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

        var url;
        if (code?['role'] == "operator") {
          url = Uri.http(
              ipAddress, 'SafalYatra/OTP/verifyCarOperatorRegister.php');
        } else {
          url = Uri.http(ipAddress, 'SafalYatra/OTP/verifyUserRegister.php');
        }
        var response = await http.post(url, body: {
          'otp': textEditingController.text,
          'code': code?['activation_code'],
        });

        var result = jsonDecode(response.body);
        print(response.body);
        if (result['success']) {
          Get.offAllNamed(Routes.LOGIN_PAGE,
              arguments: {'role': result['role']});

          Get.snackbar("Registration", result['message'],
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar("Registration", result['message'],
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
