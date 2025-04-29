import 'package:get/get.dart';

import '../controllers/driver_main_controller.dart';

class DriverMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverMainController>(
      () => DriverMainController(),
    );
  }
}
