import 'package:get/get.dart';

import '../controllers/admin_cars_controller.dart';

class AdminCarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCarsController>(
      () => AdminCarsController(),
    );
  }
}
