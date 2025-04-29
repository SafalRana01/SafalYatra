import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getCategory.dart';
import 'package:safal_yatra/app/models/getMyCars.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;

class OperatorCarsController extends GetxController {
  MyCarResponse? cars;
  CategoriesResponse? categoriesResponse;

  @override
  void onInit() {
    super.onInit();
    showMyCars();
    getCategories();
  }

  Future<void> showMyCars() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/carOperator/getMyCars.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
      });

      print(response.body);

      var result = myCarResponseFromJson(response.body);
      print(result);

      if (result.success!) {
        cars = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get cars',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getCategories() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/others/getCategory.php');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'role': Memory.getRole(),
      });
      var result = categoriesResponseFromJson(response.body);
      print(result);

      if (result.success!) {
        categoriesResponse = result;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get categories',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  var selectedCategory = ''.obs; // Empty string means "All Models"

  void selectCategory(String category) {
    selectedCategory.value = category;
    update(); // Notify UI to refresh
  }
}
