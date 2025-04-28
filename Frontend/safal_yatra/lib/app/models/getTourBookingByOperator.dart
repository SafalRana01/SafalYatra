// To parse this JSON data, do
//
//     final userBookedTourResponse = userBookedTourResponseFromJson(jsonString);

import 'dart:convert';

UserBookedTourResponse userBookedTourResponseFromJson(String str) =>
    UserBookedTourResponse.fromJson(json.decode(str));

String userBookedTourResponseToJson(UserBookedTourResponse data) =>
    json.encode(data.toJson());

class UserBookedTourResponse {
  final bool? success;
  final String? message;
  final List<TourBooking>? tourBookings;

  UserBookedTourResponse({
    this.success,
    this.message,
    this.tourBookings,
  });

  factory UserBookedTourResponse.fromJson(Map<String, dynamic> json) =>
      UserBookedTourResponse(
        success: json["success"],
        message: json["message"],
        tourBookings: json["tour_bookings"] == null
            ? []
            : List<TourBooking>.from(
                json["tour_bookings"]!.map((x) => TourBooking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "tour_bookings": tourBookings == null
            ? []
            : List<dynamic>.from(tourBookings!.map((x) => x.toJson())),
      };
}

class TourBooking {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? bookingId;
  final DateTime? bookingDate;
  final String? total;

  TourBooking({
    this.userId,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.bookingId,
    this.bookingDate,
    this.total,
  });

  factory TourBooking.fromJson(Map<String, dynamic> json) => TourBooking(
        userId: json["user_id"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        bookingId: json["booking_id"],
        bookingDate: json["booking_date"] == null
            ? null
            : DateTime.parse(json["booking_date"]),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "email": email,
        "phone_number": phoneNumber,
        "booking_id": bookingId,
        "booking_date": bookingDate?.toIso8601String(),
        "total": total,
      };
}
