import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:saveon_frontend/models/transactions/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/app_config.dart';

class TransactionService extends ChangeNotifier {
  // ====== PRIVATE FIELDS ======
  List<TransactionModel> _transactions = [];
  bool _isLoading = false;
  String? _error;

  // ====== PUBLIC METHODS ======
  List<TransactionModel> get transactions => _transactions;

  bool get isLoading => _isLoading;

  String? get error => _error;

  // ===== TOKEN =====
  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // Fetch all transactions from API
  Future<void> fetchTransactions({
    int? accountId,
    String? type,
    int? categoryId,
    int? folderId,
    DateTime? from,
    DateTime? to,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // UI: Zaczynam ładować

    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception('No access token found');

      // === QUERY PARAMS ===
      final queryParams = <String, String>{};
      if (accountId != null) queryParams['accountId'] = accountId.toString();
      if (type != null) queryParams['type'] = type;
      if (categoryId != null) queryParams['categoryId'] = categoryId.toString();
      if (folderId != null) queryParams['folderId'] = folderId.toString();
      if (from != null) queryParams['from'] = from.toIso8601String();
      if (to != null) queryParams['to'] = to.toIso8601String();

      final uri = Uri.parse(
        '${AppConfig.baseUrl}/transactions',
      ).replace(queryParameters: queryParams);

      // ==== REQUEST ====
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // ==== SUCCESS ====
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);

        _transactions =
            jsonList.map((item) => TransactionModel.fromJson(item)).toList();

        _error = null;
      } else {
        _error = 'Failed to fetch: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners(); // UI: skończyłem ładować
    }
  }

  // Create a new transaction
  Future<bool> createTransaction({
    required int accountId,
    required String type,
    required double amount,
    required String title,
    required int categoryId,
    int? folderId,
    DateTime? date,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // UI: Zaczynam ładować

    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception('No access token found');

      final body = {
        'accountId': accountId,
        'type': type,
        'amount': amount,
        'title': title,
        'categoryId': categoryId,
        if (folderId != null) 'folderId': folderId,
        if (date != null) 'date': date.toIso8601String(),
      };

      final uri = Uri.parse('${AppConfig.baseUrl}/transactions');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await fetchTransactions(); // odśwież listę
        return true;
      } else {
        _error = 'Failed to create: ${response.statusCode}';
        return false;
      }
    } catch (e) {
      _error = 'Error: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update a transaction
  Future<bool> updateTransaction({
    required int transactionId,
    String? title,
    double? amount,
    int? categoryId,
    int? folderId,
    DateTime? date,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception('No access token');

      final body = <String, dynamic>{};
      if (title != null) body['title'] = title;
      if (amount != null) body['amount'] = amount;
      if (categoryId != null) body['categoryId'] = categoryId;
      if (folderId != null) body['folderId'] = folderId;
      if (date != null) body['date'] = date.toIso8601String();

      final uri = Uri.parse('${AppConfig.baseUrl}/transactions/$transactionId');

      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await fetchTransactions();
        return true;
      } else {
        _error = 'Failed to update: ${response.statusCode}';
        return false;
      }

    } catch (e) {
      _error = 'Error: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a transaction
  Future<bool> deleteTransaction(int transactionId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception('No access token');

      final uri = Uri.parse('${AppConfig.baseUrl}/transactions/$transactionId');

      final response = await http.delete(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _transactions.removeWhere((t) => t.transactionId == transactionId);
        notifyListeners();
        return true;
      } else {
        _error = 'Failed to delete: ${response.statusCode}';
        return false;
      }

    } catch (e) {
      _error = 'Error: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear all transactions (useful for logout)
  void clearTransactions() {
    _transactions = [];
    _error = null;
    notifyListeners();
  }
}
