import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/customDate.dart';
import 'package:safal_yatra/components/custom_button.dart';

import '../controllers/add_tour_package_controller.dart';

class AddTourPackageView extends GetView<AddTourPackageController> {
  const AddTourPackageView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTourPackageController>(
      builder: (controller) => Scaffold(
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
                  'Add Tour Package',
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
          ),
        ),
        body: Form(
          key: controller.key,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: Get.height * 0.9,
              ),
              child: GetBuilder<AddTourPackageController>(
                builder: (controller) {
                  return Padding(
                    padding: EdgeInsets.all(
                      Get.width / 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter Tour Package Details:',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: Get.width / 30,
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Select car',
                            labelStyle: const TextStyle(fontSize: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select car';
                            }
                            return null;
                          },
                          value: controller.selectedCarId,
                          items: controller.carsResponse?.listCars
                                  ?.map((e) => DropdownMenuItem(
                                        value: e.carId,
                                        child: Text(e.licensePlate ?? ''),
                                      ))
                                  .toList() ??
                              [],
                          onChanged: (v) {
                            controller.selectedCarId = v;
                          },
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: controller.packageNameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: Get.width / 30,
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Tour Package Name',
                            labelText: 'Tour Package Name',
                            suffixIcon: const Icon(Icons.tour, size: 25),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter tour package name";
                            } else {
                              return null;
                            }
                          },
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: controller.pricePerPersonController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: Get.width / 30,
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Price per person',
                            labelText: ' Price per person',
                            suffixIcon: Icon(MdiIcons.cash,
                                size: 30), // Add the phone icon as suffix
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter price per person";
                            } else if (!value.isNum) {
                              return "Invalid price.";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: controller.startLocationController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: Get.width / 30,
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Start Location',
                            labelText: 'Start Location',
                            suffixIcon: Icon(MdiIcons.mapMarker, size: 33),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter start location";
                            } else {
                              return null;
                            }
                          },
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: controller.destinationController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: Get.width / 30,
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Destination Location',
                            labelText: 'Destination Location',
                            suffixIcon: Icon(MdiIcons.city, size: 33),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter destination location";
                            } else {
                              return null;
                            }
                          },
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 25),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: Get.width / 30,
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Select Driver',
                            labelStyle: const TextStyle(fontSize: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a driver';
                            }
                            return null;
                          },
                          value: controller.selectedDriverId,
                          items: controller.drivers?.myDrivers
                                  ?.map((e) => DropdownMenuItem(
                                        value: e.driverId,
                                        child: Text(
                                            '${e.driverName ?? ''}-${e.phoneNumber ?? ''}'),
                                      ))
                                  .toList() ??
                              [],
                          onChanged: (v) {
                            controller.selectedDriverId = v;
                          },
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          minLines: 3,
                          maxLines: 5,
                          maxLength: 2500,
                          controller: controller.descriptionController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: Get.width / 30,
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Description',
                            labelText: 'Description',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter tour package description";
                            } else {
                              return null;
                            }
                          },
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Pick-up Date
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    controller.selectDateRange(context),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start Date',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 14),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.calendar_today, size: 20),
                                          SizedBox(width: 8),
                                          Obx(() => Text(
                                                controller.pickUpDate.value !=
                                                        null
                                                    ? formatDate(controller
                                                        .pickUpDate
                                                        .value!) // Format the date here
                                                    : "Select Date",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "RobotoCondensed",
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFFB3B3B3),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 15),

                            // Drop-off Date
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    controller.selectDateRange(context),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'End Date',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 14),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.calendar_today, size: 20),
                                          SizedBox(width: 8),
                                          Obx(() => Text(
                                                controller.dropOffDate.value !=
                                                        null
                                                    ? formatDate(controller
                                                        .dropOffDate
                                                        .value!) // Format the drop-off date here
                                                    : "Select Date",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "RobotoCondensed",
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFFB3B3B3),
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
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Select Tour Package Image',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        controller.imageBytes != null
                            ? Stack(
                                children: [
                                  Image.memory(
                                    controller.imageBytes!,
                                    height: 200,
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: IconButton(
                                        padding: EdgeInsets.all(0.0),
                                        style: IconButton.styleFrom(
                                          padding: EdgeInsets.all(0.0),
                                        ),
                                        onPressed: controller.onImageDelete,
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  )
                                ],
                              )
                            : const SizedBox(),
                        ElevatedButton(
                          onPressed: controller.onImagePick,
                          child: Text('Pick Image'),
                        ),
                        Visibility(
                          visible: controller.isImageError,
                          child: Text(
                            'Please select image',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        persistentFooterButtons: [
          CustomButton(
              title: 'Add Tour Package', onTap: controller.addTourPackage),
        ],
      ),
    );
  }
}
