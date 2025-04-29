import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/modules/driver_home/views/driver_home_view.dart';
import 'package:safal_yatra/app/modules/driver_profile/views/driver_profile_view.dart';

class DriverMainController extends GetxController {
  var currentIndex = 0.obs;

  List<Widget> screens = [DriverHomeView(), DriverProfileView()];
}
