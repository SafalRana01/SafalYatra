import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getOperatorBooking.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;

class OperatorBookingsController extends GetxController {
  OperatorBookingResponse? bookingResponse;

  @override
  void onInit() {
    super.onInit();
    showBookingHistory();
  }

  Future<void> showBookingHistory() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/others/getMyBooking.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'role': Memory.getRole(),
      });

      var result = operatorBookingResponseFromJson(response.body);

      if (result.success!) {
        bookingResponse = result;

        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get bookings',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
