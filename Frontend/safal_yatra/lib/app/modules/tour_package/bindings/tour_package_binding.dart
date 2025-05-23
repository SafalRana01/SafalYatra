import 'package:get/get.dart';

import '../controllers/tour_package_controller.dart';

class TourPackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TourPackageController>(
      () => TourPackageController(),
    );
  }
}
