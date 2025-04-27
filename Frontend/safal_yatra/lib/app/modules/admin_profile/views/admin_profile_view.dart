import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';

import '../controllers/admin_profile_controller.dart';

class AdminProfileView extends GetView<AdminProfileController> {
  const AdminProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final coverHeight = Get.height / 6;
    final profileHeight = Get.height / 15;
    final top = coverHeight - profileHeight;
    Get.put(AdminProfileController());
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2FA),
      body: GetBuilder<AdminProfileController>(
        builder: (controller) {
          if (controller.adminProfileResponse == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var admin = controller.adminProfileResponse!.admins!;
          return Column(
            children: [
              Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: AppColors.buttonColor,
                      height: coverHeight,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: top,
                      child: CircleAvatar(
                          radius: profileHeight,
                          backgroundColor: Colors.grey.shade800,
                          child: admin.imageUrl != null
                              ? ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(profileHeight),
                                  child: Image.network(
                                    getImageUrl(admin.imageUrl!),
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Text(
                                  admin.adminName![0].toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 40, color: Colors.white),
                                )),
                    )
                  ]),
              const SizedBox(height: 70.0),
              SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: Get.height * 0.66,
                    ),
                    child: Column(children: [
                      Text(
                        admin.adminName ?? '',
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        admin.email!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                        ),
                      ),
                      // Text(
                      //   user.contactNumber ?? 'N/A',
                      //   style: const TextStyle(fontSize: 15, fontFamily: 'Inter'),
                      // ),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.EDIT_ADMIN, arguments: admin);
                        },
                        child: Container(
                          width: Get.width * 0.91,
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width / 80,
                            vertical: Get.height / 130,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromRGBO(63, 93, 169, 255),
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  MdiIcons.accountEdit,
                                  size: 30,
                                  color: AppColors.buttonColor,
                                ),
                                onPressed: () {},
                              ),
                              const Expanded(
                                child: Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 35, 35, 35),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromARGB(255, 202, 199, 199),
                                ), // Arrow icon
                                onPressed: () {
                                  Get.toNamed(Routes.EDIT_ADMIN,
                                      arguments: admin);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD),
                        child: Container(
                          width: Get.width * 0.91,
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width / 80,
                            vertical: Get.height / 130,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromRGBO(63, 93, 169, 255),
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  MdiIcons.lockReset,
                                  size: 28,
                                  color: AppColors.buttonColor,
                                ), // Edit icon
                                onPressed: () {},
                              ),
                              const Expanded(
                                child: Text(
                                  "Change Password",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 35, 35, 35),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromARGB(255, 202, 199, 199),
                                ), // Arrow icon
                                onPressed: () {
                                  Get.toNamed(Routes.CHANGE_PASSWORD);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.ADMIN_BOOKINGS);
                        },
                        child: GestureDetector(
                          onTap: () => Get.toNamed(Routes.ADMIN_BOOKINGS),
                          child: Container(
                            width: Get.width * 0.91,
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width / 80,
                              vertical: Get.height / 130,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color.fromRGBO(63, 93, 169, 255),
                              ),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.work_history,
                                    size: 24,
                                    color: AppColors.buttonColor,
                                  ), // Edit icon
                                  onPressed: () {},
                                ),
                                const Expanded(
                                  child: Text(
                                    "Booking",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 35, 35, 35),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                    color: Color.fromARGB(255, 202, 199, 199),
                                  ), // Arrow icon
                                  onPressed: () {
                                    Get.toNamed(Routes.ADMIN_BOOKINGS);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.PAYMENTS,
                            arguments: 'from_profile'),
                        child: Container(
                          width: Get.width * 0.91,
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width / 80,
                            vertical: Get.height / 130,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromRGBO(63, 93, 169, 255),
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  MdiIcons.cashCheck,
                                  size: 30,
                                  color: AppColors.buttonColor,
                                ), // Edit icon
                                onPressed: () {},
                              ),
                              const Expanded(
                                child: Text(
                                  "Payments",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 35, 35, 35),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromARGB(255, 202, 199, 199),
                                ), // Arrow icon
                                onPressed: () {
                                  Get.toNamed(Routes.PAYMENTS,
                                      arguments: 'from_profile');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      GestureDetector(
                        onTap: () {
                          showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: MaterialLocalizations.of(context)
                                .modalBarrierDismissLabel,
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            pageBuilder: (BuildContext buildContext,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return Center(
                                child: ScaleTransition(
                                  scale: CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOut,
                                  ),
                                  child: AlertDialog(
                                    backgroundColor: AppColors.backGroundColor,
                                    title: const Text(
                                      "Logout Confirmation",
                                      style: TextStyle(
                                          fontFamily: 'Inter', fontSize: 20),
                                    ),
                                    content: const Text(
                                      "Are you sure you want to logout?",
                                      style: TextStyle(
                                          fontFamily: 'Inter', fontSize: 14),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.close(1);
                                        },
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: AppColors.buttonColor),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Memory.clear();
                                          Get.offAllNamed(
                                              Routes.BOARDING_SCREEN);
                                        },
                                        child: const Text(
                                          "Confirm",
                                          style: TextStyle(
                                              color: AppColors.buttonColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            transitionBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return FadeTransition(
                                opacity: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOut,
                                ),
                                child: child,
                              );
                            },
                          );
                        },
                        child: Container(
                          width: Get.width * 0.91,
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width / 80,
                            vertical: Get.height / 130,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromRGBO(63, 93, 169, 255),
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  MdiIcons.logout,
                                  size: 30,
                                  color: AppColors.buttonColor,
                                ), // Edit icon
                                onPressed: () {},
                              ),
                              const Expanded(
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 35, 35, 35),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromARGB(255, 202, 199, 199),
                                ), // Arrow icon
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  )),
            ],
          );
        },
      ),
    );
  }
}
