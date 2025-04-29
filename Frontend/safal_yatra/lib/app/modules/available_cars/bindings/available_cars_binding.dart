import 'package:get/get.dart';

import '../controllers/available_cars_controller.dart';

class AvailableCarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvailableCarsController>(
      () => AvailableCarsController(),
    );
  }
}
