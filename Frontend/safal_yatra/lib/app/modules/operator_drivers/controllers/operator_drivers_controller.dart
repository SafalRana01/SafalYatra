import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getMyDrivers.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;

class OperatorDriversController extends GetxController {
  MyDriversResponse? drivers;

  @override
  void onInit() {
    super.onInit();
    showMyDrivers();
  }

  Future<void> showMyDrivers() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/carOperator/getMyDrivers.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
      });

      print(response.body);

      var result = myDriversResponseFromJson(response.body);
      print(result);

      if (result.success!) {
        drivers = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get drivers',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void onDeleteDriver(String driverId) async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/carOperator/deleteDriver.php');

      // Ensure scheduleId is converted to a String before sending it in the request
      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'driverId': driverId,
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.back();
        showMyDrivers();

        Get.snackbar("Delete Driver", result['message'],
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Delete Driver", result['message'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      // Print any exceptions that occur during the API call
      print('Exception while deleting driver: $e');
      Get.snackbar(
        'Error',
        'Failed to delete driver',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void onRestoreDriver(String driverId) async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/carOperator/restoreDriver.php');

      // Ensure scheduleId is converted to a String before sending it in the request
      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'driverId': driverId,
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.back();
        showMyDrivers();

        Get.snackbar("Restore Driver", result['message'],
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Restore Driver", result['message'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      // Print any exceptions that occur during the API call
      print('Exception while restoring driver: $e');
      Get.snackbar(
        'Error',
        'Failed to restore driver',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
