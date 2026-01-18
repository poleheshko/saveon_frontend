class AccountModel {
  final int accountId;
  final String accountName;
  final String accountType;
  final DateTime createdAt;
  final String role;
  final int shareBps;
  final int userAccountId;
  final bool isDefault;

  AccountModel({
    required this.accountId,
    required this.accountName,
    required this.accountType,
    required this.createdAt,
    required this.role,
    required this.shareBps,
    required this.userAccountId,
    required this.isDefault,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      accountId: json['accountId'] as int? ?? json['accountId'] as int? ?? 0,
      accountName: json['accountName'] as String? ?? '',
      accountType: json['accountType'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      role: json['role'] as String? ?? '',
      shareBps: json['shareBps'] as int? ?? 0,
      userAccountId: json['userAccountId'] as int? ?? 0,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }
}