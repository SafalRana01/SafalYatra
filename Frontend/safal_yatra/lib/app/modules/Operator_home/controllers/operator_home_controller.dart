import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getCategory.dart';
import 'package:safal_yatra/app/models/getOperatorProfile.dart';
import 'package:safal_yatra/app/models/operatorStatistic.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/utils/memory.dart';

class OperatorHomeController extends GetxController {
  OperatorStatisticResponse? statsResponse;
  OperatorProfileResponse? operatorResponse;
  // var selectedDate = TextEditingController();
  List<int> monthlyBookings = [];

  final monthController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void onInit() {
    // Simulating data fetch
    // Future.delayed(Duration(seconds: 1), () {
    //   monthlyBookings = [10, 25, 35, 20, 15, 40, 50, 30, 18, 22, 27, 33];
    //   update();
    // });
    super.onInit();
    getStats();
    getMyProfile();
  }

  Future<void> getStats({DateTime? date}) async {
    try {
      var url = Uri.http(
          ipAddress, 'SafalYatra/carOperator/getOperatorStatistic.php');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'month': date != null ? date.month.toString() : 'null',
        'year': date != null ? date.year.toString() : 'null',
      });
      var result = operatorStatisticResponseFromJson(response.body);

      if (result.success!) {
        statsResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get stats',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getMyProfile() async {
    try {
      var url =
          Uri.http(ipAddress, 'SafalYatra/carOperator/getOperatorProfile.php');
      await Future.delayed(const Duration(seconds: 1));
      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = operatorProfileResponseFromJson(response.body);

      if (result.success!) {
        operatorResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get profile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
