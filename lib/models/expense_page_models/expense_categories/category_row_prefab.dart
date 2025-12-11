import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../categories/category_model.dart';
import '../../categories/category_service.dart';
import 'category_label_prefab.dart';

class CategoryRowPrefab extends StatelessWidget {
  final int? userCategoryId;
  final CategoryModel? category;

  const CategoryRowPrefab({super.key, this.userCategoryId, this.category})
    : assert(
        userCategoryId != null || category != null,
        'Either userCategoryId or category must be provided',
      );

  @override
  Widget build(BuildContext context) {
    // if category has been provided we use those data directly
    if (category != null) {
      return _buildCategoryRow(category!);
    }

    return Consumer<CategoryService>(
      builder: (context, categoryService, child) {
        final categories = categoryService.categories;

        try {
          final foundCategory = categories.firstWhere(
            (c) => c.userCategoryId == userCategoryId,
          );
          return _buildCategoryRow(foundCategory);
        } catch (e) {
          // Jeśli nie znaleziono, zwróć placeholder
          return SizedBox(
            width: double.infinity,
            child: Text(
              'Category not found',
              style: TextStyle(color: CupertinoColors.systemGrey),
            ),
          );
        }
      },
    );
  }

  Widget _buildCategoryRow(CategoryModel category) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(category.categoryIconPath),
          SizedBox(width: 10),
          CategoryLabelPrefab(
            categoryName: category.categoryName,
            categoryLabelColor: category.labelColorAsColor,
            categoryTextColor: category.textColorAsColor,
          ),
        ],
      ),
    );
  }
}
