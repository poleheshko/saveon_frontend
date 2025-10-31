import 'dart:ui';

import 'category_info.dart';

class TransactionsMockedData {
  final int categoryId;
  final String transactionName;
  final String date;
  final double amount;

  TransactionsMockedData({
    required this.categoryId,
    required this.transactionName,
    required this.date,
    required this.amount
  });
}

List<TransactionsMockedData> ListTransactionsMockedData = [
  TransactionsMockedData(
    categoryId: 1,
    transactionName: "Groceries",
    date: "2025-10-29T20:41:55.696Z",
    amount: 100.0,
  ),
  TransactionsMockedData(
    categoryId: 2,
    transactionName: "Restaurants",
    date: "2025-10-19T20:41:55.696Z",
    amount: 200.0,
  ),
  TransactionsMockedData(
    categoryId: 3,
    transactionName: "Transport",
    date: "2025-11-29T20:41:55.696Z",
    amount: 300.0,
  ),
  TransactionsMockedData(
    categoryId: 4,
    transactionName: "Home",
    date: "2025-10-23T20:41:55.696Z",
    amount: 400.0,
  ),
  TransactionsMockedData(
    categoryId: 5,
    transactionName: "Purchases",
    date: "2025-10-28T20:41:55.696Z",
    amount: 500.0,
  ),
];
