import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:saveon_frontend/models/summary/summary_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/app_config.dart';

class SummaryService extends ChangeNotifier {
  // === PRIVATE FIELDS ===
  List<SummaryModel> _summary = [];
  bool _isLoading = false;
  String? _error;

  // === PUBLIC FIELDS ===
  List<SummaryModel> get summary => _summary;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // === TOKEN ===
  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> getSummary({int? userId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // UI: Zaczynam ładować

    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception("No access token found");

      // ==== QUERY PARAMS ====
      final queryParams = <String, String>{};
      if (userId != null) queryParams['userId'] = userId.toString();

      final uri = Uri.parse(
        '${AppConfig.baseUrl}/transactions/stats/summary',
      ).replace(queryParameters: queryParams);

      // ==== REQUEST ====
      final response = await http.get(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }
      );

      // ==== SUCCESS ====
      if(response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);

        _summary = [SummaryModel.fromJson(jsonMap)];
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