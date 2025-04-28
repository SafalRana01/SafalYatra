import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safal_yatra/app/models/allUsers.dart';
import 'package:safal_yatra/utils/constant.dart';

class AllUserCard extends StatelessWidget {
  final AllUser allUser;

  const AllUserCard({
    Key? key,
    required this.allUser,
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
                              child: allUser.imageUrl != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(profileHeight),
                                      child: Image.network(
                                        getImageUrl(allUser.imageUrl!),
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Text(
                                      allUser.fullName![0].toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    )),
                          SizedBox(width: Get.width / 20),
                          Expanded(
                            child: Text(
                              allUser.fullName ?? '',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Inter"),
                            ),
                          ),
                        ],
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
                        'Address:',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inter",
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 40),
                    Text(
                      allUser.address ?? '',
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
                      allUser.phoneNumber ?? '',
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
                        'Gender:',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inter",
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 40),
                    Text(
                      allUser.gender ?? '',
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
                      allUser.email ?? '',
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
                      allUser.addedDate != null
                          ? DateFormat('yyyy-MMM-dd').format(allUser.addedDate!)
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
