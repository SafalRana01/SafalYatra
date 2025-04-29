import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/utils/memory.dart';

import '../controllers/payments_controller.dart';

class PaymentsView extends GetView<PaymentsController> {
  var showBackArrow = Get.arguments;

  PaymentsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(PaymentsController());
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2FA),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.buttonColor,
        automaticallyImplyLeading: false,
        title: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: showBackArrow == 'from_profile',
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              Text(
                Memory.getRole() == 'operator' ? 'All Payments' : 'My Payments',
                style: TextStyle(
                  fontSize: 20,
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
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.showPaymentHistory();
        },
        child: GetBuilder<PaymentsController>(
          builder: (controller) {
            if (controller.paymentResponse == null) {
              return FutureBuilder(
                future: Future.delayed(
                    const Duration(seconds: 3)), // 3-second delay
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.buttonColor,
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No Payments available',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Inter",
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                },
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
                    const SizedBox(height: 5),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          controller.paymentResponse?.payments?.length ?? 0,
                      itemBuilder: (context, index) {
                        var payment =
                            controller.paymentResponse!.payments![index];

                        int calculateDays() {
                          if (payment.startDate != null &&
                              payment.endDate != null) {
                            return (payment.endDate!
                                    .difference(payment.startDate!)
                                    .inDays) +
                                1;
                          }
                          return 0; // Default value if dates are null
                        }

                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: Get.width / 25),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width / 20),
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
                                const SizedBox(
                                  height: 10,
                                ),
                                if (payment.packageId == null)
                                  Container(
                                    width: double.infinity,
                                    color: AppColors.buttonColor,
                                    // Set container background color
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 12), // Optional padding
                                    child: Center(
                                      child: Text(
                                        'Payment for Car Booking',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                          color: Colors
                                              .white, // Set text color to white
                                        ),
                                      ),
                                    ),
                                  ),
                                if (payment.packageId != null)
                                  Container(
                                    width: double.infinity,
                                    color: Colors
                                        .blue, // Set container background color
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 12), // Optional padding
                                    child: Center(
                                      child: Text(
                                        'Payment for Tour Booking',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                          color: Colors
                                              .white, // Set text color to white
                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 15),
                                Row(children: [
                                  const Expanded(
                                    child: Text(
                                      'Receipt No:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Inter",
                                          color: AppColors.buttonColor),
                                    ),
                                  ),
                                  Text(
                                    '#${payment.paymentId ?? ''}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Inter",
                                        color: AppColors.buttonColor),
                                  ),
                                ]),
                                Divider(),
                                Visibility(
                                  visible: Memory.getRole() == 'user' ||
                                      Memory.getRole() == 'admin',
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Car Owner:',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Inter",
                                            color:
                                                Color.fromARGB(255, 86, 85, 85),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Get.width / 18),
                                      Text(
                                        payment.operatorName ?? '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Visibility(
                                  visible: Memory.getRole() == 'operator' ||
                                      Memory.getRole() == 'admin',
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              'Paid By:',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Inter",
                                                color: Color.fromARGB(
                                                    255, 86, 85, 85),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Get.width / 18),
                                          Text(
                                            payment.userName ?? '',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              'Phone Number:',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Inter",
                                                color: Color.fromARGB(
                                                    255, 86, 85, 85),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Get.width / 18),
                                          Text(
                                            payment.userPhoneNumber ?? '',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              'Email:',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Inter",
                                                color: Color.fromARGB(
                                                    255, 86, 85, 85),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Get.width / 18),
                                          Text(
                                            payment.userEmail ?? '',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Divider(),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Car Number:',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Inter",
                                          color:
                                              Color.fromARGB(255, 86, 85, 85),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      payment.licensePlate ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Car Name:',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Inter",
                                          color:
                                              Color.fromARGB(255, 86, 85, 85),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      payment.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Start Date:',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Inter",
                                          color:
                                              Color.fromARGB(255, 86, 85, 85),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Get.width / 18),
                                    Text(
                                      payment.startDate != null
                                          ? DateFormat('yyyy-MMM-dd')
                                              .format(payment.startDate!)
                                          : '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'End Date:',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Inter",
                                          color:
                                              Color.fromARGB(255, 86, 85, 85),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Get.width / 18),
                                    Text(
                                      payment.endDate != null
                                          ? DateFormat('yyyy-MMM-dd')
                                              .format(payment.endDate!)
                                          : '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    if (payment.packageId != null)
                                      const Expanded(
                                        child: Text(
                                          'Price Per Person:',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Inter",
                                            color:
                                                Color.fromARGB(255, 86, 85, 85),
                                          ),
                                        ),
                                      ),
                                    if (payment.packageId == null)
                                      const Expanded(
                                        child: Text(
                                          'Price Per Day:',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Inter",
                                            color:
                                                Color.fromARGB(255, 86, 85, 85),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 2),
                                    Text(
                                      payment.ratePerHours ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                const Divider(),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Payment Mode:',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Inter",
                                          color:
                                              Color.fromARGB(255, 86, 85, 85),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Get.width / 18),
                                    Text(
                                      payment.paymentMode ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Number of Rent Days:',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Inter",
                                          color:
                                              Color.fromARGB(255, 86, 85, 85),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Get.width / 18),
                                    Text(
                                      calculateDays().toString() ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Total:',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Inter",
                                          color:
                                              Color.fromARGB(255, 86, 85, 85),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Get.width / 18),
                                    Text(
                                      'Rs.${payment.total ?? ''}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Payment Date:',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Inter",
                                          color:
                                              Color.fromARGB(255, 86, 85, 85),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Get.width / 18),
                                    Text(
                                      payment.paymentDate != null
                                          ? DateFormat('yyyy-MMM-dd')
                                              .format(payment.paymentDate!)
                                          : '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        );
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
