import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safal_yatra/app/models/getAvailableCars.dart';
import 'package:safal_yatra/app/models/getCategory.dart';
import 'package:safal_yatra/app/modules/UserHome/controllers/user_home_controller.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/utils/memory.dart';

class AvailableCarsController extends GetxController {
  AvailableCarsResponse? availableCarsResponse;
  CategoriesResponse? categoriesResponse;

  @override
  void onInit() {
    super.onInit();

    showAvailableCars();
    getCategories();

    //sortCares(selectedItem);
  }

  Future<void> showAvailableCars() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/user/getAvailableCars.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'location': Get.find<UserHomeController>().locationController.text,
        'start_date': Get.find<UserHomeController>().pickUpDate.toString(),
        'end_date': Get.find<UserHomeController>().dropOffDate.toString(),
      });

      print(response.body);

      var result = availableCarsResponseFromJson(response.body);
      print(result);

      if (result.success!) {
        availableCarsResponse = result;

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

  void sortCars(String selectedItems) {
    List<ListCar>? sortedCars;
    switch (selectedItems) {
      case 'price_low_high':
        sortedCars = List.from(availableCarsResponse?.listCars ?? []);
        sortedCars.sort((a, b) {
          double priceA = double.tryParse(a.ratePerHours ?? '0') ??
              0.0; // Convert to double
          double priceB = double.tryParse(b.ratePerHours ?? '0') ??
              0.0; // Convert to double
          return priceA.compareTo(priceB);
        });
        break;

      case 'price_high_low':
        sortedCars = List.from(availableCarsResponse?.listCars ?? []);
        sortedCars.sort((a, b) {
          double priceA = double.tryParse(a.ratePerHours ?? '0') ??
              0.0; // Convert to double
          double priceB = double.tryParse(b.ratePerHours ?? '0') ??
              0.0; // Convert to double
          return priceB.compareTo(priceA);
        });
        break;

      case 'passenger_capacity_few_many':
        sortedCars = List.from(availableCarsResponse?.listCars ?? []);
        sortedCars.sort((a, b) {
          int capacityA =
              int.tryParse(a.seatingCapacity ?? '0') ?? 0; // Convert to int
          int capacityB =
              int.tryParse(b.seatingCapacity ?? '0') ?? 0; // Convert to int
          return capacityA.compareTo(capacityB);
        });
        break;

      case 'passenger_capacity_many_few':
        sortedCars = List.from(availableCarsResponse?.listCars ?? []);
        sortedCars.sort((a, b) {
          int capacityA =
              int.tryParse(a.seatingCapacity ?? '0') ?? 0; // Convert to int
          int capacityB =
              int.tryParse(b.seatingCapacity ?? '0') ?? 0; // Convert to int
          return capacityB.compareTo(capacityA);
        });
        break;

      case 'rating_high_low':
        sortedCars = List.from(availableCarsResponse?.listCars ?? []);
        sortedCars.sort((a, b) {
          double ratingA =
              double.tryParse(a.rating ?? '0') ?? 0.0; // Convert to double
          double ratingB =
              double.tryParse(b.rating ?? '0') ?? 0.0; // Convert to double
          return ratingB.compareTo(ratingA);
        });
        break;

      case 'rating_low_high':
        sortedCars = List.from(availableCarsResponse?.listCars ?? []);
        sortedCars.sort((a, b) {
          double ratingA =
              double.tryParse(a.rating ?? '0') ?? 0.0; // Convert to double
          double ratingB =
              double.tryParse(b.rating ?? '0') ?? 0.0; // Convert to double
          return ratingA.compareTo(ratingB);
        });
        break;

      default:
        return;
    }

    availableCarsResponse = AvailableCarsResponse(listCars: sortedCars);

    sortedCars.forEach((car) {
      print(
          'Operator: ${car.categoryName}, Price: ${car.ratePerHours}, Seating Capacity: ${car.seatingCapacity}, Rating: ${car.rating}');
    });

    update(); // Notify GetBuilder to rebuild the UI
  }

  // Define selectedValue variable
  late String selectedItem = ''; // Variable to store the selected item
}
