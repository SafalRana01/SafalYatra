import 'package:get/get.dart';

import '../controllers/add_tour_package_controller.dart';

class AddTourPackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTourPackageController>(
      () => AddTourPackageController(),
    );
  }
}
