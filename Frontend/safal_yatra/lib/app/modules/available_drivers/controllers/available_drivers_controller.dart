import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getAvailableDrivers.dart';
import 'package:safal_yatra/app/modules/UserHome/controllers/user_home_controller.dart';
import 'package:safal_yatra/app/modules/selected_car/controllers/selected_car_controller.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;

class AvailableDriversController extends GetxController {
  AvailableDriversResponse? driversResponse;
  RxList<ListDriver> allDrivers = <ListDriver>[].obs;
  RxList<ListDriver> displayedDrivers = <ListDriver>[].obs;
  Rx<ListDriver?> selectedDriver = Rx<ListDriver?>(null);

  @override
  void onInit() {
    super.onInit();
    loadDrivers();
  }

  Future<void> loadDrivers() async {
    try {
      List<ListDriver> fetchedDrivers = await getDrivers();
      allDrivers.assignAll(fetchedDrivers);
      displayedDrivers.assignAll(allDrivers);
    } catch (e) {
      print('Error loading drivers: $e');
    }
  }

  void searchDrivers(String query) {
    selectedDriver.value = null;

    // Split the drivers into matched and non-matched
    List<ListDriver> matchedDrivers = allDrivers
        .where((driver) =>
            driver.driverName!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    List<ListDriver> nonMatchedDrivers = allDrivers
        .where((driver) =>
            !driver.driverName!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Combine them: matched drivers first, non-matched drivers next
    displayedDrivers.assignAll([...matchedDrivers, ...nonMatchedDrivers]);
  }

  void selectDriver(ListDriver driver) {
    selectedDriver.value = driver;
    print(driver);
    Get.back(result: driver);
  }

  Future<List<ListDriver>> getDrivers() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/user/getAvailableDrivers.php');
      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'start_date': Get.find<UserHomeController>().pickUpDate.toString(),
        'end_date': Get.find<UserHomeController>().dropOffDate.toString(),
        'operator_id':
            Get.find<SelectedCarController>().selectedCar.operatorId.toString(),
      });

      var result = availableDriversResponseFromJson(response.body);
      print("API Response: $result");

      if (result.success!) {
        driversResponse = result;
        return result.listDrivers ?? [];
      } else {
        throw Exception(
            'Failed to load drivers: ${result.message ?? "Unknown error"}');
      }
    } catch (e) {
      print('Error loading drivers: $e');
      return [];
    }
  }
}
