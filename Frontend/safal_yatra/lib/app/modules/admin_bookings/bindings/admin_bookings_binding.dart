import 'package:get/get.dart';

import '../controllers/admin_bookings_controller.dart';

class AdminBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminBookingsController>(
      () => AdminBookingsController(),
    );
  }
}
