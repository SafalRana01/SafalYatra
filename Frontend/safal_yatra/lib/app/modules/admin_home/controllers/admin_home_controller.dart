// Importing required packages and modules
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/adminStatistic.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;

// Creating AdminHomeController to manage admin's home screen
class AdminHomeController extends GetxController {
  AdminStatisticResponse? statsResponse; // Variable to store admin statistics
  final monthController =
      TextEditingController(); // Creating a controller for handling month input
  DateTime selectedDate =
      DateTime.now(); // Setting default selected date to current date

  @override
  void onInit() {
    super.onInit();
    getStats(); // Fetching statistics when controller initializes
  }

  // Method to fetch admin statistics
  Future<void> getStats({DateTime? date}) async {
    try {
      // Creating request to fetch admin statistics
      var url = Uri.http(ipAddress, 'SafalYatra/admin/getAdminStatistic.php');

// Sending POST request with token and optional month/year
      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'month': date != null ? date.month.toString() : 'null',
        'year': date != null ? date.year.toString() : 'null',
      });
      // Parsing JSON response into model
      var result = adminStatisticResponseFromJson(response.body);
      print(result);

// Updating the statsResponse if request was successful
      if (result.success!) {
        statsResponse = result;
        update();
      }
    } catch (e) {
      print(e); // Printing error and showing error message if fetching fails
      Get.snackbar(
        'Error',
        'Failed to get stats',
        backgroundColor: const Color.fromARGB(255, 243, 201, 198),
        colorText: Colors.white,
      );
    }
  }
}
