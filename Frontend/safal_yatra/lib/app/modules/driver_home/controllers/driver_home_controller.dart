import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getDriverSchedule.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;

class DriverHomeController extends GetxController {
  DriverScheduleResponse? driverScheduleResponse;

  @override
  void onInit() {
    super.onInit();
    showDriverSchedules();
  }

  Future<void> showDriverSchedules() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/others/getMyBooking.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url,
          body: {'token': Memory.getToken(), 'role': Memory.getRole()});

      print(response.body);

      var result = driverScheduleResponseFromJson(response.body);
      print(result);

      if (result.success!) {
        driverScheduleResponse = result;

        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get schedules',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
