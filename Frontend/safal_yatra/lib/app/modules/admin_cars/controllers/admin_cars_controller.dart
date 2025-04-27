// Importing required packages and modules
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/allCars.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// Creating AdminCarsController to manage all cars data
class AdminCarsController extends GetxController {
  AllCarsResponse? cars; // Declaring a variable to hold car response data

  @override
  void onInit() {
    super.onInit();
    showAllCars(); // Fetching all cars when controller initializes
  }

  // Method to fetch all cars
  Future<void> showAllCars() async {
    try {
      // Creating request to fetch all cars
      var url = Uri.http(ipAddress, 'SafalYatra/admin/getAllCars.php');
      await Future.delayed(const Duration(seconds: 1));

// Sending POST request with token for authentication
      var response = await http.post(url, body: {
        'token': Memory.getToken(),
      });

      print(response.body);

// Parsing JSON response into model
      var result = allCarsResponseFromJson(response.body);
      print(result);

      // Updating the cars list if request was successful
      if (result.success!) {
        cars = result;
        update();
      }
    } catch (e) {
      // Showing error message if fetching fails
      Get.snackbar(
        'Error',
        'Failed to get cars',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
