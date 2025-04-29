import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safal_yatra/app/models/getAvailableTourPackage.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/customDate.dart';

import '../controllers/operator_tour_booking_controller.dart';

class OperatorTourBookingView extends GetView<OperatorTourBookingController> {
  const OperatorTourBookingView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OperatorTourBookingController());
    final tourBookingDetails = Get.arguments as AvailableTourPackage;
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
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
                  Text(
                    '${tourBookingDetails.packageName ?? ''} Tour',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Inter",
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Rs.${tourBookingDetails.price ?? ''}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: ' /person',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
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
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${tourBookingDetails.availableCapacity ?? ''} / ${tourBookingDetails.tourCapacity ?? ''}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.userBookedTourResponse;
        },
        child: GetBuilder<OperatorTourBookingController>(
          builder: (controller) {
            if (controller.userBookedTourResponse == null) {
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
                              .userBookedTourResponse?.tourBookings?.length ??
                          0,
                      itemBuilder: (context, index) {
                        var tour = controller
                            .userBookedTourResponse!.tourBookings![index];

                        double totalPrice =
                            double.tryParse(tour.total ?? '0') ?? 0.0;
                        double perPersonPrice =
                            double.tryParse(tourBookingDetails.price ?? '1') ??
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
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Booked By:',
                                          style: TextStyle(
                                            color: AppColors.buttonColor,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "RobotoCondensed",
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: const Text(
                                                'Full Name:',
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
                                              '${tour.fullName ?? ''}',
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
                                                'Contact Nummber:',
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
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: const Text(
                                                'Email:',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Inter",
                                                  color: Color.fromARGB(
                                                      255, 86, 85, 85),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${tour.email ?? ''}',
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
                                        const SizedBox(height: 5),
                                        Divider(),
                                        const SizedBox(height: 5),
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
                                              'Rs.${tour.total ?? ''}',
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
                                                'Booking Date:',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Inter",
                                                  color: Color.fromARGB(
                                                      255, 86, 85, 85),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              tour.bookingDate != null
                                                  ? DateFormat('yyyy-MMM-dd')
                                                      .format(tour.bookingDate!)
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
