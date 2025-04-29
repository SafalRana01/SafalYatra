import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/app/models/getCities.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';

class SelectCityController extends GetxController {
  CitiesResponse? citiesResponse;
  int currentIndex = 0;

  Rx<Color> homeColor = Colors.black.obs;

  RxList<String> allLocations = <String>[].obs;
  RxList<String> displayedLocations = <String>[].obs;

  RxString selectedCity = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadLocations();
  }

  // Add this inside SelectCityController
  final Map<String, String> aliasMap = {
    'pkr': 'pokhara',
    'ktm': 'kathmandu',
    'btl': 'butwal',
    'brt': 'biratnagar',
    // Add more aliases as needed
  };

  Future<void> loadLocations() async {
    try {
      List<String> fetchedCities = await getCities();
      allLocations.addAll(fetchedCities);
      displayedLocations.addAll(allLocations);
    } catch (e) {
      print('Error loading famous locations: $e');
    }
  }

  // void searchLocations(String query) {
  //   selectedCity.value = '';
  //   List<String> matchedLocations = allLocations
  //       .where(
  //           (location) => location.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  //   List<String> remainingLocations = allLocations
  //       .where((location) => !matchedLocations.contains(location))
  //       .toList();
  //   displayedLocations.assignAll([...matchedLocations, ...remainingLocations]);
  // }

  void searchLocations(String query) {
    selectedCity.value = '';
    query = query.toLowerCase().trim();

    // Check if it's an alias
    if (aliasMap.containsKey(query)) {
      String actualQuery = aliasMap[query]!;
      List<String> matched = allLocations
          .where((location) => location.toLowerCase().contains(actualQuery))
          .toList();

      List<String> remaining = allLocations
          .where((location) => !matched.contains(location))
          .toList();

      // Show alias match on top
      displayedLocations.assignAll([...matched, ...remaining]);
    } else {
      // Normal filtering
      List<String> matched = allLocations
          .where((location) => location.toLowerCase().contains(query))
          .toList();

      List<String> remaining = allLocations
          .where((location) => !matched.contains(location))
          .toList();

      displayedLocations.assignAll([...matched, ...remaining]);
    }
  }

  void selectCity(String city) {
    selectedCity.value = city;
    // Add any other actions needed when a city is selected
    print('Selected City: $city');
    Get.back(result: city);
  }

  Future<List<String>> getCities() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/others/getCities.php');
      var response = await http.post(url, body: {'token': Memory.getToken()});
      var result = citiesResponseFromJson(response.body);

      print("result: $result");
      if (result.success!) {
        List<String> cities =
            result.cities!.map((city) => city as String).toList();
        print(cities);
        return cities;
      } else {
        throw Exception(
            'Failed to load cities: ${result.message ?? "Unknown error"}');
      }
    } catch (e) {
      // Handle error, you can show a snackbar or log the error
      print('Error loading cities: $e');
      throw Exception('Failed to load cities: $e');
    }
  }
}
