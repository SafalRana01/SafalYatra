// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromJson(jsonString);

import 'dart:convert';

CategoriesResponse categoriesResponseFromJson(String str) =>
    CategoriesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(CategoriesResponse data) =>
    json.encode(data.toJson());

class CategoriesResponse {
  final bool? success;
  final String? message;
  final List<Category>? categories;

  CategoriesResponse({
    this.success,
    this.message,
    this.categories,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        success: json["success"],
        message: json["message"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Category {
  final String? categoryId;
  final String? categoryName;
  final DateTime? addedDate;
  final String? isDeleted;

  Category({
    this.categoryId,
    this.categoryName,
    this.addedDate,
    this.isDeleted,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "added_date": addedDate?.toIso8601String(),
        "isDeleted": isDeleted,
      };
}
