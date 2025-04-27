// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/app/models/allAdmin.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';

// Controller class to manage all admins
class AllAdminsController extends GetxController {
  AllAdminResponse? allAdminResponse; // Variable to store all admin response

// Initializing the controller
  @override
  void onInit() {
    super.onInit();
    getAdmins(); // Fetching all admins when controller initializes
  }

// Method to fetch all admins from the server
  Future<void> getAdmins() async {
    try {
      // Creating request to fetch all admins from the server
      var url = Uri.http(ipAddress, 'SafalYatra/admin/getAllAdmin.php');
      await Future.delayed(
          const Duration(seconds: 1)); // Adding a small delay for better UX

// Sending POST request with authentication token
      var response = await http.post(url, body: {
        'token': Memory.getToken(),
      });

      // Parsing JSON response into model
      var result = allAdminResponseFromJson(response.body);

// Updating the allAdminResponse if request was successful
      if (result.success!) {
        allAdminResponse = result;

        update();
      }
    } catch (e) {
      // Showing error message if fetching fails
      Get.snackbar(
        'Error',
        'Failed to get admin',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
