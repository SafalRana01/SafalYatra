import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safal_yatra/app/models/getOperatorProfile.dart';
import 'package:safal_yatra/app/modules/operator_home/controllers/operator_home_controller.dart';
import 'package:safal_yatra/app/modules/operator_profile/controllers/operator_profile_controller.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:safal_yatra/utils/memory.dart';

class EditOperatorController extends GetxController {
  final Operators operator = Get.arguments;
  var formKey = GlobalKey<FormState>();
  OperatorProfileResponse? operatorResponse;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var contactController = TextEditingController();
  var registrationNumberController = TextEditingController();
  var locationController = TextEditingController();

  String? imageUrl;

  XFile? imageFile;
  Uint8List? imageBytes;

  @override
  void onInit() {
    super.onInit();
    nameController.text = operator.operatorName ?? '';
    emailController.text = operator.email ?? '';
    registrationNumberController.text = operator.registrationNumber ?? '';
    contactController.text = operator.phoneNumber ?? '';
    locationController.text = operator.location ?? '';
    imageUrl = operator.imageUrl;
  }

  void onImagePick() async {
    final ImagePicker picker = ImagePicker();
    imageFile = await picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      imageBytes = await imageFile!.readAsBytes();
      update();
    }
  }

  void onUpdateProfile() async {
    try {
      if (formKey.currentState!.validate()) {
        var url = Uri.http(
            ipAddress, 'SafalYatra/carOperator/editOperatorProfile.php');

        var request = http.MultipartRequest("POST", url);

        request.fields['operator_name'] = nameController.text;
        request.fields['contact'] = contactController.text;
        request.fields['registrationNumber'] =
            registrationNumberController.text;
        request.fields['location'] = locationController.text;

        request.fields['token'] = Memory.getToken()!;

        if (imageBytes != null) {
          request.files.add(
            http.MultipartFile.fromBytes('image', imageBytes!,
                filename: imageFile!.name),
          );
        }

        var streamResponse = await request.send();
        var response = await http.Response.fromStream(streamResponse);
        print(response.body);
        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.back();
          Get.find<OperatorHomeController>().getMyProfile();
          Get.find<OperatorProfileController>().getMyProfile();
          Get.snackbar(
            'Update Profile',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Update Profile',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Update Profile',
        'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
