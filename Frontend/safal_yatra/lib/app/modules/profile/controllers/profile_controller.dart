import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getUserProfile.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/utils/memory.dart';

class ProfileController extends GetxController {
  UserProfileResponse? userResponse;

  @override
  void onInit() {
    super.onInit();
    getMyProfile();
  }

  Future<void> getMyProfile() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/user/getUserProfile.php');
      await Future.delayed(const Duration(seconds: 1));
      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = userProfileResponseFromJson(response.body);

      if (result.success!) {
        userResponse = result;
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
