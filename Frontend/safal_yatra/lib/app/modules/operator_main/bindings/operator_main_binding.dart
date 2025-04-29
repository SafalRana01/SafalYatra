import 'package:get/get.dart';

import '../controllers/operator_main_controller.dart';

class OperatorMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OperatorMainController>(
      () => OperatorMainController(),
    );
  }
}
