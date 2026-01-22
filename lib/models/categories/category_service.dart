import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:saveon_frontend/config/app_config.dart';
import 'package:saveon_frontend/models/categories/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService extends ChangeNotifier {
  // === PRIVATE FIELDS ===
  List<CategoryModel> _categories = [];
  bool _isLoading = false;
  String? _error;

  // === PUBLIC FIELDS ===
  List<CategoryModel> get categories => _categories;

  bool get isLoading => _isLoading;

  String? get error => _error;

  // === TOKEN ===
  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // Fetch all categories from API
  Future<void> fetchCategories({int? userId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // UI: Zaczynam ładować

    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception('No access token found');

      // ==== QUERY PARAMS ====
      final queryParams = <String, String>{};
      if (userId != null) queryParams['userId'] = userId.toString();

      final uri = Uri.parse(
        '${AppConfig.baseUrl}/categories',
      ).replace(queryParameters: queryParams);

      // ==== REQUEST ====
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // 🔍 LOG CAŁEGO RESPONSE
      print('🟢 [CATEGORIES] Response Status: ${response.statusCode}');
      print('🟢 [CATEGORIES] Full Response Body:');
      print(response.body);
      print('🟢 [CATEGORIES] --- End of Response ---\n');

      // ==== SUCCESS ====
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);

        _categories =
            jsonList.map((item) => CategoryModel.fromJson(item)).toList();
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
}
