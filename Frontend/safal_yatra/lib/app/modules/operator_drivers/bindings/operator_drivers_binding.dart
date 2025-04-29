import 'package:get/get.dart';

import '../controllers/operator_drivers_controller.dart';

class OperatorDriversBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OperatorDriversController>(
      () => OperatorDriversController(),
    );
  }
}
