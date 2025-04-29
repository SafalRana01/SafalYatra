// To parse this JSON data, do
//
//     final availableCarsResponse = availableCarsResponseFromJson(jsonString);

import 'dart:convert';

AvailableCarsResponse availableCarsResponseFromJson(String str) =>
    AvailableCarsResponse.fromJson(json.decode(str));

String availableCarsResponseToJson(AvailableCarsResponse data) =>
    json.encode(data.toJson());

class AvailableCarsResponse {
  final bool? success;
  final String? message;
  final List<ListCar>? listCars;

  AvailableCarsResponse({
    this.success,
    this.message,
    this.listCars,
  });

  factory AvailableCarsResponse.fromJson(Map<String, dynamic> json) =>
      AvailableCarsResponse(
        success: json["success"],
        message: json["message"],
        listCars: json["listCars"] == null
            ? []
            : List<ListCar>.from(
                json["listCars"]!.map((x) => ListCar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "listCars": listCars == null
            ? []
            : List<dynamic>.from(listCars!.map((x) => x.toJson())),
      };
}

class ListCar {
  final String? carId;
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
  final String? categoryName;

  ListCar({
    this.carId,
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
    this.categoryName,
  });

  factory ListCar.fromJson(Map<String, dynamic> json) => ListCar(
        carId: json["car_id"],
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
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "car_id": carId,
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
        "category_name": categoryName,
      };
}
