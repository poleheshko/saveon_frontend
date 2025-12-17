import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:saveon_frontend/services/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class UserService extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;

  // Get access token from SharedPreferences
  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // Fetch current user data from /users endpoint
  Future<void> fetchCurrentUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await _getAccessToken();

      if (token == null) {
        _currentUser = null;
        _isLoading = false;
        notifyListeners();
        return;
      }

      final uri = Uri.parse('${AppConfig.baseUrl}/users');
      final response = await http
          .get(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(Duration(seconds: AppConfig.requestTimeoutSeconds));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        _currentUser = UserModel.fromJson(json);
        print('Successfully fetched user: ${_currentUser?.fullName}');
      } else if (response.statusCode == 401) {
        // Token is invalid or expired - clear session
        print('Unauthorized: Token is invalid or expired. Clearing session.');
        _currentUser = null;
        await _clearSession();
      } else {
        print('Failed to fetch user: Status ${response.statusCode}, Body: ${response.body}');
        _currentUser = null;
      }
    } on TimeoutException catch (e) {
      print('Timeout fetching current user: $e');
      _currentUser = null;
    } catch (e) {
      print('Error fetching current user: $e');
      _currentUser = null;
      // On network errors, we don't clear the session - it might be a temporary issue
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear session data from SharedPreferences
  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('accessToken');
  }

  // Clear user data on logout
  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }

  // Update user data (for when user info changes)
  void updateUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }
}