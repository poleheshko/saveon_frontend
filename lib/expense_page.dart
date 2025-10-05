import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'data/category_info.dart';
import 'models/common/common_page.dart';
import 'models/common/saveon_section.dart';
import 'models/expense_categories/category_row_prefab.dart';
import 'models/expense_categories/choose_category_class.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key, required this.title});

  final String title;

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    return CommonPage(
      commonPageContent: [
        SizedBox(width: double.infinity, height: 100),

        ChooseCategoryClass(),
      ],
    );
  }
}
