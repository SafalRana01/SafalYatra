// To parse this JSON data, do
//
//     final myTourPackageResponse = myTourPackageResponseFromJson(jsonString);

import 'dart:convert';

MyTourPackageResponse myTourPackageResponseFromJson(String str) =>
    MyTourPackageResponse.fromJson(json.decode(str));

String myTourPackageResponseToJson(MyTourPackageResponse data) =>
    json.encode(data.toJson());

class MyTourPackageResponse {
  final bool? success;
  final String? message;
  final List<TourBooking>? tourBookings;

  MyTourPackageResponse({
    this.success,
    this.message,
    this.tourBookings,
  });

  factory MyTourPackageResponse.fromJson(Map<String, dynamic> json) =>
      MyTourPackageResponse(
        success: json["success"],
        message: json["message"],
        tourBookings: json["tour_bookings"] == null
            ? []
            : List<TourBooking>.from(
                json["tour_bookings"]!.map((x) => TourBooking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "tour_bookings": tourBookings == null
            ? []
            : List<dynamic>.from(tourBookings!.map((x) => x.toJson())),
      };
}

class TourBooking {
  final String? bookingId;
  final String? userId;
  final String? carId;
  final String? driverId;
  final String? packageId;
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
  final String? operatorName;
  final String? operatorEmail;
  final String? packageName;
  final String? tourImageUrl;
  final String? perPersonPrice;
  final DateTime? tourStartDate;
  final DateTime? tourEndDate;
  final String? startLocation;
  final String? destination;
  final String? duration;

  TourBooking({
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
    this.operatorName,
    this.operatorEmail,
    this.packageName,
    this.tourImageUrl,
    this.perPersonPrice,
    this.tourStartDate,
    this.tourEndDate,
    this.startLocation,
    this.destination,
    this.duration,
  });

  factory TourBooking.fromJson(Map<String, dynamic> json) => TourBooking(
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
        operatorName: json["operator_name"],
        operatorEmail: json["operator_email"],
        packageName: json["package_name"],
        tourImageUrl: json["tour_image_url"],
        perPersonPrice: json["per_person_price"],
        tourStartDate: json["tour_start_date"] == null
            ? null
            : DateTime.parse(json["tour_start_date"]),
        tourEndDate: json["tour_end_date"] == null
            ? null
            : DateTime.parse(json["tour_end_date"]),
        startLocation: json["start_location"],
        destination: json["destination"],
        duration: json["duration"],
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
        "operator_name": operatorName,
        "operator_email": operatorEmail,
        "package_name": packageName,
        "tour_image_url": tourImageUrl,
        "per_person_price": perPersonPrice,
        "tour_start_date": tourStartDate?.toIso8601String(),
        "tour_end_date": tourEndDate?.toIso8601String(),
        "start_location": startLocation,
        "destination": destination,
        "duration": duration,
      };
}
