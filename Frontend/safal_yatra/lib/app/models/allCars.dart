// To parse this JSON data, do
//
//     final allCarsResponse = allCarsResponseFromJson(jsonString);

import 'dart:convert';

AllCarsResponse allCarsResponseFromJson(String str) => AllCarsResponse.fromJson(json.decode(str));

String allCarsResponseToJson(AllCarsResponse data) => json.encode(data.toJson());

class AllCarsResponse {
    final bool? success;
    final String? message;
    final List<AllCar>? allCars;

    AllCarsResponse({
        this.success,
        this.message,
        this.allCars,
    });

    factory AllCarsResponse.fromJson(Map<String, dynamic> json) => AllCarsResponse(
        success: json["success"],
        message: json["message"],
        allCars: json["AllCars"] == null ? [] : List<AllCar>.from(json["AllCars"]!.map((x) => AllCar.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "AllCars": allCars == null ? [] : List<dynamic>.from(allCars!.map((x) => x.toJson())),
    };
}

class AllCar {
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
    final String? operatorName;

    AllCar({
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
        this.operatorName,
    });

    factory AllCar.fromJson(Map<String, dynamic> json) => AllCar(
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
        addedDate: json["added_date"] == null ? null : DateTime.parse(json["added_date"]),
        rating: json["rating"],
        categoryName: json["category_name"],
        operatorName: json["operator_name"],
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
        "operator_name": operatorName,
    };
}
