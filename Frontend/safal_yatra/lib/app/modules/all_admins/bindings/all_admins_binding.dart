import 'package:get/get.dart';

import '../controllers/all_admins_controller.dart';

class AllAdminsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllAdminsController>(
      () => AllAdminsController(),
    );
  }
}
