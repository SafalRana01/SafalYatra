import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/customDate.dart';
import 'package:safal_yatra/utils/constant.dart';
import '../controllers/user_tour_booking_controller.dart';

class UserTourBookingView extends GetView<UserTourBookingController> {
  UserTourBookingView({Key? key}) : super(key: key);

  // read the flag; defaults to false if nothing was passed
  final bool showBackArrow = Get.arguments?['fromFlow'] == true;
  @override
  Widget build(BuildContext context) {
    Get.put(UserTourBookingController());
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.buttonColor,
        automaticallyImplyLeading: false,

        // Reserve space for a leading widget so the title stays centered
        leadingWidth: 56,

        // Only show the back arrow when you’re coming from the flow
        leading: showBackArrow
            ? IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 25),
                onPressed: () => Get.offAllNamed(Routes.MAIN_SCREEN),
              )
            : const SizedBox(), // empty box of width 56 by leadingWidth

        centerTitle: true, // center the title in the AppBar
        title: const Text(
          'Tour Bookings History',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter",
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.tourBookingResponse;
        },
        child: GetBuilder<UserTourBookingController>(
          builder: (controller) {
            if (controller.tourBookingResponse == null) {
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
                              .tourBookingResponse?.tourBookings?.length ??
                          0,
                      itemBuilder: (context, index) {
                        var tour = controller
                            .tourBookingResponse!.tourBookings![index];

                        double totalPrice =
                            double.tryParse(tour.total ?? '0') ?? 0.0;
                        double perPersonPrice =
                            double.tryParse(tour.perPersonPrice ?? '1') ??
                                0.0; // Default to 1.0

                        double numberOfPeople = totalPrice / perPersonPrice;

                        String formattedNumberOfPeople = numberOfPeople % 1 == 0
                            ? numberOfPeople.toInt().toString()
                            : numberOfPeople.toStringAsFixed(
                                2); // Limits to 2 decimal places

                        print(formattedNumberOfPeople);

                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
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
                                      getImageUrl(tour.tourImageUrl ?? ''),
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
                                            Spacer(),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'Rs.${tour.perPersonPrice ?? ''}',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColors.buttonColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' /person',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFFB3B3B3),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
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
                                                    fontWeight: FontWeight.w600,
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
                                                  "${tour.duration} Days",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
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
                                                    fontWeight: FontWeight.w600,
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
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Inter",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        const Divider(),
                                        const SizedBox(
                                          height: 6,
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
                                        const SizedBox(height: 4),
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
                                        const SizedBox(height: 4),
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
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: const Text(
                                                'Total People:',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Inter",
                                                  color: Color.fromARGB(
                                                      255, 86, 85, 85),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${formattedNumberOfPeople ?? ''}',
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
                                        Row(
                                          children: [
                                            Expanded(
                                              child: const Text(
                                                'Total Amount Paid:',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Inter",
                                                  color: Color.fromARGB(
                                                      255, 86, 85, 85),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${tour.total ?? ''}',
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
                                        const SizedBox(height: 6),
                                        Divider(),
                                        const SizedBox(height: 6),
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
                                        const SizedBox(height: 4),
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
                                              '${tour.phoneNumber ?? ''}',
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
                                      ],
                                    ),
                                  ),
                                ],
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
    );
  }
}
