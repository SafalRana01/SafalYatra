import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getCategory.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/utils/memory.dart';

class CategoriesController extends GetxController {
  CategoriesResponse? categoriesResponse;
  var categoryTitle = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future<void> getCategories() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/others/getCategory.php');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'role': Memory.getRole(),
      });
      var result = categoriesResponseFromJson(response.body);

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

  void addCategory() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        var url = Uri.http(ipAddress, 'SafalYatra/admin/addCategory.php');

        var response = await http.post(url, body: {
          'token': Memory.getToken(),
          'category': categoryTitle.text,
        });

        print(response.body);
        var result = jsonDecode(response.body);

        if (result['success']) {
          getCategories();
          Get.back();
          categoryTitle.clear();
          Get.snackbar(
            'Add Category',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Add Category',
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
        'Failed to add category',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void updateCategoryStatus(String categoryId, bool toDelete) async {
    try {
      var url =
          Uri.http(ipAddress, 'SafalYatra/admin/updateCategoryStatus.php');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'category_id': categoryId,
        'is_delete': toDelete ? '1' : '0',
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        print(result['message']);
        getCategories();
        //Get.back();
        categoryTitle.clear();
        Get.snackbar(
          'Update Category',
          result['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Update Category',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to add category',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
