// To parse this JSON data, do
//
//     final driverProfileResponse = driverProfileResponseFromJson(jsonString);

import 'dart:convert';

DriverProfileResponse driverProfileResponseFromJson(String str) =>
    DriverProfileResponse.fromJson(json.decode(str));

String driverProfileResponseToJson(DriverProfileResponse data) =>
    json.encode(data.toJson());

class DriverProfileResponse {
  final bool? success;
  final String? message;
  final Driver? driver;

  DriverProfileResponse({
    this.success,
    this.message,
    this.driver,
  });

  factory DriverProfileResponse.fromJson(Map<String, dynamic> json) =>
      DriverProfileResponse(
        success: json["success"],
        message: json["message"],
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "driver": driver?.toJson(),
      };
}

class Driver {
  final String? driverName;
  final String? phoneNumber;
  final String? age;
  final String? gender;
  final String? experience;
  final String? email;
  final String? licenseNumber;
  final dynamic imageUrl;
  final DateTime? addedDate;
  final String? operatorName;

  Driver({
    this.driverName,
    this.phoneNumber,
    this.age,
    this.gender,
    this.experience,
    this.email,
    this.licenseNumber,
    this.imageUrl,
    this.addedDate,
    this.operatorName,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        driverName: json["driver_name"],
        phoneNumber: json["phone_number"],
        age: json["age"],
        gender: json["gender"],
        experience: json["experience"],
        email: json["email"],
        licenseNumber: json["license_number"],
        imageUrl: json["image_url"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
        operatorName: json["operator_name"],
      );

  Map<String, dynamic> toJson() => {
        "driver_name": driverName,
        "phone_number": phoneNumber,
        "age": age,
        "gender": gender,
        "experience": experience,
        "email": email,
        "license_number": licenseNumber,
        "image_url": imageUrl,
        "added_date": addedDate?.toIso8601String(),
        "operator_name": operatorName,
      };
}
