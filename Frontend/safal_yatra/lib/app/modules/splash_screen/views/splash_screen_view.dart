import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/utils/memory.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    var token = Memory.getToken();
    var role = Memory.getRole();
    Future.delayed(Duration(seconds: 2), () {
      if (token == null) {
        Get.toNamed(Routes.BOARDING_SCREEN);
      } else if (role == 'user') {
        Get.offAllNamed(Routes.MAIN_SCREEN);
      } else if (role == 'operator') {
        Get.toNamed(Routes.OPERATOR_MAIN);
      } else if (role == 'driver') {
        Get.toNamed(Routes.DRIVER_MAIN);
      } else if (role == 'admin') {
        Get.toNamed(Routes.ADMIN_MAIN);
      } else {
        Get.snackbar('Error', 'Failed to navigate to main screen',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    });
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset("lib/assets/images/logo.png"),
            ),
            const SizedBox(height: 16), // Add some space below the image
            // const CircularProgressIndicator.adaptive(
            //     //  valueColor: Color(0xFF3F5DA9),
            //     ),
          ],
        ),
      ),
    );
  }
}
