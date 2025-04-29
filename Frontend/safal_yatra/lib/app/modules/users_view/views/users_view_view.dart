import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safal_yatra/app/modules/users_view/controllers/users_view_controller.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/driverCard.dart';
import 'package:safal_yatra/components/operatorCard.dart';
import 'package:safal_yatra/components/userCard.dart';

class UsersViewView extends GetView<UsersViewController> {
  const UsersViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(UsersViewController());
    final Map<String, String>? args = Get.arguments;
    String initialTab = args?['initial_tab'] ?? 'users';
    print(initialTab);
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.buttonColor,
        automaticallyImplyLeading: false,
        title: SafeArea(
          child: Row(
            mainAxisAlignment: args?['from_home'] == 'true'
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              Visibility(
                visible: args?['from_home'] == 'true',
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              const Text(
                'User Details',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(
                  width: args?['from_home'] == 'true' ? 0 : Get.width / 25),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getUsers();
          await controller.getOperators();
          await controller.getDrivers();
          //await controller.getAdmins();
        },
        child: GetBuilder<UsersViewController>(
          builder: (controller) {
            if (controller.allDriverResponse == null &&
                controller.allUserResponse == null &&
                controller.allOperatorResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var allUsers = controller.allUserResponse?.allUsers?.toList() ?? [];
            var allOperators =
                controller.allOperatorResponse?.allOperators?.toList() ?? [];
            var allDrivers =
                controller.allDriverResponse?.allDrivers?.toList() ?? [];
            // var allAdmins =
            //     controller.allAdminResponse?.allAdmins?.toList() ?? [];

            return DefaultTabController(
                length: 3,
                initialIndex: initialTab == 'operators'
                    ? 1
                    : (initialTab == 'drivers' ? 2 : 0),
                child: Column(
                  children: [
                    const TabBar(
                        labelStyle: TextStyle(
                          color: AppColors.buttonColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          fontSize: 20,
                        ),
                        tabs: [
                          Tab(
                            text: 'Users',
                          ),
                          Tab(
                            text: 'Operators',
                          ),
                          Tab(
                            text: 'Drivers',
                          ),
                          // Tab(
                          //   text: 'Admins',
                          // )
                        ]),
                    Expanded(
                      child: TabBarView(children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: allUsers.length,
                          itemBuilder: (context, index) => AllUserCard(
                            allUser: allUsers[index],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: allOperators.length,
                          itemBuilder: (context, index) => AllOperatorCard(
                            allOperator: allOperators[index],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: allDrivers.length,
                          itemBuilder: (context, index) => AllDriverCard(
                            allDriver: allDrivers[index],
                          ),
                        ),
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   itemCount: allAdmins.length,
                        //   itemBuilder: (context, index) => AllAdminCard(
                        //     allAdmin: allAdmins[index],
                        //   ),
                        // ),
                      ]),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}
