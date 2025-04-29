import 'package:get/get.dart';

import '../controllers/edit_admin_controller.dart';

class EditAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAdminController>(
      () => EditAdminController(),
    );
  }
}
