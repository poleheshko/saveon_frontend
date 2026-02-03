import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saveon_frontend/models/accounts/account_service.dart';
import 'package:saveon_frontend/models/common/saveon_button.dart';
import 'package:saveon_frontend/models/transactions/transaction_service.dart';

import 'models/categories/category_model.dart';
import 'models/categories/category_service.dart';
import 'models/common/common_page.dart';
import 'models/expense_page_models/album_selector/album_selector_class.dart';
import 'models/expense_page_models/amount_input.dart';
import 'models/expense_page_models/date/choose_date_class.dart';
import 'models/expense_page_models/expense_categories/choose_category_class.dart';
import 'models/expense_page_models/transactionTypeSelector.dart';
import 'models/folders/folder_service.dart';

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
  TransactionType _type = TransactionType.expense;

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

          TransactionTypeSelector(
            onChanged: (newType) {
              setState(() {
                _type = newType;
              });
            },
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

          FolderSelectorClass(
            onAlbumSelected: (selectedIndices) {
              setState(() {
                selectedAlbumes = selectedIndices;
              });
            },
          ),

          const SizedBox(width: double.infinity, height: 20),

          // test
          SaveOnButton(
              onPressed: () async {
                // KROK 1: Walidacja danych
                if (enteredAmount == null || enteredAmount! <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Wprowadź poprawną kwotę')),
                  );
                  return;
                }

                if (selectedCategory == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Wybierz kategorię')),
                  );
                  return;
                }

                // KROK 2: Pobieranie serwisów
                final transactionService = Provider.of<TransactionService>(
                  context,
                  listen: false,
                );
                final accountService = Provider.of<AccountService>(
                  context,
                  listen: false,
                );
                final accounts = accountService.accounts;

                // Debug: pokaż listę kont
                print('📋 accounts (lista): $accounts');
                print('📋 Liczba kont: ${accounts.length}');

                // KROK 3: Znajdź konto (domyślne lub pierwsze)
                if (accounts.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Brak dostępnych kont')),
                  );
                  return;
                }

                // znajdź domyślne konto lub użyj pierwszego
                final account = accounts.firstWhere(
                      (acc) => acc.isDefault,
                  orElse: () => accounts.first,
                );

                print('Chosen account: ${account.accountName}');

                print('$selectedAlbumes');

                // KROK 4: Przygotuj folderId (jeśli wybrano foldery)
                List<int> folderIds = [];
                if (selectedAlbumes != null && selectedAlbumes!.isNotEmpty) {
                  final folders =
                      Provider
                          .of<FolderService>(context, listen: false)
                          .folder;
                  for (final index in selectedAlbumes!) {
                    if (index >= 0 && index < folders.length) {
                      folderIds.add(folders[index].folderId);
                    }
                  }
                  print('foldexIndex: $folderIds');
                }

                print('transaction type: $_type');

                // KROK 5: Wyślij expense do backendu
                try {
                  final success = await transactionService.createTransaction(
                      accountId: account.accountId,
                      type: _type.apiValue,
                      amount: enteredAmount!,
                      title: selectedCategory!.categoryName,
                      categoryId: selectedCategory!.userCategoryId,
                      date: selectedDate,
                      folderId: folderIds,
                  );

                  );
                }
              },
              buttonText: 'Save'
          ),

          const SizedBox(width: double.infinity, height: 20),
        ],
      ),
    );
  }
}
