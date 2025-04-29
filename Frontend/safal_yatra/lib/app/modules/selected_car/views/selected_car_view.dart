import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:safal_yatra/app/modules/UserHome/controllers/user_home_controller.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/customDate.dart';
import 'package:safal_yatra/components/custom_button.dart';
import 'package:safal_yatra/utils/constant.dart';

import '../controllers/selected_car_controller.dart';

class SelectedCarView extends GetView<SelectedCarController> {
  final UserHomeController homeController = Get.find<UserHomeController>();
  SelectedCarView({super.key});
  @override
  Widget build(BuildContext context) {
    final profileHeight = Get.height / 30;
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
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const Text(
                'Rent a Car',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Merriweather",
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
      body: GetBuilder<SelectedCarController>(
        builder: (controller) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: Get.height * 0.5,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
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
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            controller.selectedCar.name.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.values[5],
                                fontFamily: "RobotoCondensed"),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Image.network(
                                getImageUrl(
                                    controller.selectedCar.imageUrl ?? ''),
                                height: 88,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            PhosphorIcons.seat(),
                                            size: 20,
                                            color: Color(0xFFB3B3B3),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            controller
                                                .selectedCar.seatingCapacity
                                                .toString(),
                                            style: TextStyle(
                                              color: Color(0xFFB3B3B3),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "RobotoCondensed",
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      Row(
                                        children: [
                                          Icon(
                                            MdiIcons.bagSuitcaseOutline,
                                            size: 20,
                                            color: Color(0xFFB3B3B3),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            controller
                                                .selectedCar.luggageCapacity
                                                .toString(),
                                            style: TextStyle(
                                              color: Color(0xFFB3B3B3),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "RobotoCondensed",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            MdiIcons.carDoor,
                                            size: 20,
                                            color: Color(0xFFB3B3B3),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            controller.selectedCar.numberOfDoors
                                                .toString(),
                                            style: TextStyle(
                                              color: Color(0xFFB3B3B3),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "RobotoCondensed",
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      Row(
                                        children: [
                                          Icon(
                                            MdiIcons.gasStation,
                                            size: 20,
                                            color: Color(0xFFB3B3B3),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            controller.selectedCar.fuelType
                                                .toString(),
                                            style: TextStyle(
                                              color: Color(0xFFB3B3B3),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "RobotoCondensed",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Divider(),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Pick-up Date',
                                    style: TextStyle(
                                      color: Color(0xFFB3B3B3),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "RobotoCondensed",
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    homeController.pickUpDate.value != null
                                        ? formatDate(
                                            homeController.pickUpDate.value!)
                                        : "Select Date",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    "${homeController.selectedDays.value} Days",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward, size: 20),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    'Drop-off Date',
                                    style: TextStyle(
                                      color: Color(0xFFB3B3B3),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "RobotoCondensed",
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    homeController.dropOffDate.value != null
                                        ? formatDate(
                                            homeController.dropOffDate.value!)
                                        : "Select Date",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => controller.navigateToSelectDriverPage(),
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
                            children: [
                              IconButton(
                                icon: Icon(
                                  MdiIcons.account,
                                  size: 28,
                                  color: AppColors.buttonColor,
                                ),
                                onPressed: () {
                                  // Add your edit functionality here
                                },
                              ),
                              const Expanded(
                                child: Text(
                                  "Select Driver",
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
                                ),
                                onPressed: () {
                                  controller.navigateToSelectDriverPage();
                                },
                              ),
                            ],
                          ),
                          Obx(() {
                            if (controller.selectedDriver.value != null) {
                              final driver = controller.selectedDriver.value!;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Divider to separate sections
                                  Divider(
                                    color: Colors.grey.shade400,
                                    thickness: 1,
                                  ),
                                  // Conditionally show selected driver's details if available
                                  SizedBox(
                                      height: Get.height /
                                          60), // Space between divider and driver info

                                  Row(
                                    children: [
                                      // Driver Image
                                      CircleAvatar(
                                          radius: profileHeight,
                                          backgroundColor: Colors.grey.shade800,
                                          child: driver.imageUrl != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          profileHeight),
                                                  child: Image.network(
                                                    getImageUrl(
                                                        driver.imageUrl!),
                                                    height: 90,
                                                    width: 90,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Text(
                                                  driver.driverName![0]
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white),
                                                )),
                                      const SizedBox(width: 15),

                                      // Name & Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Driver Name
                                            Text(
                                              driver.driverName!,
                                              style: TextStyle(
                                                fontFamily: "Inika",
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 4),

                                            // Gender, Age, Experience Row
                                            Row(
                                              children: [
                                                Icon(
                                                  driver.gender!
                                                              .toLowerCase() ==
                                                          'male'
                                                      ? Icons.male
                                                      : Icons.female,
                                                  color: Colors.grey,
                                                  size: 18,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${driver.gender}, ${driver.age} yrs, ${driver.experience} yrs exp',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Selected Icon
                                      if (driver ==
                                          controller.selectedDriver.value)
                                        Icon(
                                          Icons.check_circle,
                                          color: AppColors.buttonColor,
                                          size: 24,
                                        ),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return SizedBox(); // Return an empty container when no driver is selected
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      persistentFooterButtons: [
        CustomButton(
            title: 'Book Now',
            onTap: () {
              controller.makeBooking();
            }),
      ],
    );
  }
}
