// To parse this JSON data, do
//
//     final availableTourPackageResponse = availableTourPackageResponseFromJson(jsonString);

import 'dart:convert';

AvailableTourPackageResponse availableTourPackageResponseFromJson(String str) =>
    AvailableTourPackageResponse.fromJson(json.decode(str));

String availableTourPackageResponseToJson(AvailableTourPackageResponse data) =>
    json.encode(data.toJson());

class AvailableTourPackageResponse {
  final bool? success;
  final String? message;
  final List<AvailableTourPackage>? availableTourPackages;

  AvailableTourPackageResponse({
    this.success,
    this.message,
    this.availableTourPackages,
  });

  factory AvailableTourPackageResponse.fromJson(Map<String, dynamic> json) =>
      AvailableTourPackageResponse(
        success: json["success"],
        message: json["message"],
        availableTourPackages: json["AvailableTourPackages"] == null
            ? []
            : List<AvailableTourPackage>.from(json["AvailableTourPackages"]!
                .map((x) => AvailableTourPackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "AvailableTourPackages": availableTourPackages == null
            ? []
            : List<dynamic>.from(availableTourPackages!.map((x) => x.toJson())),
      };
}

class AvailableTourPackage {
  final String? packageId;
  final String? operatorId;
  final String? packageName;
  final String? description;
  final String? price;
  final String? duration;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final String? carId;
  final String? driverId;
  final String? startLocation;
  final String? destination;
  final String? tourCapacity;
  final String? availableCapacity;
  final String? imageUrl;
  final DateTime? addedDate;
  final String? name;
  final String? carImageUrl;
  final String? licensePlate;
  final String? fuelType;
  final String? luggageCapacity;
  final String? rating;
  final String? categoryId;
  final String? categoryName;
  final String? operatorName;
  final String? email;
  final String? operatorPhoneNumber;
  final String? driverName;
  final String? driverPhoneNumber;

  AvailableTourPackage({
    this.packageId,
    this.operatorId,
    this.packageName,
    this.description,
    this.price,
    this.duration,
    this.startDate,
    this.endDate,
    this.status,
    this.carId,
    this.driverId,
    this.startLocation,
    this.destination,
    this.tourCapacity,
    this.availableCapacity,
    this.imageUrl,
    this.addedDate,
    this.name,
    this.carImageUrl,
    this.licensePlate,
    this.fuelType,
    this.luggageCapacity,
    this.rating,
    this.categoryId,
    this.categoryName,
    this.operatorName,
    this.email,
    this.operatorPhoneNumber,
    this.driverName,
    this.driverPhoneNumber,
  });

  factory AvailableTourPackage.fromJson(Map<String, dynamic> json) =>
      AvailableTourPackage(
        packageId: json["package_id"],
        operatorId: json["operator_id"],
        packageName: json["package_name"],
        description: json["description"],
        price: json["price"],
        duration: json["duration"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"],
        carId: json["car_id"],
        driverId: json["driver_id"],
        startLocation: json["start_location"],
        destination: json["destination"],
        tourCapacity: json["tour_capacity"],
        availableCapacity: json["available_capacity"],
        imageUrl: json["image_url"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
        name: json["name"],
        carImageUrl: json["car_image_url"],
        licensePlate: json["license_plate"],
        fuelType: json["fuel_type"],
        luggageCapacity: json["luggage_capacity"],
        rating: json["rating"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        operatorName: json["operator_name"],
        email: json["email"],
        operatorPhoneNumber: json["operator_phone_number"],
        driverName: json["driver_name"],
        driverPhoneNumber: json["driver_phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "operator_id": operatorId,
        "package_name": packageName,
        "description": description,
        "price": price,
        "duration": duration,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "status": status,
        "car_id": carId,
        "driver_id": driverId,
        "start_location": startLocation,
        "destination": destination,
        "tour_capacity": tourCapacity,
        "available_capacity": availableCapacity,
        "image_url": imageUrl,
        "added_date": addedDate?.toIso8601String(),
        "name": name,
        "car_image_url": carImageUrl,
        "license_plate": licensePlate,
        "fuel_type": fuelType,
        "luggage_capacity": luggageCapacity,
        "rating": rating,
        "category_id": categoryId,
        "category_name": categoryName,
        "operator_name": operatorName,
        "email": email,
        "operator_phone_number": operatorPhoneNumber,
        "driver_name": driverName,
        "driver_phone_number": driverPhoneNumber,
      };
}
