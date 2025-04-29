import 'package:get/get.dart';

import '../controllers/operator_bookings_controller.dart';

class OperatorBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OperatorBookingsController>(
      () => OperatorBookingsController(),
    );
  }
}
