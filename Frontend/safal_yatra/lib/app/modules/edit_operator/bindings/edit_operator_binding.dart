import 'package:get/get.dart';

import '../controllers/edit_operator_controller.dart';

class EditOperatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditOperatorController>(
      () => EditOperatorController(),
    );
  }
}
