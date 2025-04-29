import 'package:get/get.dart';

import '../controllers/select_city_controller.dart';

class SelectCityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectCityController>(
      () => SelectCityController(),
    );
  }
}
