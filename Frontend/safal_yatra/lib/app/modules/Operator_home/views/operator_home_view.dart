import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:safal_yatra/app/models/operatorStatistic.dart';
import 'package:safal_yatra/app/routes/app_pages.dart';
import 'package:safal_yatra/components/appColors.dart';
import 'package:safal_yatra/utils/constant.dart';

import '../controllers/operator_home_controller.dart';

class OperatorHomeView extends GetView<OperatorHomeController> {
  const OperatorHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final profileHeight = Get.height / 45;
    Get.put(OperatorHomeController());

    // MonthlyBookingBarChart(
    //   monthlyBookings: controller.monthlyBookings,
    // );

    return GetBuilder<OperatorHomeController>(builder: (controller) {
      if (controller.operatorResponse == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      var profile = controller.operatorResponse!.operators!;
      return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          toolbarHeight: 75,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFF5F5F5),
          title: Row(
            children: [
              // Text at the left
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Safal',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: "Agbalumo",
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Yatra',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: "Agbalumo",
                        fontWeight: FontWeight.w500,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ],
                ),
              ),

              Spacer(), // Pushes the image to the right

              // Circular Image at the right
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.OPERATOR_PROFILE);
                },
                child: CircleAvatar(
                    radius: profileHeight,
                    backgroundColor: Colors.grey.shade800,
                    child: profile.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(profileHeight),
                            child: Image.network(
                              getImageUrl(profile.imageUrl!),
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Text(
                            profile.operatorName![0].toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          )),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.getStats();
          },
          child: GetBuilder<OperatorHomeController>(
            builder: (controller) {
              if (controller.statsResponse == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var stats = controller.statsResponse!.statistics!;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: Get.width * 0.9,
                              child: TextField(
                                readOnly: true,
                                controller: controller.monthController,
                                decoration: InputDecoration(
                                  hintText: 'Select month and year',
                                  suffixIcon: GestureDetector(
                                    onTap: () async {
                                      final pickedDate = await showMonthPicker(
                                        context: context,
                                        initialDate: controller.selectedDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (pickedDate != null) {
                                        controller.selectedDate = pickedDate;
                                        controller.monthController.text =
                                            DateFormat('MMMM, yyyy').format(
                                                pickedDate); // Format to "April, 2025"

                                        controller.getStats(
                                            date: DateTime(pickedDate.year,
                                                pickedDate.month));
                                      }
                                    },
                                    child: const Icon(Icons.calendar_month),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: Get.width / 20),
                        const Text(
                          'Revenue:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.buttonColor,
                              fontFamily: 'Inika'),
                        ),
                      ],
                    ),
                    GridView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.1,
                      ),
                      children: [
                        StatCard(
                          title: 'Total Income',
                          value: "Rs. ${stats.totalRevenue ?? 0}",
                          icon: Icon(
                            MdiIcons.currencyRupee,
                            color: Colors.white,
                          ),
                          // color: Colors.teal.shade400,
                          // color: Color(0xFFFED2E2),
                        ),
                        StatCard(
                          title: 'Total Monthly Income',
                          value: "Rs. ${stats.totalMonthlyRevenue!}",
                          icon: Icon(
                            MdiIcons.currencyRupee,
                            color: Colors.white,
                          ),
                          color: Colors.orange.shade400,
                          // color: Color(0xFF90C67C),// color: Color(0xFF90C67C),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: Get.width / 20),
                        const Text(
                          'Statistics:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.buttonColor,
                              fontFamily: 'Inika'),
                        ),
                      ],
                    ),
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.1,
                      ),
                      children: [
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.OPERATOR_CARS,
                              arguments: 'from_home'),
                          child: StatCard(
                            title: 'Total Cars',
                            value: stats.totalCars.toString(),
                            icon: Icon(
                              MdiIcons.carMultiple,
                              color: Colors.white,
                            ),
                            // color: Colors.blue.shade400,
                            color: Color(0xFFC9B194),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.OPERATOR_DRIVERS,
                              arguments: 'from_home'),
                          child: StatCard(
                            title: 'Total Drivers',
                            value: stats.totalDrivers.toString(),
                            // color: Colors.red.shade400,
                            color: Color(0xFF90C67C),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.OPERATOR_TOURS,
                              arguments: 'from_home'),
                          child: StatCard(
                            title: 'Total Tour Packages',
                            value: stats.totalTourPackages.toString(),
                            icon: Icon(
                              MdiIcons.carClock,
                              color: Colors.white,
                            ),
                            // color: Colors.green.shade500,
                            color: Colors.red.shade400,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.OPERATOR_BOOKINGS,
                              arguments: 'from_home'),
                          child: StatCard(
                            title: 'Total Bookings',
                            value: stats.totalBookings.toString(),
                            icon: const Icon(
                              Icons.work_history,
                              color: Colors.white,
                            ),
                            color: Colors.purple.shade400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(width: Get.width / 20),
                        const Text(
                          'Top Cars by Revenue:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.buttonColor,
                              fontFamily: 'Inika'),
                        ),
                      ],
                    ),
                    MyPieChart(
                        topCars:
                            controller.statsResponse!.statistics!.topCars!),

                    // Add a title for the list of cares
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

class StatCard extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? color;
  final Widget? icon;
  const StatCard({super.key, this.title, this.value, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color ?? Colors.blue,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.26,
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              icon ??
                  const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
            ],
          ),
          const Spacer(),
          Text(
            value ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class MyPieChart extends StatelessWidget {
  final List<TopCar> topCars;
  const MyPieChart({Key? key, required this.topCars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      ChartColors.contentColorBlue,
      ChartColors.contentColorYellow,
      ChartColors.contentColorPurple,
      ChartColors.contentColorGreen,
      Colors.purpleAccent,
      Colors.orange,
    ];

    return Center(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.3,
            child: Row(
              children: <Widget>[
                const SizedBox(height: 18),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: topCares
                //       .asMap()
                //       .entries
                //       .map((entry) => Indicator(
                //             isSquare: true,
                //             color: colors[entry.key % colors.length],
                //             text: entry.value.licensePlate ?? '',
                //           ))
                //       .toList(),
                // ),
                // const SizedBox(width: 28),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: topCars.length,
            itemBuilder: (context, index) {
              final car = topCars[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: colors[index % colors.length],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            car.name?.substring(0, 1) ?? 'O',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        car.carId == 0
                            ? 'Others'
                            // : '${car.name ?? ''} - ${car.licensePlate ?? ''}',
                            : '${car.name ?? ''} ',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${car.percentage}%',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> list = [];
    List<Color> colors = [
      ChartColors.contentColorBlue,
      ChartColors.contentColorYellow,
      ChartColors.contentColorPurple,
      ChartColors.contentColorGreen,
      Colors.purpleAccent,
      Colors.orange,
    ];

    list = topCars
        .map((e) => PieChartSectionData(
              color: colors[topCars.indexOf(e)],
              value: e.percentage!,
              title: '${e.percentage}%',
              radius: 80,
              titleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ChartColors.mainTextColor1,
              ),
            ))
        .toList();
    return list;
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

class ChartColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

// class MonthlyBookingBarChart extends StatelessWidget {
//   final List<int> monthlyBookings;

//   const MonthlyBookingBarChart({super.key, required this.monthlyBookings});

//   final List<String> months = const [
//     'Jan',
//     'Feb',
//     'Mar',
//     'Apr',
//     'May',
//     'Jun',
//     'Jul',
//     'Aug',
//     'Sep',
//     'Oct',
//     'Nov',
//     'Dec'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(bottom: 10),
//           child: Text(
//             'Monthly Booking Trends',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         AspectRatio(
//           aspectRatio: 1.7,
//           child: BarChart(
//             BarChartData(
//               maxY: getMaxY(monthlyBookings),
//               borderData: FlBorderData(show: false),
//               gridData: FlGridData(show: true),
//               barTouchData: BarTouchData(enabled: true),
//               titlesData: FlTitlesData(
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 30,
//                     getTitlesWidget: (value, meta) {
//                       int index = value.toInt();
//                       return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         child: Text(
//                           index >= 0 && index < months.length
//                               ? months[index]
//                               : '',
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 32,
//                     interval: 10,
//                     getTitlesWidget: (value, meta) {
//                       return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         child: Text(
//                           '${value.toInt()}',
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 topTitles:
//                     const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 rightTitles:
//                     AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               ),
//               barGroups: monthlyBookings.asMap().entries.map((entry) {
//                 int index = entry.key;
//                 int value = entry.value;
//                 return BarChartGroupData(
//                   x: index,
//                   barRods: [
//                     BarChartRodData(
//                       toY: value.toDouble(),
//                       color: Colors.blueAccent,
//                       width: 16,
//                       borderRadius: BorderRadius.circular(4),
//                       backDrawRodData: BackgroundBarChartRodData(
//                         show: true,
//                         toY: getMaxY(monthlyBookings),
//                         color: Colors.grey[300]!,
//                       ),
//                     ),
//                   ],
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }

//   double getMaxY(List<int> data) {
//     int max = data.reduce((a, b) => a > b ? a : b);
//     return (max + 10).toDouble();
//   }
// }
