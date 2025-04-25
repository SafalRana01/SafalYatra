import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:safal_yatra/app/modules/operator_home/controllers/operator_home_controller.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/custom_button.dart';

import '../controllers/add_car_controller.dart';

class AddCarView extends GetView<AddCarController> {
  const AddCarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCarController>(
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
                  'Add Car',
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
              child: GetBuilder<AddCarController>(
                builder: (controller) {
                  return Padding(
                    padding: EdgeInsets.all(
                      Get.width / 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter Cars Details:',
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
                            labelText: 'Select car category',
                            labelStyle: const TextStyle(fontSize: 16),
                          ),
                          // Checking if the car category is selected or not
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              // Returning an error message if the value is empty or not provided
                              return 'Please select car category';
                            }
                            return null;
                          },
                          value: controller.selectedCategoryId,
                          items: controller.categoriesResponse?.categories
                                  ?.map((e) => DropdownMenuItem(
                                        value: e.categoryId,
                                        child: Text(e.categoryName ?? ''),
                                      ))
                                  .toList() ??
                              [],
                          onChanged: (v) {
                            controller.selectedCategoryId = v;
                          },
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: controller.licensePlateController,
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
                            hintText: 'Car Plate Number',
                            labelText: 'Car Plate Number',
                            suffixIcon: Icon(MdiIcons.cardAccountDetailsOutline,
                                size: 30),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter car plate number";
                            } else {
                              return null;
                            }
                          },
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: controller.carNameController,
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
                            hintText: 'Car name',
                            labelText: 'Car name',
                            suffixIcon: Icon(MdiIcons.car, size: 30),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter car name";
                            } else {
                              return null;
                            }
                          },
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: controller.priceController,
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
                            hintText: 'Price per day',
                            labelText: ' Price per day',
                            suffixIcon: Icon(MdiIcons.cash,
                                size: 30), // Add the phone icon as suffix
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter price per day";
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
                          controller: controller.noOfSeatsController,
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
                            hintText: 'Car Seat Capacity',
                            labelText: 'Car Seat Capacity',
                            suffixIcon: Icon(MdiIcons.seatPassenger, size: 33),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter Car Seat Capacity";
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
                          controller: controller.noOfBagsController,
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
                            hintText: 'No of luggages',
                            labelText: 'No of luggages',
                            suffixIcon:
                                Icon(MdiIcons.bagSuitcaseOutline, size: 33),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter No of luggages";
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
                          controller: controller.noOfDoorsController,
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
                            hintText: 'Number of Doors',
                            labelText: 'Number of Doors',
                            suffixIcon: Icon(MdiIcons.carDoor, size: 33),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter Number of Doors";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 25),
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
                            labelText: 'Select Fuel Type',
                            labelStyle: const TextStyle(fontSize: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select fuel type';
                            }
                            return null;
                          },
                          value: controller.fuelTypeController.text.isEmpty
                              ? null
                              : controller
                                  .fuelTypeController.text, // Set initial value
                          items: ['Petrol', 'Diesel', 'Electric']
                              .map((fuel) => DropdownMenuItem(
                                    value: fuel,
                                    child: Text(fuel),
                                  ))
                              .toList(),
                          onChanged: (v) {
                            controller.fuelTypeController.text =
                                v ?? ''; // Update the TextEditingController
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          'Select Car Image',
                          style: TextStyle(
                            fontSize: 20,
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
          CustomButton(title: 'Add Car', onTap: controller.addCar),
        ],
      ),
    );
  }
}
