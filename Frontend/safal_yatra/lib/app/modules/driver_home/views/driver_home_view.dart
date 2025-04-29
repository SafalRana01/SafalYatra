import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getDriverSchedule.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/customDate.dart';
import 'package:safal_yatra/utils/constant.dart';

import '../controllers/driver_home_controller.dart';

class DriverHomeView extends GetView<DriverHomeController> {
  const DriverHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(DriverHomeController());
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.buttonColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Car Schedules',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter",
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<DriverHomeController>(
        builder: (controller) {
          if (controller.driverScheduleResponse == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var todaySchedules = controller.driverScheduleResponse?.bookings
                  ?.where((schedule) => isToday(schedule.startDate!))
                  .toList() ??
              [];
          var upcomingSchedules = controller.driverScheduleResponse?.bookings
                  ?.where((schedule) => isFuture(schedule.startDate!))
                  .toList() ??
              [];
          var completedSchedules = controller.driverScheduleResponse?.bookings
                  ?.where((schedule) => isPast(schedule.startDate!))
                  .toList() ??
              [];
          return DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        fontSize: 18,
                      ),
                      tabs: [
                        Tab(
                          text: 'Today',
                        ),
                        Tab(
                          text: 'upcoming',
                        ),
                        Tab(
                          text: 'Completed',
                        ),
                      ]),
                  Expanded(
                    child: TabBarView(children: [
                      todaySchedules.isEmpty
                          ? Center(
                              child: Text(
                                'No schedules for today',
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
                              itemCount: todaySchedules.length,
                              itemBuilder: (context, index) => ScheduleCard(
                                schedule: todaySchedules[index],
                                isToday: true,
                              ),
                            ),
                      upcomingSchedules.isEmpty
                          ? Center(
                              child: Text(
                                'No Upcoming schedules',
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
                              itemCount: upcomingSchedules.length,
                              itemBuilder: (context, index) => ScheduleCard(
                                schedule: upcomingSchedules[index],
                                isToday: false,
                              ),
                            ),
                      completedSchedules.isEmpty
                          ? Center(
                              child: Text(
                                'No Completed schedules',
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
                              itemCount: completedSchedules.length,
                              itemBuilder: (context, index) => ScheduleCard(
                                schedule: completedSchedules[index],
                                isToday: false,
                              ),
                            )
                    ]),
                  )
                ],
              ));
        },
      ),
    );
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool isFuture(DateTime date) {
    final now = DateTime.now();
    return date.isAfter(now);
  }

  bool isPast(DateTime date) {
    final now = DateTime.now();
    return date.isBefore(now) && !isToday(date);
  }
}

class ScheduleCard extends StatelessWidget {
  final Booking schedule;
  bool isToday;
  ScheduleCard({super.key, required this.schedule, required this.isToday});
  int calculateDays() {
    if (schedule.startDate != null && schedule.endDate != null) {
      return (schedule.endDate!.difference(schedule.startDate!).inDays) + 1;
    }
    return 0; // Default value if dates are null
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<DriverHomeController>();
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
                  schedule.name.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.values[5],
                      fontFamily: "RobotoCondensed"),
                ),
                Spacer(),
                Text(
                  schedule.licensePlate.toString(),
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
                getImageUrl(schedule.imageUrl ?? ''),
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
                      schedule.startDate != null
                          ? formatDate(schedule.startDate!)
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
                      schedule.endDate != null
                          ? formatDate(schedule.endDate!)
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
                  '${schedule.userName ?? ''}',
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
                  '${schedule.userPhoneNumber ?? ''}',
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
                  '${schedule.userEmail ?? ''}',
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
                  'Rs.${schedule.total ?? ''}',
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
                    'Booking Type:',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Inter",
                      color: Color.fromARGB(255, 86, 85, 85),
                    ),
                  ),
                ),
                Text(
                  schedule.packageId != null ? 'Tour Package' : 'Car Rental',
                  textAlign: TextAlign.right, // Align text to the right
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    color: AppColors.buttonColor,
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
