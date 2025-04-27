import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/app/modules/admin_home/views/admin_home_view.dart';
import 'package:safal_yatra/app/modules/admin_profile/views/admin_profile_view.dart';
import 'package:safal_yatra/app/modules/all_admins/views/all_admins_view.dart';
import 'package:safal_yatra/app/modules/categories/views/categories_view.dart';
import 'package:safal_yatra/app/modules/users_view/views/users_view_view.dart';

class AdminMainController extends GetxController {
  var currentIndex = 0.obs;

  List<Widget> screens = [
    AdminHomeView(),
    CategoriesView(),
    AllAdminsView(),
    UsersViewView(),
    AdminProfileView(),
  ];
}
