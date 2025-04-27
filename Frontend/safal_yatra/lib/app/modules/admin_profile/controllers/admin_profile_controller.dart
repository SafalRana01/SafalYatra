// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getAdminProfile.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;

// Controller class to manage admin profile
class AdminProfileController extends GetxController {
  AdminProfileResponse?
      adminProfileResponse; // Declaring a variable to hold admin profile response

  // Method to initialize the controller
  @override
  void onInit() {
    super.onInit();
    getMyProfile(); // Fetching admin profile when controller initializes
  }

  // Method to fetch admin profile
  Future<void> getMyProfile() async {
    try {
      // Creating request to fetch admin profile
      var url = Uri.http(ipAddress, 'SafalYatra/admin/getAdminProfile.php');
      await Future.delayed(
          const Duration(seconds: 1)); // Adding a small delay for better UX
      var response = await http.post(url, body: {
        'token': Memory.getToken()
      }); // Sending POST request with authentication token
      var result = adminProfileResponseFromJson(
          response.body); // Parsing JSON response into model

// Updating the adminProfileResponse if request was successful
      if (result.success!) {
        adminProfileResponse = result;
        update();
      }
    } catch (e) {
      // Showing error message if fetching fails
      Get.snackbar(
        'Error',
        'Failed to get profile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
