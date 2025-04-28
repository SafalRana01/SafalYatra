// To parse this JSON data, do
//
//     final operatorProfileResponse = operatorProfileResponseFromJson(jsonString);

import 'dart:convert';

OperatorProfileResponse operatorProfileResponseFromJson(String str) =>
    OperatorProfileResponse.fromJson(json.decode(str));

String operatorProfileResponseToJson(OperatorProfileResponse data) =>
    json.encode(data.toJson());

class OperatorProfileResponse {
  final bool? success;
  final String? message;
  final Operators? operators;

  OperatorProfileResponse({
    this.success,
    this.message,
    this.operators,
  });

  factory OperatorProfileResponse.fromJson(Map<String, dynamic> json) =>
      OperatorProfileResponse(
        success: json["success"],
        message: json["message"],
        operators: json["operators"] == null
            ? null
            : Operators.fromJson(json["operators"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "operators": operators?.toJson(),
      };
}

class Operators {
  final String? operatorName;
  final String? phoneNumber;
  final String? email;
  final String? location;
  final String? registrationNumber;
  final dynamic imageUrl;
  final DateTime? addedDate;

  Operators({
    this.operatorName,
    this.phoneNumber,
    this.email,
    this.location,
    this.registrationNumber,
    this.imageUrl,
    this.addedDate,
  });

  factory Operators.fromJson(Map<String, dynamic> json) => Operators(
        operatorName: json["operator_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        location: json["location"],
        registrationNumber: json["registration_number"],
        imageUrl: json["image_url"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
      );

  Map<String, dynamic> toJson() => {
        "operator_name": operatorName,
        "phone_number": phoneNumber,
        "email": email,
        "location": location,
        "registration_number": registrationNumber,
        "image_url": imageUrl,
        "added_date": addedDate?.toIso8601String(),
      };
}
