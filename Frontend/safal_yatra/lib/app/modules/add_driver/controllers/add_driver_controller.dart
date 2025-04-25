import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:safal_yatra/app/modules/operator_drivers/controllers/operator_drivers_controller.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';

// Creating the AddDriverController to handle adding a new driver
class AddDriverController extends GetxController {
  // Defining controllers for each input field
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailControllers = TextEditingController();
  final passwordControllers = TextEditingController();
  final rePasswordController = TextEditingController();
  final licenseControllers = TextEditingController();
  final ageController = TextEditingController();
  final experienceController = TextEditingController();

  final addDriverKey = GlobalKey<FormState>(); // Form key for validation

// Boolean flags for password visibility toggling
  var isPasswordObscured = true;
  var isConfirmPasswordObscured = true;

  // Gender selection variable
  var selectedGender = ''.obs;

  var isLoading = false.obs; // To track loading state

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured; // Toggling the visibility
    update(); // Updating the UI
  }

// Method for toggling confirm password visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured =
        !isConfirmPasswordObscured; // Toggling the visibility
    update(); // Updating the UI
  }

// Method to set the selected gender
  void selectGender(String value) {
    selectedGender.value = value; // Storing the selected gender
    update(); // Updating the UI
    print(value); // Logging the selected gender for debugging
  }

// Method to handle adding a driver by sending form data to the backend
  void onAddDriver() async {
    try {
      // Validating the form before proceeding
      if (addDriverKey.currentState?.validate() ?? false) {
        var url = Uri.http(ipAddress, 'SafalYatra/carOperator/addDriver.php');
        // Validating the form before proceeding
        var response = await http.post(url, body: {
          'token': Memory.getToken(),
          'driver_name': nameController.text,
          'contact_number': phoneController.text,
          'email': emailControllers.text,
          'password': passwordControllers.text,
          'license_number': licenseControllers.text,
          'age': ageController.text,
          'experience': experienceController.text,
          'gender': selectedGender.value,
        });

// Decoding the response to check success or failure
        var result = jsonDecode(response.body);
        print(response.body);

        // If the driver is added successfully
        if (result['success']) {
          Get.back(); // Going back to the previous screen

// Refreshing the list of drivers by calling the showMyDrivers method
          Get.find<OperatorDriversController>().showMyDrivers();
          Get.snackbar(
              "Driver", result['message'], // Displaying a success message
              backgroundColor: Colors.green,
              colorText: Colors.white);
        } else {
          Get.snackbar("Driver", result['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    } catch (e) {
      // Handling unexpected errors during the request
      Get.snackbar("Error", "Failed to add driver",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
