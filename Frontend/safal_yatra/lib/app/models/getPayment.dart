// To parse this JSON data, do
//
//     final paymentResponse = paymentResponseFromJson(jsonString);

import 'dart:convert';

PaymentResponse paymentResponseFromJson(String str) =>
    PaymentResponse.fromJson(json.decode(str));

String paymentResponseToJson(PaymentResponse data) =>
    json.encode(data.toJson());

class PaymentResponse {
  final bool? success;
  final String? message;
  final List<Payment>? payments;

  PaymentResponse({
    this.success,
    this.message,
    this.payments,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentResponse(
        success: json["success"],
        message: json["message"],
        payments: json["payments"] == null
            ? []
            : List<Payment>.from(
                json["payments"]!.map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "payments": payments == null
            ? []
            : List<dynamic>.from(payments!.map((x) => x.toJson())),
      };
}

class Payment {
  final String? carId;
  final String? name;
  final String? licensePlate;
  final String? ratePerHours;
  final String? operatorId;
  final String? operatorName;
  final String? userId;
  final String? userName;
  final String? userEmail;
  final String? userPhoneNumber;
  final String? bookingId;
  final String? driverId;
  final dynamic packageId;
  final DateTime? bookingDate;
  final String? location;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final String? total;
  final String? paymentId;
  final String? paymentAmount;
  final DateTime? paymentDate;
  final String? paymentMode;
  final String? otherDetails;

  Payment({
    this.carId,
    this.name,
    this.licensePlate,
    this.ratePerHours,
    this.operatorId,
    this.operatorName,
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhoneNumber,
    this.bookingId,
    this.driverId,
    this.packageId,
    this.bookingDate,
    this.location,
    this.startDate,
    this.endDate,
    this.status,
    this.total,
    this.paymentId,
    this.paymentAmount,
    this.paymentDate,
    this.paymentMode,
    this.otherDetails,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        carId: json["car_id"],
        name: json["name"],
        licensePlate: json["license_plate"],
        ratePerHours: json["rate_per_hours"],
        operatorId: json["operator_id"],
        operatorName: json["operator_name"],
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userPhoneNumber: json["user_phone_number"],
        bookingId: json["booking_id"],
        driverId: json["driver_id"],
        packageId: json["package_id"],
        bookingDate: json["booking_date"] == null
            ? null
            : DateTime.parse(json["booking_date"]),
        location: json["location"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"],
        total: json["total"],
        paymentId: json["payment_id"],
        paymentAmount: json["payment_amount"],
        paymentDate: json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
        paymentMode: json["payment_mode"],
        otherDetails: json["other_details"],
      );

  Map<String, dynamic> toJson() => {
        "car_id": carId,
        "name": name,
        "license_plate": licensePlate,
        "rate_per_hours": ratePerHours,
        "operator_id": operatorId,
        "operator_name": operatorName,
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        "user_phone_number": userPhoneNumber,
        "booking_id": bookingId,
        "driver_id": driverId,
        "package_id": packageId,
        "booking_date": bookingDate?.toIso8601String(),
        "location": location,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "status": status,
        "total": total,
        "payment_id": paymentId,
        "payment_amount": paymentAmount,
        "payment_date": paymentDate?.toIso8601String(),
        "payment_mode": paymentMode,
        "other_details": otherDetails,
      };
}
