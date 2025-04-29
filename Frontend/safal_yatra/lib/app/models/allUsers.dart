// To parse this JSON data, do
//
//     final allUsersResponse = allUsersResponseFromJson(jsonString);

import 'dart:convert';

AllUsersResponse allUsersResponseFromJson(String str) =>
    AllUsersResponse.fromJson(json.decode(str));

String allUsersResponseToJson(AllUsersResponse data) =>
    json.encode(data.toJson());

class AllUsersResponse {
  final bool? success;
  final String? message;
  final List<AllUser>? allUsers;

  AllUsersResponse({
    this.success,
    this.message,
    this.allUsers,
  });

  factory AllUsersResponse.fromJson(Map<String, dynamic> json) =>
      AllUsersResponse(
        success: json["success"],
        message: json["message"],
        allUsers: json["AllUsers"] == null
            ? []
            : List<AllUser>.from(
                json["AllUsers"]!.map((x) => AllUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "AllUsers": allUsers == null
            ? []
            : List<dynamic>.from(allUsers!.map((x) => x.toJson())),
      };
}

class AllUser {
  final String? userId;
  final String? fullName;
  final String? phoneNumber;
  final String? gender;
  final String? email;
  final String? address;
  final String? imageUrl;
  final DateTime? addedDate;

  AllUser({
    this.userId,
    this.fullName,
    this.phoneNumber,
    this.gender,
    this.email,
    this.address,
    this.imageUrl,
    this.addedDate,
  });

  factory AllUser.fromJson(Map<String, dynamic> json) => AllUser(
        userId: json["user_id"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        email: json["email"],
        address: json["address"],
        imageUrl: json["image_url"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "gender": gender,
        "email": email,
        "address": address,
        "image_url": imageUrl,
        "added_date": addedDate?.toIso8601String(),
      };
}
