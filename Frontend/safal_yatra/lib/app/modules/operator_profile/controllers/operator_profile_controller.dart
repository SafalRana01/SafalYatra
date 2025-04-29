import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getOperatorProfile.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;

class OperatorProfileController extends GetxController {
  OperatorProfileResponse? operatorResponse;

  @override
  void onInit() {
    super.onInit();
    getMyProfile();
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
