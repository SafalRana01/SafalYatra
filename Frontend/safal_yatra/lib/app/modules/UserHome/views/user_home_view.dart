import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:safal_yatra/app/models/getCars.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/customDate.dart';
import 'package:safal_yatra/components/custom_button.dart';
import 'package:safal_yatra/utils/constant.dart';

import '../controllers/user_home_controller.dart';

class UserHomeView extends GetView<UserHomeController> {
  const UserHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserHomeController());
    final profileHeight = Get.height / 45;

    return GetBuilder<UserHomeController>(builder: (controller) {
      if (controller.userResponse == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      var profile = controller.userResponse!.users!;
      return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          toolbarHeight: 75,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFF5F5F5),
          title: Row(
            children: [
              // Text at the left
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Safal',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: "Agbalumo",
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Yatra',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: "Agbalumo",
                        fontWeight: FontWeight.w500,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ],
                ),
              ),

              Spacer(), // Pushes the image to the right

              // Circular Image at the right
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PROFILE, arguments: 'from_home');
                },
                child: CircleAvatar(
                    radius: profileHeight,
                    backgroundColor: Colors.grey.shade800,
                    child: profile.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(profileHeight),
                            child: Image.network(
                              getImageUrl(profile.imageUrl!),
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Text(
                            profile.fullName![0].toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          )),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.showAvailableTourPackages();
          },
          child: GetBuilder<UserHomeController>(
            builder: (controller) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: Get.height * 0.9,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'lib/assets/images/home.jpg',

                        fit: BoxFit.cover, // Adjust fit if needed
                      ),
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17),
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
                              // Location Section
                              Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "RobotoCondensed",
                                  color: Colors.black,
                                ),
                              ),

                              TextFormField(
                                readOnly: true,
                                controller: controller.locationController,
                                onTap: controller.navigateToLocationPage,
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search location, city',
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "RobotoCondensed",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFB3B3B3),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.location_on_outlined,
                                    size: 22.0,
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0.0),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 8.0,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.buttonColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              // Pick-up and Drop-off Date Section
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Pick-up Date
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () =>
                                          controller.selectDateRange(context),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pick-up Date',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.buttonColor),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.calendar_today,
                                                    size: 20),
                                                SizedBox(width: 8),
                                                Obx(() => Text(
                                                      controller.pickUpDate
                                                                  .value !=
                                                              null
                                                          ? formatDate(controller
                                                              .pickUpDate
                                                              .value!) // Format the date here
                                                          : "Select Date",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            "RobotoCondensed",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xFFB3B3B3),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),

                                  // Number of Days Section
                                  Obx(() => controller.selectedDays.value > 0
                                      ? Column(
                                          children: [
                                            Text(
                                              "${controller.selectedDays.value} Days",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward, size: 20),
                                          ],
                                        )
                                      : SizedBox()),
                                  SizedBox(width: 10),

                                  // Drop-off Date
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () =>
                                          controller.selectDateRange(context), 
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Drop-off Date',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.buttonColor),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.calendar_today,
                                                    size: 20),
                                                SizedBox(width: 8),
                                                Obx(() => Text(
                                                      controller.dropOffDate
                                                                  .value !=
                                                              null
                                                          ? formatDate(controller
                                                              .dropOffDate
                                                              .value!) // Format the drop-off date here
                                                          : "Select Date",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            "RobotoCondensed",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xFFB3B3B3),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              // Custom Button
                              CustomButton(
                                title: 'Search Car',
                                onTap: () {
                                  Get.toNamed(Routes.AVAILABLE_CARS);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

// The pacakage start from here and comment start from here(343)

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 10),
                        child: Row(
                          children: [
                            Text(
                              'Tour Packages',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "RobotoCondensed",
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            Row(
                              // Wrap "View all" and arrow in a Row to keep them close
                              children: [
                                GestureDetector(
                                  onTap: () => Get.toNamed(
                                    Routes.TOUR_PACKAGE,
                                  ),
                                  child: Text(
                                    'View all',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "RobotoCondensed",
                                      color: AppColors.buttonColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 0), // Adjust spacing if needed
                                Icon(
                                  FontAwesomeIcons.angleRight,
                                  size: 20,
                                  color: AppColors.buttonColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// Horizontally scrollable car list
                      SizedBox(
                        height: 200, // Increase the height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: controller.tourPackages
                                  ?.availableTourPackages?.length ??
                              0,
                          itemBuilder: (context, index) {
                            var tour = controller
                                .tourPackages!.availableTourPackages![index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 7.5),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.SPECIFIC_TOUR_PACKAGE,
                                      arguments: tour);
                                },
                                child: Container(
                                  width: Get.width *
                                      0.41, // Adjust width if needed
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          63, 93, 169, 255),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            12), // Rounded corners
                                        child: Image.network(
                                          getImageUrl(tour.imageUrl ?? ''),
                                          height:
                                              100, // Adjust height as needed
                                          width: double
                                              .infinity, // Take full container width
                                          fit: BoxFit
                                              .cover, // Ensures the image covers full area
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        tour.packageName ?? '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "RobotoCondensed",
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 5),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  'Rs.${tour.price ?? ''}', // Price
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: "RobotoCondensed",
                                                fontWeight: FontWeight.w600,
                                                color: AppColors
                                                    .buttonColor, // Price color
                                              ),
                                            ),
                                            const TextSpan(
                                              text:
                                                  ' / person', // Additional text
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "RobotoCondensed",
                                                fontWeight: FontWeight.w500,
                                                color: Color(
                                                    0xFFB3B3B3), // Grey color
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
      );
    });
  }
}
