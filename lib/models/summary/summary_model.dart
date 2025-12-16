class SummaryModel {
  final double totalIncome;
  final double totalExpense;
  final double balance;

  SummaryModel({
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      totalIncome: (json['totalIncome'] as num).toDouble(),
      totalExpense: (json['totalExpense'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'balance': balance,
    };
  }
}