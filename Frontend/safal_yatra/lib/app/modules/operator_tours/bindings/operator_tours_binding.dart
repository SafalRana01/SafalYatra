import 'package:get/get.dart';

import '../controllers/operator_tours_controller.dart';

class OperatorToursBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OperatorToursController>(
      () => OperatorToursController(),
    );
  }
}
