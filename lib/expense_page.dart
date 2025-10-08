import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/common/common_page.dart';
import 'models/expense_page_models/amount_input.dart';
import 'models/expense_page_models/date/choose_date_class.dart';
import 'models/expense_page_models/expense_categories/choose_category_class.dart';

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

        SizedBox(width: double.infinity, height: 20),

        ChooseDateClass(),

        SizedBox(width: double.infinity, height: 100),

        AmountInput(),

        SizedBox(width: double.infinity, height: 100),

      ],
    );
  }
}
