import 'package:get/get.dart';

import '../controllers/users_view_controller.dart';

class UsersViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersViewController>(
      () => UsersViewController(),
    );
  }
}
