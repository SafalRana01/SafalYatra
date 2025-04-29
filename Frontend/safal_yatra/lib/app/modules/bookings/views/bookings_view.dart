import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:safal_yatra/app/models/getMyBookings.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/customDate.dart';
import 'package:safal_yatra/utils/constant.dart';

import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  // Retrieve the arguments passed to the view (it will be a map)
  final Map<String, dynamic> entryPoint =
      Get.arguments ?? {}; // Default to an empty map if no arguments passed

  BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BookingsController());

    // Correctly check the values of 'from_flow' and 'from_profile' in the entryPoint map
    final bool fromFlow =
        entryPoint['from_flow'] == true; // Check if 'from_flow' is true
    final bool fromProfile =
        entryPoint['from_profile'] == true; // Check if 'from_profile' is true
    final bool showBack =
        fromFlow || fromProfile; // Show back arrow if either condition is true

    print(
        "showBack: $showBack"); // Debugging line to check the value of showBack

    return Scaffold(
      backgroundColor: const Color(0xFFF3F2FA),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.buttonColor,
        automaticallyImplyLeading:
            false, // Ensure we're controlling the back button manually
        title: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Show back arrow based on the flag
              showBack
                  ? GestureDetector(
                      onTap: () {
                        if (fromFlow) {
                          // After booking flow → go home and clear stack
                          Get.offAllNamed(Routes.MAIN_SCREEN);
                        } else {
                          // From profile/nav → just pop back
                          Get.back();
                        }
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                    )
                  : const SizedBox.shrink(),
              const Text(
                'My Bookings',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Inter",
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
      body: GetBuilder<BookingsController>(builder: (controller) {
        if (controller.bookingResponse == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var upcomingBooking = controller.bookingResponse?.bookings
                ?.where((booking) =>
                    isFuture(booking.endDate!) && booking.status == 'Success')
                .toList() ??
            [];
        var completedBooking = controller.bookingResponse?.bookings
                ?.where((booking) =>
                    isPast(booking.endDate!) && booking.status == 'Success')
                .toList() ??
            [];

        var cancelledBooking = controller.bookingResponse?.bookings
                ?.where((booking) => booking.status == 'Cancelled')
                .toList() ??
            [];

        return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                    labelStyle: const TextStyle(
                      // color: AppColors.buttonColor,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      fontSize: 18,
                    ),
                    // indicator: UnderlineTabIndicator(
                    //   borderSide: const BorderSide(
                    //     color: AppColors.buttonColor, // Orange underline
                    //     width: 3.0, // Thickness
                    //   ),
                    //   insets: const EdgeInsets.symmetric(
                    //       horizontal: 0.001), // Makes underline longer
                    //   borderRadius: BorderRadius.circular(8.0), // Curved ends
                    // ),
                    tabs: const [
                      Tab(
                        text: 'Upcoming',
                      ),
                      Tab(
                        text: 'Completed',
                      ),
                      Tab(
                        text: 'Cancelled',
                      ),
                    ]),
                Expanded(
                  child: TabBarView(children: [
                    upcomingBooking.isEmpty
                        ? Center(
                            child: Text(
                              'No Upcoming Booking Available',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                                color: Colors.grey, // Adjust color as needed
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: upcomingBooking.length,
                            itemBuilder: (context, index) => BookingCard(
                              booking: upcomingBooking[index],
                              isUpcoming: 'true',
                            ),
                          ),
                    completedBooking.isEmpty
                        ? Center(
                            child: Text(
                              'No Completed Booking Available',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                                color: Colors.grey, // Adjust color as needed
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: completedBooking.length,
                            itemBuilder: (context, index) => BookingCard(
                              booking: completedBooking[index],
                              isUpcoming: 'false',
                            ),
                          ),
                    cancelledBooking.isEmpty
                        ? Center(
                            child: Text(
                              'No Cancelled Booking Available',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                                color: Colors.grey, // Adjust color as needed
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: cancelledBooking.length,
                            itemBuilder: (context, index) => BookingCard(
                              booking: cancelledBooking[index],
                              isUpcoming: 'neither',
                            ),
                          )
                  ]),
                )
              ],
            ));
      }),
    );
  }
}

bool isFuture(DateTime date) {
  final now = DateTime.now();
  return date.isAfter(now) || isToday(date);
}

bool isPast(DateTime date) {
  final now = DateTime.now();
  return date.isBefore(now) && !isToday(date);
}

bool isToday(DateTime date) {
  final now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}

class BookingCard extends StatelessWidget {
  final Booking booking;
  final String isUpcoming;
  const BookingCard({super.key, required this.booking, this.isUpcoming = ''});
  int calculateDays() {
    if (booking.startDate != null && booking.endDate != null) {
      return (booking.endDate!.difference(booking.startDate!).inDays) + 1;
    }
    return 0; // Default value if dates are null
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
            Row(
              children: [
                Text(
                  booking.name.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.values[5],
                      fontFamily: "RobotoCondensed"),
                ),
                Spacer(),
                Text(
                  booking.licensePlate.toString(),
                  style: TextStyle(
                      color: AppColors.buttonColor,
                      fontSize: 20,
                      fontWeight: FontWeight.values[5],
                      fontFamily: "RobotoCondensed"),
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Image.network(
                  getImageUrl(booking.imageUrl ?? ''),
                  height: 88,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              booking.seatingCapacity.toString(),
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
                              booking.luggageCapacity.toString(),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              booking.numberOfDoors.toString(),
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
                              booking.fuelType.toString(),
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
                      booking.startDate != null
                          ? formatDate(booking.startDate!)
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
                      "${calculateDays().toString()} Days",
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
                      booking.endDate != null
                          ? formatDate(booking.endDate!)
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
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Driver Name:',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Inter",
                      color: Color.fromARGB(255, 86, 85, 85),
                    ),
                  ),
                ),
                SizedBox(width: Get.width / 18),
                Text(
                  booking.driverName ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Driver Contact:',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Inter",
                      color: Color.fromARGB(255, 86, 85, 85),
                    ),
                  ),
                ),
                SizedBox(width: Get.width / 18),
                Text(
                  booking.phoneNumber ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Visibility(
                visible: isUpcoming == 'neither',
                child: const SizedBox(height: 2)),
            Visibility(
              visible: isUpcoming == 'neither',
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Status:',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Inter",
                        color: Color.fromARGB(255, 86, 85, 85),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width / 40),
                  Text(
                    booking.status ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
                visible: isUpcoming == 'true',
                child: const SizedBox(height: 10)),
            if (isUpcoming == 'true')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Cancel Booking",
                              style: TextStyle(color: Colors.red),
                            ),
                            content: SizedBox(
                              height: Get.height /
                                  20, // Set the desired height here
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Are you sure you want to cancel?"),
                                  Text(
                                    "Note: There will be no refund!",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Get.close(1);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.find<BookingsController>()
                                      .cancelBooking(booking.bookingId!);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Cancel Booking',
                      style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            Visibility(
                visible: isUpcoming == 'false',
                child: const SizedBox(height: 10)),
            if (isUpcoming == 'false')
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return RatingDialog(
                          carId: booking.carId ?? '',
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Give Rating',
                    style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class RatingDialog extends StatelessWidget {
  final String carId;
  const RatingDialog({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    var bookingsController = Get.find<BookingsController>();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Give Rating',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                bookingsController.selectedRating = rating;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize:
                  MainAxisSize.min, // <- Important! Dialog won't stretch
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back(); // Just close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Smaller gap between buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      bookingsController.giveRating(carId);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
