import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getMyTourBookings.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:safal_yatra/utils/memory.dart';

class UserTourBookingController extends GetxController {
  MyTourPackageResponse? tourBookingResponse;

  @override
  void onInit() {
    super.onInit();
    showTourBookingHistory();
  }

  Future<void> showTourBookingHistory() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/user/getMyTourBooking.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url,
          body: {'token': Memory.getToken(), 'role': Memory.getRole()});

      var result = myTourPackageResponseFromJson(response.body);

      if (result.success!) {
        tourBookingResponse = result;

        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get tour bookings',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
