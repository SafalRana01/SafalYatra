import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/driver_profile_controller.dart';

class DriverProfileView extends GetView<DriverProfileController> {
  const DriverProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final coverHeight = Get.height / 6;
    final profileHeight = Get.height / 15;
    final top = coverHeight - profileHeight;
    Get.put(DriverProfileController());
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2FA),
      body: GetBuilder<DriverProfileController>(
        builder: (controller) {
          if (controller.driverResponse == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var driver = controller.driverResponse!.driver!;
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
                          child: driver.imageUrl != null
                              ? ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(profileHeight),
                                  child: Image.network(
                                    getImageUrl(driver.imageUrl!),
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Text(
                                  driver.driverName![0].toUpperCase(),
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
                        driver.driverName ?? '',
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        driver.email!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        driver.operatorName!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.buttonColor,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.EDIT_DRIVER, arguments: driver);
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
                                ), // Edit icon
                                onPressed: () {
                                  // Add your edit functionality here
                                },
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
                                  Get.toNamed(Routes.EDIT_DRIVER,
                                      arguments: driver);
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
                                onPressed: () {
                                  // Add your edit functionality here
                                },
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.warning_amber_rounded,
                                            color: Colors.red, size: 22),
                                        SizedBox(width: 6),
                                        Text("Emergency Call",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: const Icon(Icons.close,
                                          color: Colors.red, size: 24),
                                    ),
                                  ],
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Please stay calm and don't be afraid. Help is on the way. You can always rely on emergency services for assistance. Your safety is our priority, and we are here to help you.",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.green),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text("Who do you want to call?",
                                        style: TextStyle(fontSize: 14)),
                                    const SizedBox(height: 16),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              Navigator.of(context).pop();
                                              final Uri policeUri = Uri(
                                                  scheme: 'tel', path: '100');
                                              if (await canLaunchUrl(
                                                  policeUri)) {
                                                await launchUrl(policeUri,
                                                    mode: LaunchMode
                                                        .externalApplication);
                                              } else {
                                                Get.snackbar("Error",
                                                    "Could not open dialer.");
                                              }
                                            },
                                            child: Container(
                                              width: 90,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                children: const [
                                                  Icon(Icons.local_police,
                                                      color: Colors.blue,
                                                      size: 22),
                                                  SizedBox(height: 6),
                                                  Text("Police",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 13)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              Navigator.of(context).pop();
                                              final Uri ambulanceUri = Uri(
                                                  scheme: 'tel', path: '102');
                                              if (await canLaunchUrl(
                                                  ambulanceUri)) {
                                                await launchUrl(ambulanceUri,
                                                    mode: LaunchMode
                                                        .externalApplication);
                                              } else {
                                                Get.snackbar("Error",
                                                    "Could not open dialer.");
                                              }
                                            },
                                            child: Container(
                                              width: 90,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                children: const [
                                                  Icon(Icons.local_hospital,
                                                      color: Colors.red,
                                                      size: 22),
                                                  SizedBox(height: 6),
                                                  Text("Ambulance",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 13)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              Navigator.of(context).pop();
                                              final Uri fireUri = Uri(
                                                  scheme: 'tel', path: '101');
                                              if (await canLaunchUrl(fireUri)) {
                                                await launchUrl(fireUri,
                                                    mode: LaunchMode
                                                        .externalApplication);
                                              } else {
                                                Get.snackbar("Error",
                                                    "Could not open dialer.");
                                              }
                                            },
                                            child: Container(
                                              width: 90,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                children: const [
                                                  Icon(
                                                      Icons
                                                          .local_fire_department,
                                                      color: Colors.orange,
                                                      size: 22),
                                                  SizedBox(height: 6),
                                                  Text("Firefighter",
                                                      style: TextStyle(
                                                          color: Colors.orange,
                                                          fontSize: 13)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                                  MdiIcons.policeBadge,
                                  size: 30,
                                  color: AppColors.buttonColor,
                                ),
                                onPressed: () async {},
                              ),
                              const Expanded(
                                child: Text(
                                  "Emergency Call",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Inter',
                                    color: Color.fromARGB(255, 35, 35, 35),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Color.fromARGB(255, 202, 199, 199),
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
                                onPressed: () {
                                  // Add your edit functionality here
                                },
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
                                onPressed: () {
                                  // Add your navigation functionality here
                                },
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
