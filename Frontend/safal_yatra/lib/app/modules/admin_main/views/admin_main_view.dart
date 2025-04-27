import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:safal_yatra/components/appColors.dart';

import '../controllers/admin_main_controller.dart';

class AdminMainView extends GetView<AdminMainController> {
  const AdminMainView({Key? key}) : super(key: key);
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
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.shape),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.accountLock),
              label: 'Admins',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.accountMultiple),
              label: 'Users',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
