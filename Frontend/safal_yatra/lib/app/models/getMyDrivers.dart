// To parse this JSON data, do
//
//     final myDriversResponse = myDriversResponseFromJson(jsonString);

import 'dart:convert';

MyDriversResponse myDriversResponseFromJson(String str) =>
    MyDriversResponse.fromJson(json.decode(str));

String myDriversResponseToJson(MyDriversResponse data) =>
    json.encode(data.toJson());

class MyDriversResponse {
  final bool? success;
  final String? message;
  final List<MyDriver>? myDrivers;

  MyDriversResponse({
    this.success,
    this.message,
    this.myDrivers,
  });

  factory MyDriversResponse.fromJson(Map<String, dynamic> json) =>
      MyDriversResponse(
        success: json["success"],
        message: json["message"],
        myDrivers: json["MyDrivers"] == null
            ? []
            : List<MyDriver>.from(
                json["MyDrivers"]!.map((x) => MyDriver.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "MyDrivers": myDrivers == null
            ? []
            : List<dynamic>.from(myDrivers!.map((x) => x.toJson())),
      };
}

class MyDriver {
  final String? driverId;
  final String? operatorId;
  final String? driverName;
  final String? phoneNumber;
  final String? licenseNumber;
  final dynamic imageUrl;
  final String? email;
  final String? gender;
  final String? age;
  final String? experience;
  final DateTime? addedDate;
  final String? status;

  MyDriver({
    this.driverId,
    this.operatorId,
    this.driverName,
    this.phoneNumber,
    this.licenseNumber,
    this.imageUrl,
    this.email,
    this.gender,
    this.age,
    this.experience,
    this.addedDate,
    this.status,
  });

  factory MyDriver.fromJson(Map<String, dynamic> json) => MyDriver(
        driverId: json["driver_id"],
        operatorId: json["operator_id"],
        driverName: json["driver_name"],
        phoneNumber: json["phone_number"],
        licenseNumber: json["license_number"],
        imageUrl: json["image_url"],
        email: json["email"],
        gender: json["gender"],
        age: json["age"],
        experience: json["experience"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "driver_id": driverId,
        "operator_id": operatorId,
        "driver_name": driverName,
        "phone_number": phoneNumber,
        "license_number": licenseNumber,
        "image_url": imageUrl,
        "email": email,
        "gender": gender,
        "age": age,
        "experience": experience,
        "added_date": addedDate?.toIso8601String(),
        "status": status,
      };
}
