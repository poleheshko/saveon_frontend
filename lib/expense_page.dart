import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saveon_frontend/models/common/saveon_button.dart';

import 'data/album_model.dart';
import 'models/categories/category_model.dart';
import 'models/common/common_page.dart';
import 'models/expense_page_models/album_selector/album_selector_class.dart';
import 'models/expense_page_models/amount_input.dart';
import 'models/expense_page_models/date/choose_date_class.dart';
import 'models/expense_page_models/expense_categories/choose_category_class.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  CategoryModel? selectedCategory;
  DateTime selectedDate = DateTime.now();
  double? enteredAmount;
  Set<int>? selectedAlbumes;

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
          AmountInput(
            onAmountChanged: (amount) {
              setState(() {
                enteredAmount = amount;
              });
            },
          ),
          const SizedBox(width: double.infinity, height: 20),

          SaveOnButton(
            buttonText: 'Receipt scan AI',
            onPressed: () {},
            buttonIconPath: 'lib/assets/other/camera_icon.svg',
          ),
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
          const SizedBox(width: double.infinity, height: 20),

          AlbumSelectorClass(
            onAlbumSelected: (selectedAlbums) {
              setState(() {
                selectedAlbumes = selectedAlbums;
              });
            }
          ),

          const SizedBox(width: double.infinity, height: 20),

          // test
          SaveOnButton(
            onPressed: () {
              print('Wybrana kategoria: ${selectedCategory?.categoryName}');
              print('Wybrana data: ${selectedDate.toLocal()}');
              print('Wprowadzona kwota: $enteredAmount');
              print('Wybrane albumy: ${selectedAlbumes?.map((i) => ListOfAlbums[i].albumName).join(', ')}');            },
            buttonText: 'Save',
          ),

          const SizedBox(width: double.infinity, height: 20),
        ],
      ),
    );
  }
}
