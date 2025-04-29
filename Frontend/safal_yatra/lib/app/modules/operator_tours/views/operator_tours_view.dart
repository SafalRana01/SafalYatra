import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/customDate.dart';
import 'package:safal_yatra/utils/constant.dart';
import 'package:safal_yatra/utils/memory.dart';

import '../controllers/operator_tours_controller.dart';

class OperatorToursView extends GetView<OperatorToursController> {
  var showBackArrow = Get.arguments;
  OperatorToursView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OperatorToursController());

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
                'Tour Packages',
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
          await controller.tourPackages;
        },
        child: GetBuilder<OperatorToursController>(
          builder: (controller) {
            if (controller.tourPackages == null) {
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
                    ListView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling for inner ListView
                      shrinkWrap:
                          true, // Make sure it doesn't occupy unnecessary space
                      itemCount: controller
                              .tourPackages?.availableTourPackages?.length ??
                          0,
                      itemBuilder: (context, index) {
                        var tour = controller
                            .tourPackages!.availableTourPackages![index];
                        var isExpanded =
                            controller.expandedList.contains(index);

                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.OPERATOR_TOUR_BOOKING,
                                    arguments: tour);
                              },
                              child: Container(
                                width: double
                                    .infinity, // Make sure the container takes full width
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
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15)),
                                      child: Image.network(
                                        getImageUrl(tour.imageUrl ?? ''),
                                        width: double
                                            .infinity, // Make the image take full width
                                        height: 180, // Adjust height as needed
                                        fit: BoxFit
                                            .cover, // Ensure the image covers the full container width
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                tour.packageName ?? '',
                                                style: TextStyle(
                                                  color: AppColors.buttonColor,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "RobotoCondensed",
                                                ),
                                              ),
                                              const Spacer(),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Get.toNamed(
                                                      Routes
                                                          .OPERATOR_TOUR_BOOKING,
                                                      arguments: tour);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  backgroundColor: Colors.green,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  minimumSize: const Size(0,
                                                      32), // Adjust height here
                                                ),
                                                child: const Text(
                                                  'View Booking Details',
                                                  style: TextStyle(
                                                    fontSize: 12.5,
                                                    color: Colors.white,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            tour.description ?? '',
                                            textAlign: TextAlign
                                                .justify, // Ensures text is justified
                                            maxLines: isExpanded
                                                ? null
                                                : 3, // Show only 5 lines initially
                                            overflow: isExpanded
                                                ? TextOverflow.visible
                                                : TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Roboto",
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          GestureDetector(
                                            onTap: () {
                                              controller.toggleExpand(index);
                                            },
                                            child: Text(
                                              isExpanded
                                                  ? "Read Less"
                                                  : "Read More",
                                              style: TextStyle(
                                                color: AppColors.buttonColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'Rs.${tour.price ?? ''}',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .buttonColor,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' /person',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFB3B3B3),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Available: ',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFB3B3B3),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${tour.availableCapacity ?? ''} / ${tour.tourCapacity ?? ''}',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: AppColors
                                                            .buttonColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'Start Date',
                                                    style: TextStyle(
                                                      color: Color(0xFFB3B3B3),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily:
                                                          "RobotoCondensed",
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    tour.startDate != null
                                                        ? formatDate(
                                                            tour.startDate!)
                                                        : '',
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Inter",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              Column(
                                                children: [
                                                  Text(
                                                    "${tour.duration} Days",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Icon(Icons.arrow_forward,
                                                      size: 20),
                                                ],
                                              ),
                                              Spacer(),
                                              Column(
                                                children: [
                                                  Text(
                                                    'End Date',
                                                    style: TextStyle(
                                                      color: Color(0xFFB3B3B3),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily:
                                                          "RobotoCondensed",
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    tour.endDate != null
                                                        ? formatDate(
                                                            tour.endDate!)
                                                        : '',
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Inter",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Divider(),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: const Text(
                                                  'Starting Location:',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: "Inter",
                                                    color: Color.fromARGB(
                                                        255, 86, 85, 85),
                                                  ),
                                                ),
                                              ),
                                              // Ensures equal spacing on both sides
                                              Text(
                                                '${tour.startLocation ?? ''}',
                                                textAlign: TextAlign
                                                    .right, // Align text to the right
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: const Text(
                                                  'Destination Location:',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: "Inter",
                                                    color: Color.fromARGB(
                                                        255, 86, 85, 85),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${tour.destination ?? ''}',
                                                textAlign: TextAlign
                                                    .right, // Align text to the right
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: const Text(
                                                  'Car Number:',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: "Inter",
                                                    color: Color.fromARGB(
                                                        255, 86, 85, 85),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${tour.licensePlate ?? ''}',
                                                textAlign: TextAlign
                                                    .right, // Align text to the right
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (Memory.getRole() == 'admin')
                                            const SizedBox(height: 2),
                                          if (Memory.getRole() == 'admin')
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: const Text(
                                                    'Package Added By:',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: "Inter",
                                                      color: Color.fromARGB(
                                                          255, 86, 85, 85),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '${tour.operatorName ?? ''}',
                                                  textAlign: TextAlign
                                                      .right, // Align text to the right
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          const SizedBox(height: 4),
                                          Divider(),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: const Text(
                                                  'Driver Name:',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: "Inter",
                                                    color: Color.fromARGB(
                                                        255, 86, 85, 85),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${tour.driverName ?? ''}',
                                                textAlign: TextAlign
                                                    .right, // Align text to the right
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: const Text(
                                                  'Driver Contact:',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: "Inter",
                                                    color: Color.fromARGB(
                                                        255, 86, 85, 85),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${tour.driverPhoneNumber ?? ''}',
                                                textAlign: TextAlign
                                                    .right, // Align text to the right
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: const Text(
                                                  'Package Added Date:',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: "Inter",
                                                    color: Color.fromARGB(
                                                        255, 86, 85, 85),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                tour.addedDate != null
                                                    ? DateFormat('yyyy-MMM-dd')
                                                        .format(tour.addedDate!)
                                                    : '',
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
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: Memory.getRole() == 'operator',
        child: FloatingActionButton(
          backgroundColor: AppColors.buttonColor,
          onPressed: () {
            Get.toNamed(Routes.ADD_TOUR_PACKAGE);
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
