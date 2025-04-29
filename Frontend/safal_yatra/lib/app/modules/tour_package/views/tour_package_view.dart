import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/utils/constant.dart';

import '../controllers/tour_package_controller.dart';

class TourPackageView extends GetView<TourPackageController> {
  const TourPackageView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(TourPackageController());

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
                  size: 30,
                ),
              ),
              const Text(
                'Popular Tours',
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
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.tourPackages;
        },
        child: GetBuilder<TourPackageController>(
          builder: (controller) {
            if (controller.tourPackages == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.buttonColor,
                ),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: Get.height * 0.9,
                ),
                child: Column(
                  children: [
                    ListView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling for inner ListView
                      shrinkWrap:
                          true, // Make sure it doesn't occupy unnecessary space
                      itemCount: controller
                              .tourPackages?.availableTourPackages?.length ??
                          0,
                      itemBuilder: (context, index) {
                        var tour = controller
                            .tourPackages!.availableTourPackages![index];
                        var isExpanded =
                            controller.expandedList.contains(index);

                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.SPECIFIC_TOUR_PACKAGE,
                                    arguments: tour);
                              },
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
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15)),
                                      child: Image.network(
                                        getImageUrl(tour.imageUrl ?? ''),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            tour.packageName ?? '',
                                            style: TextStyle(
                                              color: AppColors.buttonColor,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "RobotoCondensed",
                                            ),
                                          ),
                                          Text(
                                            tour.description ?? '',
                                            textAlign: TextAlign
                                                .justify, // Ensures text is justified
                                            maxLines: isExpanded
                                                ? null
                                                : 5, // Show only 5 lines initially
                                            overflow: isExpanded
                                                ? TextOverflow.visible
                                                : TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Roboto",
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          GestureDetector(
                                            onTap: () {
                                              controller.toggleExpand(index);
                                            },
                                            child: Text(
                                              isExpanded
                                                  ? "Read Less"
                                                  : "Read More",
                                              style: TextStyle(
                                                color: AppColors.buttonColor,
                                                fontWeight: FontWeight.w600,
                                              ),
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
                                                          'Rs.${tour.price ?? ''}',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .buttonColor,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' /person',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFB3B3B3),
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
                                                        color:
                                                            Color(0xFFB3B3B3),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${tour.availableCapacity ?? ''} / ${tour.tourCapacity ?? ''}',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: AppColors
                                                            .buttonColor,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                            ));
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
