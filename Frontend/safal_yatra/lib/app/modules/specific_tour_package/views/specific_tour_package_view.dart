import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/customDate.dart';
import 'package:safal_yatra/components/custom_button.dart';
import 'package:safal_yatra/utils/constant.dart';

import '../controllers/specific_tour_package_controller.dart';

class SpecificTourPackageView extends GetView<SpecificTourPackageController> {
  const SpecificTourPackageView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.find<SpecificTourPackageController>();
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
                'Book Tour Package',
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
      body: GetBuilder<SpecificTourPackageController>(builder: (context) {
        return Form(
          key: controller.formKey,
          child: SingleChildScrollView(
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
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.network(
                              getImageUrl(controller.tours.imageUrl ?? ''),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  controller.tours.packageName ?? '',
                                  style: TextStyle(
                                    color: AppColors.buttonColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "RobotoCondensed",
                                  ),
                                ),
                                Text(
                                  controller.tours.description ?? '',
                                  textAlign: TextAlign
                                      .justify, // Ensures text is justified

                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "Roboto",
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
                                                'Rs.${controller.tours.price ?? ''}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.buttonColor,
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
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Available: ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFFB3B3B3),
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${controller.tours.availableCapacity ?? ''} / ${controller.tours.tourCapacity ?? ''}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.buttonColor,
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
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24), // Same as container above
                    child: Row(
                      children: [
                        Text(
                          'Package Details',
                          style: TextStyle(
                            color: AppColors.buttonColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "RobotoCondensed",
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  controller.tours.name.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.values[5],
                                      fontFamily: "RobotoCondensed"),
                                ),
                                Spacer(),
                                Text(
                                  controller.tours.licensePlate.toString(),
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
                                getImageUrl(controller.tours.carImageUrl ?? ''),
                                height: 130,
                                width: 180,
                                fit: BoxFit.cover,
                              ),
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
                                        fontFamily: "RobotoCondensed",
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      controller.tours.startDate != null
                                          ? formatDate(
                                              controller.tours.startDate!)
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
                                      "${controller.tours.duration} Days",
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
                                      'End Date',
                                      style: TextStyle(
                                        color: Color(0xFFB3B3B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "RobotoCondensed",
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      controller.tours.endDate != null
                                          ? formatDate(
                                              controller.tours.endDate!)
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
                                    'Start Location:',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Inter",
                                      color: Color.fromARGB(255, 86, 85, 85),
                                    ),
                                  ),
                                ),
                                // Ensures equal spacing on both sides
                                Text(
                                  '${controller.tours.startLocation ?? ''}',
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
                                      color: Color.fromARGB(255, 86, 85, 85),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${controller.tours.destination ?? ''}',
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
                                      color: Color.fromARGB(255, 86, 85, 85),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${controller.tours.operatorName ?? ''}',
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
                                  '${controller.tours.driverName ?? ''}',
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
                                      color: Color.fromARGB(255, 86, 85, 85),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${controller.tours.driverPhoneNumber ?? ''}',
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
                    ),
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24), // Same as container above
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Enter number of people:',
                              style: TextStyle(
                                color: AppColors.buttonColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: "RobotoCondensed",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller
                                    .numberOfPeopleController, // ✅ FIXED: No `.value`
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: Get.width / 30,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.1),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Number of people',
                                  labelText: 'Number of people',
                                  suffixIcon:
                                      const Icon(Icons.person, size: 30),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter number of people.";
                                  } else if (int.tryParse(value) == null) {
                                    return "Invalid number.";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Total Price Display (Updated Dynamically)
                        // Total Price Display (Updated Dynamically)
                        Obx(() => Text(
                              "Total: ${controller.numberOfPeople.value} people (Rs.${controller.totalPrice.value})",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.buttonColor,
                              ),
                            )),
                      ],
                    ),
                  ),

                  //
                ],
              ),
            ),
          ),
        );
      }),
      persistentFooterButtons: [
        CustomButton(
            title: 'Book Now',
            onTap: () {
              controller.makeTourBooking();
            }),
      ],
    );
  }
}
