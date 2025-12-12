import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../data/transactions_mocked_data.dart';
import '../../utils/date_utils.dart';
import '../categories/category_model.dart';
import '../categories/category_service.dart';
import '../expense_page_models/expense_categories/category_label_prefab.dart';

class TransactionPrefabOld extends StatelessWidget {
  final int transactionId;

  const TransactionPrefabOld({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    final transaction = ListTransactionsMockedData[transactionId];
    final transactionDate = DateTime.parse(transaction.date);

    return Consumer<CategoryService>(
      builder: (context, categoryService, child) {
        final categories = categoryService.categories;
        
        // Find category by userCategoryId (matching categoryId from mocked data)
        CategoryModel? category;
        try {
          category = categories.firstWhere(
            (c) => c.userCategoryId == transaction.categoryId,
          );
        } catch (e) {
          // Category not found, will handle gracefully
        }

        // If category not found, show placeholder
        if (category == null) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.only(right: 10, top: 2, bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  transaction.transactionName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '-${transaction.amount.toString()} zł',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFE1075E),
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(right: 10, top: 2, bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // ***icon + transaction details (name and date)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  //***icon
                  SvgPicture.asset(category.categoryIconPath),

                  const SizedBox(width: 5),

                  // *** transaction details (name and date)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // name
                      CategoryLabelPrefab(
                        categoryName: transaction.transactionName,
                        categoryLabelColor: category.labelColorAsColor,
                        categoryTextColor: category.textColorAsColor,
                      ),

                      // date
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          SaveOnDateUtils.formatTime(transactionDate),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    ]
                  )
                ]
              ),

              // ***amount
              Text(
                '-${transaction.amount.toString()} zł',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFE1075E),
                ),
              )
            ]
          ),
        );
      },
    );
  }
}