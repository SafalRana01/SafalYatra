import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/modules/operator_bookings/views/operator_bookings_view.dart';
import 'package:safal_yatra/app/modules/operator_cars/views/operator_cars_view.dart';
import 'package:safal_yatra/app/modules/operator_drivers/views/operator_drivers_view.dart';
import 'package:safal_yatra/app/modules/operator_home/views/operator_home_view.dart';
import 'package:safal_yatra/app/modules/operator_tours/views/operator_tours_view.dart';

class OperatorMainController extends GetxController {
  var currentIndex = 0.obs;

  List<Widget> screens = [
    OperatorHomeView(),
    OperatorCarsView(),
    OperatorDriversView(),
    OperatorToursView(),
    OperatorBookingsView(),
  ];
}
