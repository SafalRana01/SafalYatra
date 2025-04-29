// To parse this JSON data, do
//
//     final myCarResponse = myCarResponseFromJson(jsonString);

import 'dart:convert';

MyCarResponse myCarResponseFromJson(String str) => MyCarResponse.fromJson(json.decode(str));

String myCarResponseToJson(MyCarResponse data) => json.encode(data.toJson());

class MyCarResponse {
    final bool? success;
    final String? message;
    final List<MyCar>? myCars;

    MyCarResponse({
        this.success,
        this.message,
        this.myCars,
    });

    factory MyCarResponse.fromJson(Map<String, dynamic> json) => MyCarResponse(
        success: json["success"],
        message: json["message"],
        myCars: json["MyCars"] == null ? [] : List<MyCar>.from(json["MyCars"]!.map((x) => MyCar.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "MyCars": myCars == null ? [] : List<dynamic>.from(myCars!.map((x) => x.toJson())),
    };
}

class MyCar {
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

    MyCar({
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

    factory MyCar.fromJson(Map<String, dynamic> json) => MyCar(
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
