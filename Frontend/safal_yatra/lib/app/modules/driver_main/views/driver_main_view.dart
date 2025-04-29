import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safal_yatra/components/appColors.dart';

import '../controllers/driver_main_controller.dart';

class DriverMainView extends GetView<DriverMainController> {
  const DriverMainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.screens[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10.0,
          iconSize: 24.0,
          selectedFontSize: 15.0,
          unselectedFontSize: 14.0,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.buttonColor,
          unselectedItemColor: Colors.black,
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.currentIndex.value = index;
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),

            // BottomNavigationBarItem(
            //   icon: Icon(Icons.notifications),
            //   label: 'Notifications',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
