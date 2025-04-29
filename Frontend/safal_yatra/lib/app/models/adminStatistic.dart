// To parse this JSON data, do
//
//     final adminStatisticResponse = adminStatisticResponseFromJson(jsonString);

import 'dart:convert';

AdminStatisticResponse adminStatisticResponseFromJson(String str) =>
    AdminStatisticResponse.fromJson(json.decode(str));

String adminStatisticResponseToJson(AdminStatisticResponse data) =>
    json.encode(data.toJson());

class AdminStatisticResponse {
  final bool? success;
  final String? message;
  final Statistics? statistics;

  AdminStatisticResponse({
    this.success,
    this.message,
    this.statistics,
  });

  factory AdminStatisticResponse.fromJson(Map<String, dynamic> json) =>
      AdminStatisticResponse(
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
  final String? totalUsers;
  final String? totalOperators;
  final String? totalCars;
  final String? totalDrivers;
  final String? totalTourPackages;
  final String? totalBookings;
  final String? totalRevenue;
  final String? totalMonthlyRevenue;
  final List<TopOperator>? topOperators;

  Statistics({
    this.totalUsers,
    this.totalOperators,
    this.totalCars,
    this.totalDrivers,
    this.totalTourPackages,
    this.totalBookings,
    this.totalRevenue,
    this.totalMonthlyRevenue,
    this.topOperators,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        totalUsers: json["total_users"],
        totalOperators: json["total_operators"],
        totalCars: json["total_cars"],
        totalDrivers: json["total_drivers"],
        totalTourPackages: json["total_tour_packages"],
        totalBookings: json["total_bookings"],
        totalRevenue: json["total_revenue"],
        totalMonthlyRevenue: json["total_monthly_revenue"],
        topOperators: json["top_operators"] == null
            ? []
            : List<TopOperator>.from(
                json["top_operators"]!.map((x) => TopOperator.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_users": totalUsers,
        "total_operators": totalOperators,
        "total_cars": totalCars,
        "total_drivers": totalDrivers,
        "total_tour_packages": totalTourPackages,
        "total_bookings": totalBookings,
        "total_revenue": totalRevenue,
        "total_monthly_revenue": totalMonthlyRevenue,
        "top_operators": topOperators == null
            ? []
            : List<dynamic>.from(topOperators!.map((x) => x.toJson())),
      };
}

class TopOperator {
  final dynamic operatorId;
  final String? operatorName;
  final dynamic totalIncome;
  final double? percentage;

  TopOperator({
    this.operatorId,
    this.operatorName,
    this.totalIncome,
    this.percentage,
  });

  factory TopOperator.fromJson(Map<String, dynamic> json) => TopOperator(
        operatorId: json["operator_id"],
        operatorName: json["operator_name"],
        totalIncome: json["total_income"],
        percentage: json["percentage"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "operator_id": operatorId,
        "operator_name": operatorName,
        "total_income": totalIncome,
        "percentage": percentage,
      };
}
