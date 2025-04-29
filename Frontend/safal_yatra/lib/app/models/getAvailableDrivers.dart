// To parse this JSON data, do
//
//     final availableDriversResponse = availableDriversResponseFromJson(jsonString);

import 'dart:convert';

AvailableDriversResponse availableDriversResponseFromJson(String str) =>
    AvailableDriversResponse.fromJson(json.decode(str));

String availableDriversResponseToJson(AvailableDriversResponse data) =>
    json.encode(data.toJson());

class AvailableDriversResponse {
  final bool? success;
  final String? message;
  final List<ListDriver>? listDrivers;

  AvailableDriversResponse({
    this.success,
    this.message,
    this.listDrivers,
  });

  factory AvailableDriversResponse.fromJson(Map<String, dynamic> json) =>
      AvailableDriversResponse(
        success: json["success"],
        message: json["message"],
        listDrivers: json["listDrivers"] == null
            ? []
            : List<ListDriver>.from(
                json["listDrivers"]!.map((x) => ListDriver.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "listDrivers": listDrivers == null
            ? []
            : List<dynamic>.from(listDrivers!.map((x) => x.toJson())),
      };
}

class ListDriver {
  final String? driverId;
  final String? driverName;
  final String? phoneNumber;
  final String? email;
  final dynamic imageUrl;
  final String? age;
  final String? gender;
  final String? experience;

  ListDriver({
    this.driverId,
    this.driverName,
    this.phoneNumber,
    this.email,
    this.imageUrl,
    this.age,
    this.gender,
    this.experience,
  });

  factory ListDriver.fromJson(Map<String, dynamic> json) => ListDriver(
        driverId: json["driver_id"],
        driverName: json["driver_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        imageUrl: json["image_url"],
        age: json["age"],
        gender: json["gender"],
        experience: json["experience"],
      );

  Map<String, dynamic> toJson() => {
        "driver_id": driverId,
        "driver_name": driverName,
        "phone_number": phoneNumber,
        "email": email,
        "image_url": imageUrl,
        "age": age,
        "gender": gender,
        "experience": experience,
      };
}
