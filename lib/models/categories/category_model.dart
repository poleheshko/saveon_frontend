import 'dart:ffi';

class CategoryModel {
  final int userCategoryId;
  final int userId;
  final String categoryName;
  final String categoryIconPath;
  final String labelColor;
  final String textColor;
  final bool isSystem;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModel({
    required this.userCategoryId,
    required this.userId,
    required this.categoryName,
    required this.categoryIconPath,
    required this.labelColor,
    required this.textColor,
    required this.isSystem,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      userCategoryId: json['userCategoryId'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      categoryName: json['categoryName'] as String,
      categoryIconPath: json['categoryIconPath'] as String,
      labelColor: json['labelColor'] as String,
      textColor: json['textColor'] as String,
      isSystem: json['isSystem'] as bool,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}