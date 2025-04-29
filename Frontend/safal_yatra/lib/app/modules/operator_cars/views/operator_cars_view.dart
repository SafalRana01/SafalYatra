import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/customDate.dart';
import 'package:safal_yatra/utils/constant.dart';

import '../controllers/operator_cars_controller.dart';

class OperatorCarsView extends GetView<OperatorCarsController> {
  var showBackArrow = Get.arguments;
  OperatorCarsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OperatorCarsController());
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
                'My Cars',
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
          await controller.showMyCars();
        },
        child: GetBuilder<OperatorCarsController>(
          builder: (controller) {
            if (controller.cars == null) {
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
                                  padding: EdgeInsets.symmetric(horizontal: 15),
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
                      height: 08,
                    ),
                    ListView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling for inner ListView
                      shrinkWrap:
                          true, // Make sure it doesn't occupy unnecessary space
                      itemCount: controller.cars?.myCars?.length ?? 0,
                      itemBuilder: (context, index) {
                        var car = controller.cars!.myCars![index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
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
                                                  car.seatingCapacity
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Color(0xFFB3B3B3),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
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
                                                  MdiIcons.bagSuitcaseOutline,
                                                  size: 20,
                                                  color: Color(0xFFB3B3B3),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  car.luggageCapacity
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Color(0xFFB3B3B3),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
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
                                                  car.numberOfDoors.toString(),
                                                  style: TextStyle(
                                                    color: Color(0xFFB3B3B3),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
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
                                                    color: Color(0xFFB3B3B3),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
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
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Aligns content to the start
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Aligns texts vertically
                                          children: [
                                            Text(
                                              'Car Number: ',
                                              style: TextStyle(
                                                color: Color(0xFFB3B3B3),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "RobotoCondensed",
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "RobotoCondensed",
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '${car.licensePlate.toString()}', // Ensures no decimals
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.buttonColor,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
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
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "RobotoCondensed",
                                                ),
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "RobotoCondensed",
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'Rs.${car.ratePerHours.toString()}', // Ensures no decimals
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.buttonColor,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' /day',
                                                    style: TextStyle(
                                                      color: Color(0xFFB3B3B3),
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
                                        const SizedBox(height: 4),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Aligns texts vertically
                                          children: [
                                            Text(
                                              'Added Date: ',
                                              style: TextStyle(
                                                color: Color(0xFFB3B3B3),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "RobotoCondensed",
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "RobotoCondensed",
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: DateFormat(
                                                            'yyyy-MMM-dd')
                                                        .format(car.addedDate!),
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.buttonColor,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 56,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF57C00),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: Get.width / 200),
                                            Text(
                                              '${car.categoryName.toString()}',
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.white, size: 20),
                                            SizedBox(width: Get.width / 200),
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
                                  ],
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                          ),
                        );
                      },
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
          Get.toNamed(Routes.ADD_CAR);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
