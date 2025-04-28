import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safal_yatra/app/models/allOperators.dart';
import 'package:safal_yatra/app/modules/users_view/controllers/users_view_controller.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/utils/constant.dart';

class AllOperatorCard extends StatelessWidget {
  final AllOperator allOperator;

  const AllOperatorCard({
    Key? key,
    required this.allOperator,
  });

  @override
  Widget build(BuildContext context) {
    final profileHeight = Get.height / 30;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: Get.width / 25),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            width: double.infinity,
            padding:
                EdgeInsets.symmetric(horizontal: Get.width / 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: const Color.fromRGBO(63, 93, 169, 255),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(height: Get.height / 50),
                          CircleAvatar(
                              radius: 23,
                              backgroundColor: Colors.grey.shade800,
                              child: allOperator.imageUrl != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(profileHeight),
                                      child: Image.network(
                                        getImageUrl(allOperator.imageUrl!),
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Text(
                                      allOperator.operatorName![0]
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    )),
                          SizedBox(
                            width: Get.width / 20,
                          ),
                          Expanded(
                            child: Text(
                              allOperator.operatorName ?? '',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Inter"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (allOperator.status != "Verified")
                      ElevatedButton(
                        onPressed: () {
                          Get.find<UsersViewController>()
                              .verifyOperator(allOperator.operatorId ?? '');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Verify',
                          style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    else
                      IconButton(
                        onPressed: () {
                          showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: MaterialLocalizations.of(context)
                                .modalBarrierDismissLabel,
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            pageBuilder: (BuildContext buildContext,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return Center(
                                child: ScaleTransition(
                                  scale: CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOut,
                                  ),
                                  child: AlertDialog(
                                    backgroundColor: AppColors.backGroundColor,
                                    title: const Text(
                                      "Delete Confirmation",
                                      style: TextStyle(
                                          fontFamily: 'Inter', fontSize: 20),
                                    ),
                                    content: const Text(
                                      'Do you really want to delete this operator?',
                                      style: TextStyle(
                                          fontFamily: 'Inter', fontSize: 14),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.close(1);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.find<UsersViewController>()
                                              .deleteOperator(
                                                  allOperator.operatorId ?? '');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            transitionBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return FadeTransition(
                                opacity: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOut,
                                ),
                                child: child,
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(),
                const SizedBox(
                  height: 5,
                ),

                Row(
                  children: [
                    const Expanded(
                      // Expanded widget to take remaining space
                      child: Text(
                        'Contact Number:',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inter",
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 40),
                    Text(
                      allOperator.phoneNumber ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      // Expanded widget to take remaining space
                      child: Text(
                        'License Number:',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inter",
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 40),
                    Text(
                      allOperator.registrationNumber ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      // Expanded widget to take remaining space
                      child: Text(
                        'Location:',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inter",
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 40),
                    Text(
                      allOperator.location ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      // Expanded widget to take remaining space
                      child: Text(
                        'Email:',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inter",
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 40),
                    Text(
                      allOperator.email ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ), // Add vertical spacing between rows

                Row(
                  children: [
                    const Expanded(
                      // Expanded widget to take remaining space
                      child: Text(
                        'Added Date:',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inter",
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 40),
                    Text(
                      allOperator.addedDate != null
                          ? DateFormat('yyyy-MMM-dd')
                              .format(allOperator.addedDate!)
                          : '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
