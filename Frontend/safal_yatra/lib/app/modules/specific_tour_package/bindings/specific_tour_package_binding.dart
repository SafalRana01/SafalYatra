import 'package:get/get.dart';

import '../controllers/specific_tour_package_controller.dart';

class SpecificTourPackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecificTourPackageController>(
      () => SpecificTourPackageController(),
    );
  }
}
