// To parse this JSON data, do
//
//     final citiesResponse = citiesResponseFromJson(jsonString);

import 'dart:convert';

CitiesResponse citiesResponseFromJson(String str) =>
    CitiesResponse.fromJson(json.decode(str));

String citiesResponseToJson(CitiesResponse data) => json.encode(data.toJson());

class CitiesResponse {
  final bool? success;
  final String? message;
  final List<String>? cities;

  CitiesResponse({
    this.success,
    this.message,
    this.cities,
  });

  factory CitiesResponse.fromJson(Map<String, dynamic> json) => CitiesResponse(
        success: json["success"],
        message: json["message"],
        cities: json["cities"] == null
            ? []
            : List<String>.from(json["cities"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "cities":
            cities == null ? [] : List<dynamic>.from(cities!.map((x) => x)),
      };
}
