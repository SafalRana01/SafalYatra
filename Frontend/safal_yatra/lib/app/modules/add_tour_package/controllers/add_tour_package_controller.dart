import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safal_yatra/app/models/getCars.dart';
import 'package:safal_yatra/app/models/getMyDrivers.dart';
import 'package:safal_yatra/app/modules/operator_cars/controllers/operator_cars_controller.dart';
import 'package:safal_yatra/app/modules/operator_tours/controllers/operator_tours_controller.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/utils/memory.dart';

class AddTourPackageController extends GetxController {
  // Creating controllers for form input fields
  var packageNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var pricePerPersonController = TextEditingController();
  var startLocationController = TextEditingController();
  var destinationController = TextEditingController();

  var key = GlobalKey<FormState>(); // Creating a key to validate the form
  Cars? carsResponse; // Storing fetched car list
  MyDriversResponse? drivers; // Storing fetched driver list

  var pickUpDate = Rxn<DateTime>(); // Saving selected start date
  var dropOffDate = Rxn<DateTime>(); // Saving selected end date
  var selectedDays = 0.obs; // Storing number of days selected

// This method runs automatically when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    getCars(); // Getting car list from backend
    showMyDrivers(); // Getting driver list from backend
  }

// Declaring image and error handling variables
  bool isImageError = false;
  XFile? image;
  Uint8List? imageBytes;

// These variables will store the selected car and driver ID
  String? selectedCarId;
  String? selectedDriverId;

// Removing selected image from form
  void onImageDelete() {
    image = null;
    imageBytes = null;
    update(); // updating UI
  }

// Picking image from gallery and converting it to bytes
  void onImagePick() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageBytes = await image!.readAsBytes(); // reading image bytes
      update(); // updating UI
    }
  }

// Sending all form data including image to backend to add a new tour package
  Future<void> addTourPackage() async {
    try {
      if (image == null) {
        isImageError = true;
        update();
      } else {
        isImageError = false;
        update();
      }

      // Validating the form and image
      if (key.currentState!.validate() && image != null) {
        var url =
            Uri.http(ipAddress, 'SafalYatra/carOperator/addTourPackage.php');

        var request = http.MultipartRequest("POST", url);

        // Adding form field values to request
        request.fields['car_id'] = selectedCarId!;
        request.fields['driver_id'] = selectedDriverId!;
        request.fields['package_name'] = packageNameController.text;
        request.fields['description'] = descriptionController.text;
        request.fields['price_per_person'] = pricePerPersonController.text;
        request.fields['start_date'] = pickUpDate.toString();
        request.fields['end_date'] = dropOffDate.toString();
        request.fields['start_location'] = startLocationController.text;
        request.fields['destination'] = destinationController.text;
        request.fields['token'] = Memory.getToken()!;

        // Adding image file to request
        request.files.add(
          http.MultipartFile.fromBytes('image', imageBytes!,
              filename: image!.name),
        );

// Sending request and receiving response
        var streamResponse = await request.send();
        var response = await http.Response.fromStream(streamResponse);

        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.back();
          Get.find<OperatorToursController>()
              .showAvailableTourPackages(); // refreshing tour list
          Get.snackbar(
            'Add Tour Package',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Add Tour Package',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e, stackTrace) {
      print("Error: $e");
      print("Stack Trace: $stackTrace");

      Get.snackbar(
        'Add Car',
        'Failed to add tour package: $e', // Show error message in Snackbar
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Getting list of available cars from backend

  Future<void> getCars() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/others/getCar.php');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'role': Memory.getRole(),
      });
      var result = carsFromJson(response.body);
      print(result);

      if (result.success!) {
        carsResponse = result;
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

// Getting list of assigned drivers from backend
  Future<void> showMyDrivers() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/carOperator/getMyDrivers.php');
      // Adding small delay before making request
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
      });

      print(response.body);

      var result = myDriversResponseFromJson(response.body);
      print(result);

      if (result.success!) {
        drivers = result; // saving the result
        update(); // updating UI
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get drivers',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

// Showing calendar to pick start and end dates for the tour
  Future<void> selectDateRange(BuildContext context) async {
    DateTime now = DateTime.now();

// Opening date range picker
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(), // Allowing only future dates
      lastDate: DateTime.now().add(
        const Duration(days: 30), // Limiting to 30 days
      ),
      initialDateRange: DateTimeRange(start: now, end: now),
      // Customizing the theme of the date picker
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

// Saving selected dates and calculating total number of days
    if (picked != null) {
      pickUpDate.value = picked.start;
      dropOffDate.value = picked.end;
      selectedDays.value = picked.end.difference(picked.start).inDays + 1;
    }
  }
}
