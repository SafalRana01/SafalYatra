import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/adminCard.dart';
import 'package:safal_yatra/components/appColors.dart';

import '../controllers/all_admins_controller.dart';

class AllAdminsView extends GetView<AllAdminsController> {
  const AllAdminsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AllAdminsController());
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.buttonColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Admin Details',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter",
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.getAdmins();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: GetBuilder<AllAdminsController>(builder: (controller) {
              if (controller.allAdminResponse == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: Get.height * 0.9,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          controller.allAdminResponse?.allAdmins?.length ?? 0,
                      itemBuilder: (context, index) {
                        return AllAdminCard(
                          allAdmin:
                              controller.allAdminResponse!.allAdmins![index],
                        );
                      },
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.buttonColor,
        onPressed: () {
          Get.toNamed(Routes.ADD_ADMIN);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
