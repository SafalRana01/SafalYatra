import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/customDate.dart';
import 'package:safal_yatra/utils/constant.dart';

import '../../../models/allBookings.dart';
import '../controllers/admin_bookings_controller.dart';


// Creating AdminBookingsView to display all bookings
class AdminBookingsView extends GetView<AdminBookingsController> {
  const AdminBookingsView({super.key});
  @override
  Widget build(BuildContext context) {
    // Injecting AdminBookingsController into the view
    Get.put(AdminBookingsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F2FA),
      // Creating AppBar with custom title and back button
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.buttonColor,
        automaticallyImplyLeading: false,
        title: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Adding back button to navigate to previous screen
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
                'All Bookings',
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

      // Building body using GetBuilder to update on controller changes
      body: GetBuilder<AdminBookingsController>(builder: (controller) {
        // Showing loading indicator while bookings are being fetched
        if (controller.bookingResponse == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.buttonColor,
            ),
          );
        }

// Filtering bookings with status 'Success'
        var successBooking = controller.bookingResponse?.bookings
                ?.where((booking) => booking.status == 'Success')
                .toList() ??
            [];

// Filtering bookings with status 'Cancelled'
        var cancelledBooking = controller.bookingResponse?.bookings
                ?.where((booking) => booking.status == 'Cancelled')
                .toList() ??
            [];

 // Building tab view for 'Success' and 'Cancelled' bookings
        return DefaultTabController(
            length: 2,
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
                    tabs: const [
                      Tab(
                        text: 'Success',
                      ),
                      Tab(
                        text: 'Cancelled',
                      ),
                    ]),
                Expanded(
                  // Displaying tab views for each booking type
                  child: TabBarView(children: [
                    // Listing all successful bookings
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: successBooking.length,
                      itemBuilder: (context, index) => BookingCard(
                        booking: successBooking[index],
                        isUpcoming: 'true',
                      ),
                    ),
                    // Listing all cancelled bookings
                    ListView.builder(
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
            Center(
              child: Image.network(
                getImageUrl(booking.imageUrl ?? ''),
                height: 110,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
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
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Car Owner:',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Inter",
                      color: Color.fromARGB(255, 86, 85, 85),
                    ),
                  ),
                ),
                SizedBox(width: Get.width / 18),
                Text(
                  booking.operatorName ?? '',
                  textAlign: TextAlign.right, // Align text to the right
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
                    'Booked By:',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Inter",
                      color: Color.fromARGB(255, 86, 85, 85),
                    ),
                  ),
                ),
                // Ensures equal spacing on both sides
                Text(
                  '${booking.userName ?? ''}',
                  textAlign: TextAlign.right, // Align text to the right
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
                    'Phone Number:',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Inter",
                      color: Color.fromARGB(255, 86, 85, 85),
                    ),
                  ),
                ),
                Text(
                  '${booking.userPhoneNumber ?? ''}',
                  textAlign: TextAlign.right, // Align text to the right
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
                      color: Color.fromARGB(255, 86, 85, 85),
                    ),
                  ),
                ),
                Text(
                  '${booking.userEmail ?? ''}',
                  textAlign: TextAlign.right, // Align text to the right
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
                    'Total Amount:',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Inter",
                      color: Color.fromARGB(255, 86, 85, 85),
                    ),
                  ),
                ),
                Text(
                  'Rs.${booking.total ?? ''}',
                  textAlign: TextAlign.right, // Align text to the right
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: const Text(
                    'Driver Name:',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Inter",
                      color: Color.fromARGB(255, 86, 85, 85),
                    ),
                  ),
                ),
                Text(
                  '${booking.driverName ?? ''}',
                  textAlign: TextAlign.right, // Align text to the right
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
                      color: Color.fromARGB(255, 86, 85, 85),
                    ),
                  ),
                ),
                Text(
                  '${booking.driverPhoneNumber ?? ''}',
                  textAlign: TextAlign.right, // Align text to the right
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
    );
  }
}
