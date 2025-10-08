import 'package:flutter/material.dart';

class CategoryLabelPrefab extends StatelessWidget {
  final String categoryName;
  final Color categoryLabelColor;
  final Color categoryTextColor;

  const CategoryLabelPrefab({
    required this.categoryName,
    required this.categoryLabelColor,
    required this.categoryTextColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 42),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: categoryLabelColor, //background
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        categoryName,
        style: TextStyle(
          color: categoryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )
      ),
    );
  }
}
