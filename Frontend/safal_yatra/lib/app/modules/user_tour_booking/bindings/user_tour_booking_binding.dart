import 'package:get/get.dart';

import '../controllers/user_tour_booking_controller.dart';

class UserTourBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserTourBookingController>(
      () => UserTourBookingController(),
    );
  }
}
