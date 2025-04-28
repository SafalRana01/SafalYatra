// Importing necessary packages
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/allBookings.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// Creating AdminBookingsController to manage admin's booking history
class AdminBookingsController extends GetxController {
  AllBookingsResponse?
      bookingResponse; // Declaring a variable to store booking data

// Running function automatically when controller initializes
  @override
  void onInit() {
    super.onInit();
    showBookingHistory(); // Fetching booking history when controller initializes
  }

// Creating function to fetch booking history from server
  Future<void> showBookingHistory() async {
    try {
      // Creating the URI for the getting booking history API
      var url = Uri.http(ipAddress, 'SafalYatra/others/getMyBooking.php');
      await Future.delayed(const Duration(seconds: 1));

      // Sending POST request with token and role
      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'role': Memory.getRole(),
      });

// Parsing the JSON response into bookingResponse model
      var result = allBookingsResponseFromJson(response.body);

// Checking if the API call was successful
      if (result.success!) {
        bookingResponse = result; // Storing the result
        update(); // Updating the UI
      }
    } catch (e) {
      // Showing error message if something goes wrong during API call
      Get.snackbar(
        'Error',
        'Failed to get bookings',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
