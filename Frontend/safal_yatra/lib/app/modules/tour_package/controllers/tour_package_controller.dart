import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getAvailableTourPackage.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;

class TourPackageController extends GetxController {
  AvailableTourPackageResponse? tourPackages;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    showAvailableTourPackages();
  }

  var expandedList = <int>[].obs; // Store expanded indexes

  void toggleExpand(int index) {
    if (expandedList.contains(index)) {
      expandedList.remove(index);
    } else {
      expandedList.add(index);
    }
    update();
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
}
