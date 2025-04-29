import 'package:get/get.dart';

import '../controllers/operator_cars_controller.dart';

class OperatorCarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OperatorCarsController>(
      () => OperatorCarsController(),
    );
  }
}
