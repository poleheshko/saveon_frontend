import 'dart:ui';

class Category {
  final int categoryId;
  final String categoryName;
  final String categoryIconPath;
  final Color labelColor;
  final Color textColor;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryIconPath,
    required this.labelColor,
    required this.textColor
  });
}

