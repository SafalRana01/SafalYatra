import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:safal_yatra/app/models/getAvailableCars.dart';
import 'package:safal_yatra/app/modules/UserHome/controllers/user_home_controller.dart';
import 'package:safal_yatra/app/modules/bookings/controllers/bookings_controller.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/app/models/getAvailableDrivers.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart'; // Import the ListDriver model
import 'package:http/http.dart' as http;

class SelectedCarController extends GetxController {
  final selectedCar =
      Get.arguments as ListCar; // Receive the car data from the previous screen

  // Observable variables for storing driver details
  RxString driverName = "".obs;
  RxString driverPhoto = "".obs;
  Rx<ListDriver?> selectedDriver =
      Rx<ListDriver?>(null); // Track the selected driver

  // Method to navigate to the driver selection page
  Future<void> navigateToSelectDriverPage() async {
    final result = await Get.toNamed(
      Routes.AVAILABLE_DRIVERS,
      arguments: selectedDriver.value, // Pass the selected driver here
    );

    if (result != null) {
      // Assuming 'result' is the selected driver object passed back from the AvailableDrivers page
      selectedDriver.value =
          result; // Store the selected driver in the reactive variable

      // Update the driver details (if needed, using the driver data)
      driverName.value = result.driverName ?? ''; // Store the driver's name
      driverPhoto.value =
          result.driverPhoto ?? ''; // Store the driver's photo URL or path
    }
  }

  void makeBooking() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/user/makeBooking.php');
      var body = {
        'token': Memory.getToken(),
        'location': Get.find<UserHomeController>().locationController.text,
        'start_date': Get.find<UserHomeController>().pickUpDate.toString(),
        'end_date': Get.find<UserHomeController>().dropOffDate.toString(),
        'driver_id': selectedDriver.value?.driverId?.toString() ?? '',
        'car_id': selectedCar.carId.toString()
      };

      var response = await http.post(url, body: body);

      print(response.body);

      var result = jsonDecode(response.body);
      print(result);
      if (result['success']) {
        // Get.snackbar(
        //   'Booking',
        //   result['message'],
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
        makePayment(result['booking_id'], result['total']);
      } else {
        Get.snackbar(
          'Booking',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to make booking',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void makePayment(int bookingId, int total) async {
    try {
      var config = PaymentConfig(
          amount: total,
          productIdentity: bookingId.toString(),
          productName: 'Booking: $bookingId');

      await KhaltiScope.of(Get.context!).pay(
          config: config,
          preferences: [
            PaymentPreference.khalti,
          ],
          onSuccess: (v) async {
            var url = Uri.http(ipAddress, 'SafalYatra/user/makePayment.php');

            var response = await http.post(url, body: {
              'booking_id': bookingId.toString(),
              'token': Memory.getToken(),
              'amount': total.toString(),
              'other_details': v.toString(),
            });

            var result = jsonDecode(response.body);
            if (result['success']) {
              Get.snackbar(
                'Success',
                result['message'],
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
              Get.offNamed(
                Routes.BOOKINGS,
                arguments: {'from_flow': true},
              );
              Get.put(BookingsController());
              Get.find<BookingsController>().showBookingHistory();
            } else {
              Get.snackbar(
                'Failed',
                result['message'],
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
          onFailure: (v) {
            Get.snackbar(
              'Failed',
              'Payment failed',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          },
          onCancel: () {
            Get.snackbar(
              'Cancelled',
              'Payment cancelled',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to make payment',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
