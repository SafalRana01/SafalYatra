import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safal_yatra/app/models/getMyDrivers.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/utils/constant.dart';

import '../controllers/operator_drivers_controller.dart';

class OperatorDriversView extends GetView<OperatorDriversController> {
  var showBackArrow = Get.arguments;
  OperatorDriversView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Get.put(OperatorDriversController());

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.buttonColor,
        automaticallyImplyLeading: false,
        title: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: showBackArrow == 'from_home',
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
              Text(
                'Driver Details',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Inter",
                ),
              ),
              Visibility(
                  visible: showBackArrow == 'from_home',
                  child: const SizedBox(width: 40)),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.showMyDrivers();
        },
        child: GetBuilder<OperatorDriversController>(
          builder: (controller) {
            if (controller.drivers == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.buttonColor,
                ),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: Get.height * 0.9,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    ListView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling for inner ListView
                      shrinkWrap:
                          true, // Make sure it doesn't occupy unnecessary space
                      itemCount: controller.drivers?.myDrivers?.length ?? 0,
                      itemBuilder: (context, index) => AllDriverCard(
                        allDriver: controller.drivers!.myDrivers![index],
                        showDeleteButton:
                            true, // Show delete button only for available drivers
                        onDelete: (driverId) {
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
                                      "Delete Confirmation",
                                      style: TextStyle(
                                          fontFamily: 'Inter', fontSize: 20),
                                    ),
                                    content: const Text(
                                      'Do you really want to delete this driver?',
                                      style: TextStyle(
                                          fontFamily: 'Inter', fontSize: 14),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.close(1);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.onDeleteDriver(driverId);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          backgroundColor:
                                              AppColors.buttonColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
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

                        onRestore: (driverId) {
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
                                      "Restore Confirmation",
                                      style: TextStyle(
                                          fontFamily: 'Inter', fontSize: 20),
                                    ),
                                    content: const Text(
                                      'Do you really want to restore this driver?',
                                      style: TextStyle(
                                          fontFamily: 'Inter', fontSize: 14),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.close(1);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.onRestoreDriver(driverId);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          backgroundColor:
                                              AppColors.buttonColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          'Restore',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
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
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.buttonColor,
        onPressed: () {
          Get.toNamed(Routes.ADD_DRIVER);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class AllDriverCard extends StatelessWidget {
  final MyDriver allDriver;
  final bool
      showDeleteButton; // Add a boolean to decide whether to show delete button
  final Function(String)?
      onDelete; // Function to be called when delete button is pressed
  final Function(String)? onRestore;

  const AllDriverCard({
    Key? key,
    required this.allDriver,
    this.showDeleteButton = false, // Default to false
    this.onDelete,
    this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    final profileHeight = Get.height / 40;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color.fromRGBO(63, 93, 169, 255),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(height: Get.height / 50),
                          CircleAvatar(
                              radius: profileHeight,
                              backgroundColor: Colors.grey.shade800,
                              child: allDriver.imageUrl != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(profileHeight),
                                      child: Image.network(
                                        getImageUrl(allDriver.imageUrl!),
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Text(
                                      allDriver.driverName![0].toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 24, color: Colors.white),
                                    )),
                          SizedBox(
                            width: Get.width / 20,
                          ),
                          Expanded(
                            child: Text(
                              allDriver.driverName ?? '',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Inter"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (allDriver.status == 'Available') {
                          if (onDelete != null) {
                            onDelete!(allDriver
                                .driverId!); // Pass driverId to onDelete
                          }
                        } else if (allDriver.status == 'Unavailable') {
                          if (onRestore != null) {
                            onRestore!(allDriver
                                .driverId!); // Pass driverId to onRestore
                          }
                        }
                      },
                      icon: Icon(
                        allDriver.status == 'Available'
                            ? Icons.delete
                            : Icons.restore,
                        size: 28,
                        color: allDriver.status == 'Available'
                            ? AppColors.buttonColor
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Expanded(
                      // Expanded widget to take remaining space
                      child: Text(
                        'Contact Number:',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inter",
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 40),
                    Text(
                      allDriver.phoneNumber ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      // Expanded widget to take remaining space
                      child: Text(
                        'Email:',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inter",
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 40),
                    Text(
                      allDriver.email ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ), // Add vertical spacing between rows
                Row(
                  children: [
                    const Expanded(
                      // Expanded widget to take remaining space
                      child: Text(
                        'License Number:',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inter",
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 40),
                    Text(
                      allDriver.licenseNumber ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      // Expanded widget to take remaining space
                      child: Text(
                        'Added Date:',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inter",
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 40),
                    Text(
                      allDriver.addedDate != null
                          ? DateFormat('yyyy-MMM-dd')
                              .format(allDriver.addedDate!)
                          : '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
