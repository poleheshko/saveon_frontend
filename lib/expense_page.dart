import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/category_info.dart';
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
  Category? selectedCategory;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Zdejmij focus z dowolnego aktywnego TextFielda
        FocusManager.instance.primaryFocus?.unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: CommonPage(
        commonPageContent: [
          const AmountInput(),
          const SizedBox(width: double.infinity, height: 20),

          ChooseCategoryClass(
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),
          const SizedBox(width: double.infinity, height: 20),

          ChooseDateClass(
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
          const SizedBox(width: double.infinity, height: 100),

          // test
          ElevatedButton(onPressed: () {
            print('Wybrana kategoria: ${selectedCategory?.categoryName}');
            print('Wybrana data: ${selectedDate.toLocal()}');}, child: Text('Save'))

        ],
      ),
    );
  }
}
