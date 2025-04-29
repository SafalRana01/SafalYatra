import 'package:get/get.dart';

import '../controllers/forget_otp_validate_controller.dart';

class ForgetOtpValidateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetOtpValidateController>(
      () => ForgetOtpValidateController(),
    );
  }
}
