// Importing required packages and modules
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safal_yatra/app/models/getCategory.dart';
import 'package:safal_yatra/app/modules/operator_cars/controllers/operator_cars_controller.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/utils/memory.dart';

// Creating controller class to manage the logic for adding a car
class AddCarController extends GetxController {
  // Controllers to handle form input fields
  var licensePlateController = TextEditingController();
  var carNameController = TextEditingController();
  var priceController = TextEditingController();
  var noOfSeatsController = TextEditingController();
  var noOfBagsController = TextEditingController();
  var noOfDoorsController = TextEditingController();
  var fuelTypeController = TextEditingController();

  var key = GlobalKey<FormState>(); // Form key for validation
  CategoriesResponse?
      categoriesResponse; // Storing fetched categories from the backend

// Initializing the controller
  @override
  void onInit() {
    super.onInit();
    getCategories(); // Fetching car categories when screen loads
  }

// Declaring variables for image selection and error checking
  bool isImageError = false;
  XFile? image;
  Uint8List? imageBytes;

  String? selectedCategoryId; // Storing selected category ID

// Deleting selected image from memory
  void onImageDelete() {
    image = null;
    imageBytes = null;
    update(); // Refreshing UI
  }

// Picking image from device gallery
  void onImagePick() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageBytes = await image!.readAsBytes(); // Converting image to byte data
      update(); // Updating UI to show image
    }
  }

// Adding a new car by sending form data and image to the backend
  Future<void> addCar() async {
    try {
      // Checking if image is selected
      if (image == null) {
        isImageError = true;
        update();
        Get.snackbar(
          'Image Required',
          'Please select an image of the car before submitting.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      } else {
        isImageError = false;
        update();
      }
      // Validating the form fields and checking if image is available
      if (key.currentState!.validate() && image != null) {
        var url = Uri.http(ipAddress, 'SafalYatra/carOperator/addCar.php');

        // Creating multipart request to send form data and image
        var request = http.MultipartRequest("POST", url);

        // Adding form fields
        request.fields['license_plate'] = licensePlateController.text;
        request.fields['car_name'] = carNameController.text;
        request.fields['rate_per_hours'] = priceController.text;
        request.fields['seat_capacity'] = noOfSeatsController.text;
        request.fields['category_id'] = selectedCategoryId!;
        request.fields['baggage_capacity'] = noOfBagsController.text;
        request.fields['door_count'] = noOfDoorsController.text;
        request.fields['fuel_type'] = fuelTypeController.text;
        request.fields['token'] = Memory.getToken()!;

// Adding the selected image to the request
        request.files.add(
          http.MultipartFile.fromBytes('image', imageBytes!,
              filename: image!.name),
        );

// Sending the request and waiting for the response
        var streamResponse = await request.send();
        var response = await http.Response.fromStream(streamResponse);

        var result = jsonDecode(response.body); // Decoding the response JSON

// Handling success or failure of adding the car
        if (result['success']) {
          Get.back(); // Going back and refreshing the car list
          Get.find<OperatorCarsController>().showMyCars();
          Get.snackbar(
            'Car Added Successfully',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          // Showing failure message from server
          Get.snackbar(
            'Add Car Failed',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      // Catching and showing unexpected error
      Get.snackbar(
        'Error Occurred',
        'Something went wrong while adding the car. Please try again later.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Fetching car categories from the backend
  Future<void> getCategories() async {
    try {
      // Creating request to fetch categories
      var url = Uri.http(ipAddress, 'SafalYatra/others/getCategory.php');

// Sending request with user token and role
      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'role': Memory.getRole(),
      });

      // Converting response into model object
      var result = categoriesResponseFromJson(response.body);
      print(result); // Logging result for debugging

// Updating state if fetch is successful
      if (result.success!) {
        categoriesResponse = result;
        update(); // Updating UI to show category options
      }
    } catch (e) {
      Get.snackbar(
        // Showing error message if category fetch fails
        'Category Fetch Failed',
        'Could not load car categories. Please check your connection.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

// Finding the OperatorCarsController instance and calling showMyCars()
// to refresh and update the car list after successfully adding a new car.
// Get.find<OperatorCarsController>().showMyCars();
