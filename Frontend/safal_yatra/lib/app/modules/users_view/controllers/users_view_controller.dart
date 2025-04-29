import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:safal_yatra/app/models/allDrivers.dart';
import 'package:safal_yatra/app/models/allOperators.dart';
import 'package:safal_yatra/app/models/allUsers.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';

class UsersViewController extends GetxController {
  AllUsersResponse? allUserResponse;
  AllOperatorsResponse? allOperatorResponse;
  AllDriversResponse? allDriverResponse;
  // AllAdminResponse? allAdminResponse;

  @override
  void onInit() {
    super.onInit();
    getUsers();
    getOperators();
    getDrivers();
    // getAdmins();
  }

  Future<void> getUsers() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/admin/getUsersByAdmin.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
      });

      var result = allUsersResponseFromJson(response.body);

      if (result.success!) {
        allUserResponse = result;

        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get users',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getOperators() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/admin/getOperatorsByAdmin.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
      });

      var result = allOperatorsResponseFromJson(response.body);

      if (result.success!) {
        allOperatorResponse = result;

        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get operators',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getDrivers() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/admin/getDriversByAdmin.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
      });

      var result = allDriversResponseFromJson(response.body);

      if (result.success!) {
        allDriverResponse = result;

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

  // Future<void> getAdmins() async {
  //   try {
  //     var url = Uri.http(ipAddress, 'admin_busease/getAdmin.php');
  //     await Future.delayed(const Duration(seconds: 1));

  //     var response = await http.post(url, body: {
  //       'token': Memory.getToken(),
  //     });

  //     var result = allAdminResponseFromJson(response.body);

  //     if (result.success!) {
  //       allAdminResponse = result;

  //       update();
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to get admin',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }
  void verifyOperator(String operatorId) async {
    try {
      var url =
          Uri.http(ipAddress, 'SafalYatra/admin/verifyOperatorByAdmin.php');
      var response = await http.post(url,
          body: {'token': Memory.getToken(), 'operator_id': operatorId});

      var result = jsonDecode(response.body);

      if (result['success']) {
        getOperators();
        Get.snackbar("Verify Operator", result['message'],
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Veriy Operator", result['message'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }

      // Perform sign up logic here
    } catch (e) {
      Get.snackbar("Error", "Failed to verify operator",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void deleteOperator(String operatorId) async {
    try {
      var url =
          Uri.http(ipAddress, 'SafalYatra/admin/deleteOperatorByAdmin.php');
      var response = await http.post(url,
          body: {'token': Memory.getToken(), 'operator_id': operatorId});

      var result = jsonDecode(response.body);

      if (result['success']) {
        // Passing both activation code and role
        Get.back();

        getOperators();
        Get.snackbar("Delete Operator", result['message'],
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Delete Operator", result['message'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }

      // Perform sign up logic here
    } catch (e) {
      Get.snackbar("Error", "Failed to verify operator",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
