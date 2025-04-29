import 'package:get/get.dart';

import '../controllers/boarding_screen_controller.dart';

class BoardingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoardingScreenController>(
      () => BoardingScreenController(),
    );
  }
}
