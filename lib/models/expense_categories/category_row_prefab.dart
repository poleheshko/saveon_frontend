import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/category_info.dart';
import 'category_label_prefab.dart';

class CategoryRowPrefab extends StatelessWidget {
  final int categoryId;

  const CategoryRowPrefab({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final category = expenseCategories.firstWhere(
          (c) => c.categoryId == categoryId,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          category.categoryIconPath,
        ),
        SizedBox(width: 10),
        CategoryLabelPrefab(
          categoryName: category.categoryName,
          categoryLabelColor: category.labelColor,
          categoryTextColor: category.textColor,
        ),
      ],
    );
  }
}
