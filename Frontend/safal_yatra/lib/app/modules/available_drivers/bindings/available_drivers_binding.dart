import 'package:get/get.dart';

import '../controllers/available_drivers_controller.dart';

class AvailableDriversBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvailableDriversController>(
      () => AvailableDriversController(),
    );
  }
}
