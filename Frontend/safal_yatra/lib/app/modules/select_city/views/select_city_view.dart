import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:safal_yatra/components/appColors.dart';

import '../controllers/select_city_controller.dart';

class SelectCityView extends GetView<SelectCityController> {
  final String controllerType = Get.arguments;
  SelectCityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SelectCityController());
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
              'Select City',
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
          await controller.getCities();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
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
                            onChanged: controller.searchLocations,
                            decoration: const InputDecoration(
                              hintText: 'Search City',
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
                  SizedBox(height: 10),
                  Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.displayedLocations
                          .map((location) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.selectCity(location);
                                    },
                                    child: Container(
                                      color: location ==
                                              controller.selectedCity.value
                                          ? AppColors.backGroundColor
                                              .withOpacity(0.3)
                                          : Colors.transparent,
                                      child: ListTile(
                                        title: Text(
                                          location,
                                          style: TextStyle(
                                            fontFamily: "Inika",
                                            fontSize: 20,
                                            color: location ==
                                                    controller
                                                        .selectedCity.value
                                                ? AppColors.buttonColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    height: 15,
                                    thickness: 1,
                                  ),
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
      ),
    );
  }
}
