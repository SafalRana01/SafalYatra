// To parse this JSON data, do
//
//     final myBookingsResponse = myBookingsResponseFromJson(jsonString);

import 'dart:convert';

MyBookingsResponse myBookingsResponseFromJson(String str) =>
    MyBookingsResponse.fromJson(json.decode(str));

String myBookingsResponseToJson(MyBookingsResponse data) =>
    json.encode(data.toJson());

class MyBookingsResponse {
  final bool? success;
  final String? message;
  final List<Booking>? bookings;

  MyBookingsResponse({
    this.success,
    this.message,
    this.bookings,
  });

  factory MyBookingsResponse.fromJson(Map<String, dynamic> json) =>
      MyBookingsResponse(
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
  final String? driverName;
  final String? phoneNumber;
  final dynamic driverImageUrl;
  final String? gender;
  final String? age;
  final String? experience;
  final String? email;
  final String? operatorName;
  final String? operatorEmail;

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
    this.driverName,
    this.phoneNumber,
    this.driverImageUrl,
    this.gender,
    this.age,
    this.experience,
    this.email,
    this.operatorName,
    this.operatorEmail,
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
        driverName: json["driver_name"],
        phoneNumber: json["phone_number"],
        driverImageUrl: json["driver_image_url"],
        gender: json["gender"],
        age: json["age"],
        experience: json["experience"],
        email: json["email"],
        operatorName: json["operator_name"],
        operatorEmail: json["operator_email"],
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
        "driver_name": driverName,
        "phone_number": phoneNumber,
        "driver_image_url": driverImageUrl,
        "gender": gender,
        "age": age,
        "experience": experience,
        "email": email,
        "operator_name": operatorName,
        "operator_email": operatorEmail,
      };
}
