// To parse this JSON data, do
//
//     final userProfileResponse = userProfileResponseFromJson(jsonString);

import 'dart:convert';

UserProfileResponse userProfileResponseFromJson(String str) =>
    UserProfileResponse.fromJson(json.decode(str));

String userProfileResponseToJson(UserProfileResponse data) =>
    json.encode(data.toJson());

class UserProfileResponse {
  final bool? success;
  final String? message;
  final Users? users;

  UserProfileResponse({
    this.success,
    this.message,
    this.users,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        success: json["success"],
        message: json["message"],
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "users": users?.toJson(),
      };
}

class Users {
  final String? fullName;
  final String? phoneNumber;
  final String? email;
  final String? address;
  final String? gender;
  final dynamic imageUrl;
  final DateTime? addedDate;

  Users({
    this.fullName,
    this.phoneNumber,
    this.email,
    this.address,
    this.gender,
    this.imageUrl,
    this.addedDate,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        address: json["address"],
        gender: json["gender"],
        imageUrl: json["image_url"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "phone_number": phoneNumber,
        "email": email,
        "address": address,
        "gender": gender,
        "image_url": imageUrl,
        "added_date": addedDate?.toIso8601String(),
      };
}
