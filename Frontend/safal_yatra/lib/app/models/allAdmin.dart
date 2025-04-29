// To parse this JSON data, do
//
//     final allAdminResponse = allAdminResponseFromJson(jsonString);

import 'dart:convert';

AllAdminResponse allAdminResponseFromJson(String str) =>
    AllAdminResponse.fromJson(json.decode(str));

String allAdminResponseToJson(AllAdminResponse data) =>
    json.encode(data.toJson());

class AllAdminResponse {
  final bool? success;
  final String? message;
  final List<AllAdmin>? allAdmins;

  AllAdminResponse({
    this.success,
    this.message,
    this.allAdmins,
  });

  factory AllAdminResponse.fromJson(Map<String, dynamic> json) =>
      AllAdminResponse(
        success: json["success"],
        message: json["message"],
        allAdmins: json["AllAdmins"] == null
            ? []
            : List<AllAdmin>.from(
                json["AllAdmins"]!.map((x) => AllAdmin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "AllAdmins": allAdmins == null
            ? []
            : List<dynamic>.from(allAdmins!.map((x) => x.toJson())),
      };
}

class AllAdmin {
  final String? adminId;
  final String? adminName;
  final String? phoneNumber;
  final String? email;
  final dynamic imageUrl;
  final DateTime? createdAt;

  AllAdmin({
    this.adminId,
    this.adminName,
    this.phoneNumber,
    this.email,
    this.imageUrl,
    this.createdAt,
  });

  factory AllAdmin.fromJson(Map<String, dynamic> json) => AllAdmin(
        adminId: json["admin_id"],
        adminName: json["admin_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "admin_id": adminId,
        "admin_name": adminName,
        "phone_number": phoneNumber,
        "email": email,
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
      };
}
