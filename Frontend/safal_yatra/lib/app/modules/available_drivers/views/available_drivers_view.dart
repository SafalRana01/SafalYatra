import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/utils/constant.dart';
import '../controllers/available_drivers_controller.dart';

class AvailableDriversView extends GetView<AvailableDriversController> {
  const AvailableDriversView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AvailableDriversController());
    final profileHeight = Get.height / 30;

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.buttonColor,
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                MdiIcons.close,
                color: Colors.white,
                size: 25,
              ),
            ),
            const Text(
              'Select Driver',
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
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getDrivers();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        size: 24,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          onChanged: controller.searchDrivers,
                          decoration: const InputDecoration(
                            hintText: 'Search driver',
                            hintStyle: TextStyle(
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Driver List
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.displayedDrivers
                        .map((driver) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.selectDriver(driver);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: driver ==
                                              controller.selectedDriver.value
                                          ? AppColors.backGroundColor
                                              .withOpacity(0.3)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        // Driver Image
                                        CircleAvatar(
                                            radius: profileHeight,
                                            backgroundColor:
                                                Colors.grey.shade800,
                                            child: driver.imageUrl != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            profileHeight),
                                                    child: Image.network(
                                                      getImageUrl(
                                                          driver.imageUrl!),
                                                      height: 90,
                                                      width: 90,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Text(
                                                    driver.driverName![0]
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  )),
                                        const SizedBox(width: 15),

                                        // Name & Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Driver Name
                                              Text(
                                                driver.driverName!,
                                                style: TextStyle(
                                                  fontFamily: "Inika",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 4),

                                              // Gender, Age, Experience Row
                                              Row(
                                                children: [
                                                  Icon(
                                                    driver.gender!
                                                                .toLowerCase() ==
                                                            'male'
                                                        ? Icons.male
                                                        : Icons.female,
                                                    color: Colors.grey,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    '${driver.gender}, ${driver.age} yrs, ${driver.experience} yrs exp',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Selected Icon
                                        if (driver ==
                                            controller.selectedDriver.value)
                                          Icon(
                                            Icons.check_circle,
                                            color: AppColors.buttonColor,
                                            size: 24,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(height: 15, thickness: 1),
                              ],
                            ))
                        .toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
