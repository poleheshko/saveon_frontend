import '../categories/category_model.dart';
import '../folders/folder_model.dart';

class TransactionModel {
  final int transactionId;
  final int accountId;
  final String type;
  final double amount;
  final String title;
  final DateTime date;
  final DateTime createdAt;
  final int? categoryId;
  final int? folderId;
  final CategoryModel? category;
  final FolderModel? folder;

  TransactionModel({
    required this.transactionId,
    required this.accountId,
    required this.type,
    required this.amount,
    required this.title,
    required this.date,
    required this.createdAt,
    this.categoryId,
    this.folderId,
    this.category,
    this.folder,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionId: json['transactionId'] as int? ?? 0,
      accountId: json['accountId'] as int? ?? 0,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      title: json['title'] as String,
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
      categoryId: json['categoryId'] as int?,
      folderId: json['folderId'] as int?,
      category: json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null,
      folder: json['folder'] != null
        ? FolderModel.fromJson(json['folder'])
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'accountId': accountId,
      'type': type,
      'amount': amount,
      'title': title,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'categoryId': categoryId,
      'folderId': folderId,
    };
  }
}