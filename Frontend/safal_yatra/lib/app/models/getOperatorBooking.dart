// To parse this JSON data, do
//
//     final operatorBookingResponse = operatorBookingResponseFromJson(jsonString);

import 'dart:convert';

OperatorBookingResponse operatorBookingResponseFromJson(String str) =>
    OperatorBookingResponse.fromJson(json.decode(str));

String operatorBookingResponseToJson(OperatorBookingResponse data) =>
    json.encode(data.toJson());

class OperatorBookingResponse {
  final bool? success;
  final String? message;
  final List<Booking>? bookings;

  OperatorBookingResponse({
    this.success,
    this.message,
    this.bookings,
  });

  factory OperatorBookingResponse.fromJson(Map<String, dynamic> json) =>
      OperatorBookingResponse(
        success: json["success"],
        message: json["message"],
        bookings: json["bookings"] == null
            ? []
            : List<Booking>.from(
                json["bookings"]!.map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "bookings": bookings == null
            ? []
            : List<dynamic>.from(bookings!.map((x) => x.toJson())),
      };
}

class Booking {
  final String? bookingId;
  final String? userId;
  final String? carId;
  final String? driverId;
  final dynamic packageId;
  final DateTime? bookingDate;
  final String? location;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final String? total;
  final String? operatorId;
  final String? name;
  final String? categoryId;
  final String? licensePlate;
  final String? imageUrl;
  final String? seatingCapacity;
  final String? fuelType;
  final String? luggageCapacity;
  final String? numberOfDoors;
  final String? ratePerHours;
  final DateTime? addedDate;
  final String? rating;
  final String? userName;
  final String? userEmail;
  final String? userPhoneNumber;
  final String? userImageUrl;
  final String? driverName;
  final String? driverPhoneNumber;
  final String? driverEmail;
  final dynamic driverImageUrl;

  Booking({
    this.bookingId,
    this.userId,
    this.carId,
    this.driverId,
    this.packageId,
    this.bookingDate,
    this.location,
    this.startDate,
    this.endDate,
    this.status,
    this.total,
    this.operatorId,
    this.name,
    this.categoryId,
    this.licensePlate,
    this.imageUrl,
    this.seatingCapacity,
    this.fuelType,
    this.luggageCapacity,
    this.numberOfDoors,
    this.ratePerHours,
    this.addedDate,
    this.rating,
    this.userName,
    this.userEmail,
    this.userPhoneNumber,
    this.userImageUrl,
    this.driverName,
    this.driverPhoneNumber,
    this.driverEmail,
    this.driverImageUrl,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        bookingId: json["booking_id"],
        userId: json["user_id"],
        carId: json["car_id"],
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
        operatorId: json["operator_id"],
        name: json["name"],
        categoryId: json["category_id"],
        licensePlate: json["license_plate"],
        imageUrl: json["image_url"],
        seatingCapacity: json["seating_capacity"],
        fuelType: json["fuel_type"],
        luggageCapacity: json["luggage_capacity"],
        numberOfDoors: json["number_of_doors"],
        ratePerHours: json["rate_per_hours"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
        rating: json["rating"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userPhoneNumber: json["user_phone_number"],
        userImageUrl: json["user_image_url"],
        driverName: json["driver_name"],
        driverPhoneNumber: json["driver_phone_number"],
        driverEmail: json["driver_email"],
        driverImageUrl: json["driver_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "user_id": userId,
        "car_id": carId,
        "driver_id": driverId,
        "package_id": packageId,
        "booking_date": bookingDate?.toIso8601String(),
        "location": location,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "status": status,
        "total": total,
        "operator_id": operatorId,
        "name": name,
        "category_id": categoryId,
        "license_plate": licensePlate,
        "image_url": imageUrl,
        "seating_capacity": seatingCapacity,
        "fuel_type": fuelType,
        "luggage_capacity": luggageCapacity,
        "number_of_doors": numberOfDoors,
        "rate_per_hours": ratePerHours,
        "added_date": addedDate?.toIso8601String(),
        "rating": rating,
        "user_name": userName,
        "user_email": userEmail,
        "user_phone_number": userPhoneNumber,
        "user_image_url": userImageUrl,
        "driver_name": driverName,
        "driver_phone_number": driverPhoneNumber,
        "driver_email": driverEmail,
        "driver_image_url": driverImageUrl,
      };
}
