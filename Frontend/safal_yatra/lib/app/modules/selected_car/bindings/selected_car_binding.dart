import 'package:get/get.dart';

import '../controllers/selected_car_controller.dart';

class SelectedCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedCarController>(
      () => SelectedCarController(),
    );
  }
}
