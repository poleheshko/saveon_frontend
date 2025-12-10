import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saveon_frontend/models/transactions/transaction_model.dart';

import '../../utils/date_utils.dart';
import '../expense_page_models/expense_categories/category_label_prefab.dart';

class TransactionPrefab extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionPrefab({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
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
              SvgPicture.asset(transaction.category!.categoryIconPath),

              const SizedBox(width: 5),

              // *** transaction details (name and date)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // name
                  CategoryLabelPrefab(
                    categoryName: transaction.title,
                    categoryLabelColor: hexToColor(transaction.category?.labelColor ?? '#FFFFFF'),
                    categoryTextColor: hexToColor(transaction.category?.textColor ?? '#000000'),
                  ),

                  // date
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      SaveOnDateUtils.formatTime(transaction.date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  )
                ]
              )
            ]
          ),

          // ***amount
          transaction.type == 'EXPENSE'
              ? Text(
            '-${transaction.amount} zł',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFE1075E),
            ),
          )
              : Text(
            '+${transaction.amount} zł',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF000000),
            ),
          )

        ]
      ),
    );
  }
}