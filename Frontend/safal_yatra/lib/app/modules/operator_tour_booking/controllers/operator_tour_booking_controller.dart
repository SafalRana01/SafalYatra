import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getAvailableTourPackage.dart';
import 'package:safal_yatra/app/models/getTourBookingByOperator.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;

class OperatorTourBookingController extends GetxController {
  final specificTourBooking = Get.arguments as AvailableTourPackage;

  UserBookedTourResponse? userBookedTourResponse;

  void onInit() {
    super.onInit();
    showTourBookedByUser();
  }

  Future<void> showTourBookedByUser() async {
    try {
      var url =
          Uri.http(ipAddress, 'SafalYatra/others/getSpecificTourBookings.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'package_id': specificTourBooking.packageId.toString()
      });

      print(response.body);

      var result = userBookedTourResponseFromJson(response.body);
      print(result);

      if (result.success!) {
        userBookedTourResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to user details',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
