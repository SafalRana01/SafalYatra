import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getMyBookings.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;

class BookingsController extends GetxController {
  MyBookingsResponse? bookingResponse;
  var selectedRating = 0.0;

  @override
  void onInit() {
    super.onInit();
    showBookingHistory();
  }

  Future<void> showBookingHistory() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/others/getMyBooking.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url,
          body: {'token': Memory.getToken(), 'role': Memory.getRole()});

      var result = myBookingsResponseFromJson(response.body);

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

  void giveRating(String carId) async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/user/giveRating.php');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'car_id': carId,
        'rating': selectedRating.toString()
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.snackbar(
          'Rating',
          result['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Get.find<HomeController>().getVehicles();
        update();
      } else {
        Get.snackbar(
          'Error',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to give rating',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void cancelBooking(String bookingId) async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/user/cancelBooking.php');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'booking_id': bookingId,
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.snackbar(
          'Cancel Booking',
          result['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        showBookingHistory();
        Get.close(1);
        update();
        // Get.find<HomeController>().getVehicles();
        update();
      } else {
        Get.snackbar(
          'Error',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to cancel booking',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
