// To parse this JSON data, do
//
//     final allOperatorsResponse = allOperatorsResponseFromJson(jsonString);

import 'dart:convert';

AllOperatorsResponse allOperatorsResponseFromJson(String str) =>
    AllOperatorsResponse.fromJson(json.decode(str));

String allOperatorsResponseToJson(AllOperatorsResponse data) =>
    json.encode(data.toJson());

class AllOperatorsResponse {
  final bool? success;
  final String? message;
  final List<AllOperator>? allOperators;

  AllOperatorsResponse({
    this.success,
    this.message,
    this.allOperators,
  });

  factory AllOperatorsResponse.fromJson(Map<String, dynamic> json) =>
      AllOperatorsResponse(
        success: json["success"],
        message: json["message"],
        allOperators: json["AllOperators"] == null
            ? []
            : List<AllOperator>.from(
                json["AllOperators"]!.map((x) => AllOperator.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "AllOperators": allOperators == null
            ? []
            : List<dynamic>.from(allOperators!.map((x) => x.toJson())),
      };
}

class AllOperator {
  final String? operatorId;
  final String? operatorName;
  final String? phoneNumber;
  final String? email;
  final String? registrationNumber;
  final String? location;
  final String? imageUrl;
  final String? status;
  final DateTime? addedDate;

  AllOperator({
    this.operatorId,
    this.operatorName,
    this.phoneNumber,
    this.email,
    this.registrationNumber,
    this.location,
    this.imageUrl,
    this.status,
    this.addedDate,
  });

  factory AllOperator.fromJson(Map<String, dynamic> json) => AllOperator(
        operatorId: json["operator_id"],
        operatorName: json["operator_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        registrationNumber: json["registration_number"],
        location: json["location"],
        imageUrl: json["image_url"],
        status: json["status"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
      );

  Map<String, dynamic> toJson() => {
        "operator_id": operatorId,
        "operator_name": operatorName,
        "phone_number": phoneNumber,
        "email": email,
        "registration_number": registrationNumber,
        "location": location,
        "image_url": imageUrl,
        "status": status,
        "added_date": addedDate?.toIso8601String(),
      };
}
