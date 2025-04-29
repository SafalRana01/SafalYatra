import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/modules/UserHome/views/user_home_view.dart';
import 'package:safal_yatra/app/modules/bookings/views/bookings_view.dart';
import 'package:safal_yatra/app/modules/payments/views/payments_view.dart';
import 'package:safal_yatra/app/modules/profile/views/profile_view.dart';
import 'package:safal_yatra/app/modules/test_page/views/test_page_view.dart';
import 'package:safal_yatra/app/modules/tour_package/views/tour_package_view.dart';
import 'package:safal_yatra/app/modules/user_tour_booking/views/user_tour_booking_view.dart';

class MainScreenController extends GetxController {
  var currentIndex = 0.obs;

  List<Widget> screens = [
    UserHomeView(),
    UserTourBookingView(),
    // TestPageView(),
    BookingsView(),
    PaymentsView(),
    ProfileView(),
  ];
}
