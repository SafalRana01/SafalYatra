import 'package:get/get.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  void sendToLogin() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.toNamed(Routes.LOGIN_PAGE);
    });
  }
}
