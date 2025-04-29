import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safal_yatra/app/models/getUserProfile.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/components/custom_button.dart';
import 'package:safal_yatra/utils/constant.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  final Users user = Get.arguments;
  EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileHeight = Get.height / 15;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F2FA),
      appBar: AppBar(
        toolbarHeight: 100,
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
                  size: 30,
                ),
              ),
              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(width: 40),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: Get.height * 0.7,
          ),
          child: GetBuilder<EditProfileController>(
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: Padding(
                  padding: EdgeInsets.all(
                    Get.width / 25,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: profileHeight,
                              backgroundColor: Colors.grey.shade800,
                              child: controller.imageBytes != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(profileHeight),
                                      child: Image.memory(
                                        controller.imageBytes!,
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : user.imageUrl != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              profileHeight),
                                          child: Image.network(
                                            getImageUrl(user.imageUrl ?? ''),
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Text(
                                          user.fullName![0].toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  controller.onImagePick();
                                },
                                behavior: HitTestBehavior.translucent,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Center(
                        child: Text(
                          'Change Profile Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!GetUtils.isEmail(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              controller: controller.emailController,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: Get.width / 30,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    // Set the focused border here
                                    borderSide: BorderSide(
                                      color: AppColors
                                          .buttonColor, // Set the desired focus color here
                                    ),
                                  ),
                                  hintText: 'Email Address',
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(fontSize: 18)),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.nameController,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: Get.width / 30,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    // Set the focused border here
                                    borderSide: BorderSide(
                                      color: AppColors
                                          .buttonColor, // Set the desired focus color here
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.nameController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        size: 25,
                                        color: Colors.grey,
                                      )),
                                  hintText: 'Full Name',
                                  labelText: 'Full Name',
                                  labelStyle: TextStyle(fontSize: 18)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter full name";
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.addressController,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: Get.width / 30,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    // Set the focused border here
                                    borderSide: BorderSide(
                                      color: AppColors
                                          .buttonColor, // Set the desired focus color here
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.addressController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        size: 25,
                                        color: Colors.grey,
                                      )),
                                  hintText: 'Address',
                                  labelText: 'Address',
                                  labelStyle: TextStyle(fontSize: 18)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter address";
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.contactController,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: Get.width / 30,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    // Set the focused border here
                                    borderSide: BorderSide(
                                      color: AppColors
                                          .buttonColor, // Set the desired focus color here
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.contactController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        size: 25,
                                        color: Colors.grey,
                                      )),
                                  hintText: 'Contact Number',
                                  labelText: 'Contact Number',
                                  labelStyle: TextStyle(fontSize: 18)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter contact number";
                                } else if (value.length != 10) {
                                  return "Please enter valid contact number";
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      persistentFooterButtons: [
        CustomButton(title: 'Update Profile', onTap: controller.onUpdateProfile)
      ],
    );
  }
}
