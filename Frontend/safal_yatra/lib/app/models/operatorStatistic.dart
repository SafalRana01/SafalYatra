// To parse this JSON data, do
//
//     final operatorStatisticResponse = operatorStatisticResponseFromJson(jsonString);

import 'dart:convert';

OperatorStatisticResponse operatorStatisticResponseFromJson(String str) =>
    OperatorStatisticResponse.fromJson(json.decode(str));

String operatorStatisticResponseToJson(OperatorStatisticResponse data) =>
    json.encode(data.toJson());

class OperatorStatisticResponse {
  final bool? success;
  final String? message;
  final Statistics? statistics;

  OperatorStatisticResponse({
    this.success,
    this.message,
    this.statistics,
  });

  factory OperatorStatisticResponse.fromJson(Map<String, dynamic> json) =>
      OperatorStatisticResponse(
        success: json["success"],
        message: json["message"],
        statistics: json["statistics"] == null
            ? null
            : Statistics.fromJson(json["statistics"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statistics": statistics?.toJson(),
      };
}

class Statistics {
  final String? totalCars;
  final String? totalDrivers;
  final String? totalTourPackages;
  final String? totalBookings;
  final String? totalRevenue;
  final String? totalMonthlyRevenue;
  final List<TopCar>? topCars;

  Statistics({
    this.totalCars,
    this.totalDrivers,
    this.totalTourPackages,
    this.totalBookings,
    this.totalRevenue,
    this.totalMonthlyRevenue,
    this.topCars,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        totalCars: json["total_cars"],
        totalDrivers: json["total_drivers"],
        totalTourPackages: json["total_tour_packages"],
        totalBookings: json["total_bookings"],
        totalRevenue: json["total_revenue"],
        totalMonthlyRevenue: json["total_monthly_revenue"],
        topCars: json["top_cars"] == null
            ? []
            : List<TopCar>.from(
                json["top_cars"]!.map((x) => TopCar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_cars": totalCars,
        "total_drivers": totalDrivers,
        "total_tour_packages": totalTourPackages,
        "total_bookings": totalBookings,
        "total_revenue": totalRevenue,
        "total_monthly_revenue": totalMonthlyRevenue,
        "top_cars": topCars == null
            ? []
            : List<dynamic>.from(topCars!.map((x) => x.toJson())),
      };
}

class TopCar {
  final dynamic carId;
  final String? licensePlate;
  final String? name;
  final dynamic totalIncome;
  final double? percentage;

  TopCar({
    this.carId,
    this.licensePlate,
    this.name,
    this.totalIncome,
    this.percentage,
  });

  factory TopCar.fromJson(Map<String, dynamic> json) => TopCar(
        carId: json["car_id"],
        licensePlate: json["license_plate"],
        name: json["name"],
        totalIncome: json["total_income"],
        percentage: json["percentage"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "car_id": carId,
        "license_plate": licensePlate,
        "name": name,
        "total_income": totalIncome,
        "percentage": percentage,
      };
}
