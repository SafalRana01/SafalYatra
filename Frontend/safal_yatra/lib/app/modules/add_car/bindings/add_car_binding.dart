import 'package:get/get.dart';

import '../controllers/add_car_controller.dart';

class AddCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCarController>(
      () => AddCarController(),
    );
  }
}
