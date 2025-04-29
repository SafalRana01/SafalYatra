import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getAvailableTourPackage.dart';

import 'package:safal_yatra/app/models/getUserProfile.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/utils/memory.dart';

class UserHomeController extends GetxController {
  AvailableTourPackageResponse? tourPackages;
  UserProfileResponse? userResponse;

  var locationController = TextEditingController();

  var pickUpDate = Rxn<DateTime>();
  var dropOffDate = Rxn<DateTime>();
  var selectedDays = 0.obs;

  @override
  void onInit() {
    super.onInit();
    showAvailableTourPackages();
    getMyProfile();
  }

  Future<void> showAvailableTourPackages() async {
    try {
      var url =
          Uri.http(ipAddress, 'SafalYatra/others/getAvailableTourPackages.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'role': Memory.getRole(),
      });

      print(response.body);

      var result = availableTourPackageResponseFromJson(response.body);
      print(result);

      if (result.success!) {
        tourPackages = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get tour packages',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Function to show date range picker and update pick-up and drop-off dates
  Future<void> selectDateRange(BuildContext context) async {
    DateTime now = DateTime.now();

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 30),
      ),
      initialDateRange: DateTimeRange(start: now, end: now),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.buttonColor,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.buttonColor,
              ),
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      pickUpDate.value = picked.start;
      dropOffDate.value = picked.end;
      selectedDays.value = picked.end.difference(picked.start).inDays + 1;
    }
  }

  Future<void> navigateToLocationPage() async {
    final result = await Get.toNamed(
      Routes.SELECT_CITY,
      arguments: "city",
    );

    if (result != null) {
      locationController.text = result;
    }
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
