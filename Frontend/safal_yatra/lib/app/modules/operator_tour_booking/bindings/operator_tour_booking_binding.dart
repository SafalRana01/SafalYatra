import 'package:get/get.dart';

import '../controllers/operator_tour_booking_controller.dart';

class OperatorTourBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OperatorTourBookingController>(
      () => OperatorTourBookingController(),
    );
  }
}
