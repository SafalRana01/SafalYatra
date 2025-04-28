// To parse this JSON data, do
//
//     final adminProfileResponse = adminProfileResponseFromJson(jsonString);

import 'dart:convert';

AdminProfileResponse adminProfileResponseFromJson(String str) =>
    AdminProfileResponse.fromJson(json.decode(str));

String adminProfileResponseToJson(AdminProfileResponse data) =>
    json.encode(data.toJson());

class AdminProfileResponse {
  final bool? success;
  final String? message;
  final Admins? admins;

  AdminProfileResponse({
    this.success,
    this.message,
    this.admins,
  });

  factory AdminProfileResponse.fromJson(Map<String, dynamic> json) =>
      AdminProfileResponse(
        success: json["success"],
        message: json["message"],
        admins: json["admins"] == null ? null : Admins.fromJson(json["admins"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "admins": admins?.toJson(),
      };
}

class Admins {
  final String? adminName;
  final String? phoneNumber;
  final String? email;
  final dynamic imageUrl;
  final DateTime? createdAt;

  Admins({
    this.adminName,
    this.phoneNumber,
    this.email,
    this.imageUrl,
    this.createdAt,
  });

  factory Admins.fromJson(Map<String, dynamic> json) => Admins(
        adminName: json["admin_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "admin_name": adminName,
        "phone_number": phoneNumber,
        "email": email,
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
      };
}
