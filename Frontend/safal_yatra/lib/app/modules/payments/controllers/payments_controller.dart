import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getPayment.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PaymentsController extends GetxController {
  PaymentResponse? paymentResponse;

  @override
  void onInit() {
    super.onInit();
    showPaymentHistory();
  }

  Future<void> showPaymentHistory() async {
    try {
      var url = Uri.http(ipAddress, 'SafalYatra/others/getPayment.php');
      await Future.delayed(const Duration(seconds: 1));

      var response = await http.post(url,
          body: {'token': Memory.getToken(), 'role': Memory.getRole()});

      var result = paymentResponseFromJson(response.body);

      if (result.success!) {
        paymentResponse = result;

        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get payments',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
