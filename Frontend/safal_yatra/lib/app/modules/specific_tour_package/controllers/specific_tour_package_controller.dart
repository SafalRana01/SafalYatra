import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:safal_yatra/app/models/getAvailableTourPackage.dart';
import 'package:safal_yatra/app/modules/user_tour_booking/controllers/user_tour_booking_controller.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';

import 'package:http/http.dart' as http;

class SpecificTourPackageController extends GetxController {
  final AvailableTourPackage tours = Get.arguments;
  final numberOfPeopleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Reactive variables
  final numberOfPeople = 0.obs;
  final totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    numberOfPeopleController.addListener(calculateTotal);
  }

  @override
  void onClose() {
    numberOfPeopleController.dispose();
    super.onClose();
  }

  // Calculate total price dynamically
  void calculateTotal() {
    final enteredValue = numberOfPeopleController.text;

    if (enteredValue.isNotEmpty && int.tryParse(enteredValue) != null) {
      numberOfPeople.value = int.parse(enteredValue);

      // ✅ Convert price to double first, then to int
      double price = double.tryParse(tours.price ?? '0') ?? 0;
      totalPrice.value = (numberOfPeople.value * price).toInt();
    } else {
      numberOfPeople.value = 0;
      totalPrice.value = 0;
    }
  }

  void makeTourBooking() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        var url = Uri.http(ipAddress, 'SafalYatra/user/makeTourBooking.php');
        var body = {
          'token': Memory.getToken(),
          'start_date': tours.startDate.toString(),
          'end_date': tours.endDate.toString(),
          'driver_id': tours.driverId.toString(),
          'car_id': tours.carId.toString(),
          'package_id': tours.packageId.toString(),
          'number_of_people': numberOfPeopleController.text
        };

        var response = await http.post(url, body: body);

        print("Raw response: ${response.body}");

        var result = jsonDecode(response.body);
        print(result);
        if (result['success']) {
          // Get.snackbar(P
          //   'Booking',
          //   result['message'],
          //   backgroundColor: Colors.green,
          //   colorText: Colors.white,
          // );
          makeTourPayment(result['booking_id'], result['total']);
        } else {
          Get.snackbar(
            'Booking',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
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

  void makeTourPayment(int bookingId, int total) async {
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
            var url =
                Uri.http(ipAddress, 'SafalYatra/user/makeTourPayment.php');

            var response = await http.post(url, body: {
              'booking_id': bookingId.toString(),
              'token': Memory.getToken(),
              'amount': total.toString(),
              'tour_capacity': tours.tourCapacity.toString(),
              'number_of_people': numberOfPeopleController.text,
              'other_details': v.toString(),
            });

            String rawBody = response.body;
            print("RAW BODY: $rawBody");

// Clean out HTML if present (like <br />, etc.)
            String cleanJson = rawBody.split('<').first.trim();
            print("CLEANED JSON: $cleanJson");

            var result = jsonDecode(cleanJson); // Now safe to decode

// Optional debug
            print("Decoded Result: $result");
            print("Success: ${result['success']}");
            print("Message: ${result['message']}");
            if (result['success']) {
              Get.snackbar(
                'Success',
                result['message'],
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );

              await Future.delayed(Duration(seconds: 2));

              Get.offNamed(
                Routes.USER_TOUR_BOOKING,
                arguments: {'fromFlow': true},
              );
              Get.put(UserTourBookingController());
              Get.find<UserTourBookingController>().showTourBookingHistory();
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

  // void makeTourPayment(int bookingId, int total) async {
  //   try {
  //     // var config = PaymentConfig(
  //     //     amount: total,
  //     //     productIdentity: bookingId.toString(),
  //     //     productName: 'Booking: $bookingId');
  //     //
  //     // await KhaltiScope.of(Get.context!).pay(
  //     //     config: config,
  //     //     preferences: [ PaymentPreference.khalti ],
  //     //     onSuccess: (v) async {
  //     //       // ... your existing onSuccess body ...
  //     //     }
  //     // );

  //     // ───────────────────────────────────────
  //     // For testing: skip Khalti and simulate success
  //     Get.snackbar(
  //       'Success (Test)',
  //       'Skipping payment flow for testing.',
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //     );

  //     // Directly navigate to the booking history
  //     Get.offNamed(
  //       Routes.USER_TOUR_BOOKING,
  //       arguments: {'fromFlow': true},
  //     );
  //     // Make sure the controller is in place
  //     Get.put(UserTourBookingController());
  //     Get.find<UserTourBookingController>().showTourBookingHistory();
  //     // ───────────────────────────────────────
  //   } catch (e) {
  //     // handle errors...
  //     Get.snackbar(
  //       'Error',
  //       e.toString(),
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }
}
