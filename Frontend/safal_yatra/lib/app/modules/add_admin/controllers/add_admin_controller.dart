// Importing necessary packages and modules
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/app/modules/all_admins/controllers/all_admins_controller.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';

// Controller class to manage Add Admin functionality using GetX
class AddAdminController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailControllers = TextEditingController();
  final passwordControllers = TextEditingController();
  final rePasswordController = TextEditingController();

  final addAdminKey = GlobalKey<FormState>(); // Key to manage form validation

// Variables to handle password visibility toggling
  var isPasswordObscured = true;
  var isConfirmPasswordObscured = true;

// Reactive variable to handle loading state
  var isLoading = false.obs;

  // Method to toggle main password field visibility
  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    update();
  }

// Method to toggle confirm password field visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    update();
  }

// Method to handle adding a new admin
  void onAddAdmin() async {
    try {
      // Validate the form before making the API call
      if (addAdminKey.currentState?.validate() ?? false) {
        // Creating the URI for the registerAdmin API
        var url = Uri.http(ipAddress, 'SafalYatra/auth/registerAdmin.php');

        // Making a POST request with admin details
        var response = await http.post(url, body: {
          'token': Memory.getToken(),
          'fullName': nameController.text,
          'phone': phoneController.text,
          'email': emailControllers.text,
          'password': passwordControllers.text,
        });

// Decoding the response from the server
        var result = jsonDecode(response.body);

        if (result['success']) {
          // If admin was added successfully, go back and refresh the list
          Get.back(); // Close the current screen
          Get.find<AllAdminsController>().getAdmins(); // Refresh admin list

          // Show success message
          Get.snackbar("Admin", result['message'],
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          // Show error message from API response
          Get.snackbar("Admin", result['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
      // Catch and show error message if request fails
    } catch (e) {
      Get.snackbar("Error", "Failed to add admin",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
