// To parse this JSON data, do
//
//     final allDriversResponse = allDriversResponseFromJson(jsonString);

import 'dart:convert';

AllDriversResponse allDriversResponseFromJson(String str) =>
    AllDriversResponse.fromJson(json.decode(str));

String allDriversResponseToJson(AllDriversResponse data) =>
    json.encode(data.toJson());

class AllDriversResponse {
  final bool? success;
  final String? message;
  final List<AllDriver>? allDrivers;

  AllDriversResponse({
    this.success,
    this.message,
    this.allDrivers,
  });

  factory AllDriversResponse.fromJson(Map<String, dynamic> json) =>
      AllDriversResponse(
        success: json["success"],
        message: json["message"],
        allDrivers: json["AllDrivers"] == null
            ? []
            : List<AllDriver>.from(
                json["AllDrivers"]!.map((x) => AllDriver.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "AllDrivers": allDrivers == null
            ? []
            : List<dynamic>.from(allDrivers!.map((x) => x.toJson())),
      };
}

class AllDriver {
  final String? driverId;
  final String? driverName;
  final String? phoneNumber;
  final String? email;
  final String? gender;
  final String? age;
  final String? experience;
  final String? licenseNumber;
  final String? imageUrl;
  final DateTime? addedDate;
  final String? operatorName;

  AllDriver({
    this.driverId,
    this.driverName,
    this.phoneNumber,
    this.email,
    this.gender,
    this.age,
    this.experience,
    this.licenseNumber,
    this.imageUrl,
    this.addedDate,
    this.operatorName,
  });

  factory AllDriver.fromJson(Map<String, dynamic> json) => AllDriver(
        driverId: json["driver_id"],
        driverName: json["driver_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        gender: json["gender"],
        age: json["age"],
        experience: json["experience"],
        licenseNumber: json["license_number"],
        imageUrl: json["image_url"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
        operatorName: json["operator_name"],
      );

  Map<String, dynamic> toJson() => {
        "driver_id": driverId,
        "driver_name": driverName,
        "phone_number": phoneNumber,
        "email": email,
        "gender": gender,
        "age": age,
        "experience": experience,
        "license_number": licenseNumber,
        "image_url": imageUrl,
        "added_date": addedDate?.toIso8601String(),
        "operator_name": operatorName,
      };
}
