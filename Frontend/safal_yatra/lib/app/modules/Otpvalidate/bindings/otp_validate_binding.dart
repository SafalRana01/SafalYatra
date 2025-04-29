import 'package:get/get.dart';

import '../controllers/otp_validate_controller.dart';

class OtpValidateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpValidateController>(
      () => OtpValidateController(),
    );
  }
}
