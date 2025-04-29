import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:safal_yatra/app/modules/UserHome/controllers/user_home_controller.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/customDate.dart';
import 'package:safal_yatra/utils/constant.dart';

import '../controllers/available_cars_controller.dart';

class AvailableCarsView extends GetView<AvailableCarsController> {
  final UserHomeController homeController = Get.find<UserHomeController>();
  AvailableCarsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.buttonColor,
        automaticallyImplyLeading: false,
        title: SafeArea(
          child: Column(
            children: [
              Row(
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
                    'Car Availables',
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
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          homeController.pickUpDate.value != null
                              ? formatDate(homeController.pickUpDate.value!)
                              : "Select Date",
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                          ),
                        ),
                        SizedBox(width: Get.width / 20),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: Get.width / 20),
                        Text(
                          homeController.dropOffDate.value != null
                              ? formatDate(homeController.dropOffDate.value!)
                              : "Select Date",
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.penToSquare,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.showAvailableCars();
        },
        child: GetBuilder<AvailableCarsController>(builder: (controller) {
          if (controller.availableCarsResponse == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.buttonColor,
              ),
            );
          }

          return Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                // Apply bouncing scroll physics

                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: Get.height * 0.9,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                            height: 35,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemCount: (controller.categoriesResponse
                                          ?.categories?.length ??
                                      0) +
                                  1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                String categoryName;
                                bool isSelected;

                                if (index == 0) {
                                  categoryName = "All Models";
                                  isSelected =
                                      controller.selectedCategory.value.isEmpty;
                                } else {
                                  categoryName = controller
                                          .categoriesResponse
                                          ?.categories?[index - 1]
                                          ?.categoryName ??
                                      '';
                                  isSelected =
                                      controller.selectedCategory.value ==
                                          categoryName;
                                }

                                return GestureDetector(
                                  onTap: () {
                                    controller.selectCategory(
                                        index == 0 ? '' : categoryName);
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.orange
                                          : Color(0xFF256DAB),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        categoryName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.availableCarsResponse?.listCars
                                ?.where((car) =>
                                    controller.selectedCategory.value.isEmpty ||
                                    car.categoryName ==
                                        controller.selectedCategory.value)
                                .length ??
                            0,
                        itemBuilder: (context, index) {
                          var filteredCars = controller
                              .availableCarsResponse?.listCars
                              ?.where((car) =>
                                  controller.selectedCategory.value.isEmpty ||
                                  car.categoryName ==
                                      controller.selectedCategory.value)
                              .toList();

                          var car = filteredCars![index];
                          var totalDay = homeController.selectedDays.value;
                          var totalPrice = totalDay *
                              (double.tryParse(car.ratePerHours!) ?? 0);
                          // Convert to int if no decimal places, otherwise keep it as double
                          String formattedPrice = totalPrice % 1 == 0
                              ? totalPrice.toInt().toString()
                              : totalPrice.toString();

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.SELECTED_CAR,
                                    arguments: car);
                              },
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
                                      car.name.toString(),
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
                                          getImageUrl(car.imageUrl ?? ''),
                                          height: 88,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: 30),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                      car.seatingCapacity
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFB3B3B3),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            "RobotoCondensed",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 10),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      MdiIcons
                                                          .bagSuitcaseOutline,
                                                      size: 20,
                                                      color: Color(0xFFB3B3B3),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      car.luggageCapacity
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFB3B3B3),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            "RobotoCondensed",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                      car.numberOfDoors
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFB3B3B3),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            "RobotoCondensed",
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
                                                      car.fuelType.toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFB3B3B3),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            "RobotoCondensed",
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
                                        Container(
                                          width: 56,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF57C00),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    width: Get.width / 200),
                                                Text(
                                                  '${car.categoryName}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          width: 56,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF256DAB),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.star,
                                                    color: Colors.white,
                                                    size: 20),
                                                SizedBox(
                                                    width: Get.width / 200),
                                                Text(
                                                  car.rating ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Aligns content to the start
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start, // Aligns texts vertically
                                              children: [
                                                SizedBox(
                                                  width:
                                                      40, // Adjust width to match label length
                                                  child: Text(
                                                    'Price: ',
                                                    style: TextStyle(
                                                      color: Color(0xFFB3B3B3),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily:
                                                          "RobotoCondensed",
                                                    ),
                                                  ),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily:
                                                          "RobotoCondensed",
                                                      color: Colors.black,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            'Rs.${car.ratePerHours.toString()}', // Ensures no decimals
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .buttonColor,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ' /day',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFB3B3B3),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              "RobotoCondensed",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      40, // Same width as Price label
                                                  child: Text(
                                                    'Total: ',
                                                    style: TextStyle(
                                                      color: Color(0xFFB3B3B3),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily:
                                                          "RobotoCondensed",
                                                    ),
                                                  ),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily:
                                                          "RobotoCondensed",
                                                      color: Colors.black,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '${totalDay.toString()} days ',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFB3B3B3),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              "RobotoCondensed",
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            '(Rs.${formattedPrice.toString()})',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .buttonColor,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 15),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Comment for sortby features where code start from (599 - 693)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: 145,
                    height: 45,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20), // Curved top
                            ),
                          ),
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.52, // Adjust height, keeping some gap at the top
                                  width: double.infinity, // Full width
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Sort By",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Divider(),
                                      buildMenuItem(
                                          context,
                                          setState,
                                          'price_low_high',
                                          'Price (Low to High)'),
                                      buildMenuItem(
                                          context,
                                          setState,
                                          'price_high_low',
                                          'Price (High to Low)'),
                                      buildMenuItem(
                                          context,
                                          setState,
                                          'passenger_capacity_few_many',
                                          'Passenger Capacity (Few to Many)'),
                                      buildMenuItem(
                                          context,
                                          setState,
                                          'passenger_capacity_many_few',
                                          'Passenger Capacity (Many to Few)'),
                                      buildMenuItem(
                                          context,
                                          setState,
                                          'rating_high_low',
                                          'Rating (High to Low)'),
                                      buildMenuItem(
                                          context,
                                          setState,
                                          'rating_low_high',
                                          'Rating (Low to High)'),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      label: Row(
                        children: [
                          Icon(Icons.sort, color: Colors.black),
                          SizedBox(width: 8),
                          Text("Sort By",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

Widget buildMenuItem(
    BuildContext context, StateSetter setState, String value, String text) {
  final controller = Get.find<AvailableCarsController>();
  return ListTile(
    title: Text(text),
    trailing: controller.selectedItem == value
        ? Icon(Icons.check_circle,
            color: Colors.orange) // Show tick if selected
        : null,
    onTap: () {
      setState(() {
        controller.selectedItem = value; // Update selected item
      });
      controller.sortCars(value);
      Navigator.pop(context);
    },
  );
}
