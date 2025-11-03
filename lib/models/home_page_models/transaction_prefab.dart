import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/category_info.dart';
import '../../data/transactions_mocked_data.dart';
import '../expense_page_models/expense_categories/category_label_prefab.dart';

class TransactionPrefab extends StatelessWidget {
  final int transactionId;

  const TransactionPrefab({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    final transaction = ListTransactionsMockedData[transactionId];

    final transactionIcon = ListExpenseCategories.firstWhere((i) => i.categoryId == ListTransactionsMockedData[transactionId].categoryId);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 10, top: 2, bottom: 2),
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
              SvgPicture.asset(transactionIcon.categoryIconPath),

              const SizedBox(width: 5),

              // *** transaction details (name and date)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // name
                  CategoryLabelPrefab(
                    categoryName: transaction.transactionName,
                    categoryLabelColor: transactionIcon.labelColor,
                    categoryTextColor: transactionIcon.textColor,
                  ),

                  // date
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      transaction.date,
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
              color: Color(0xFFE1075E),
            ),
          )
        ]
      ),
    );
  }
}