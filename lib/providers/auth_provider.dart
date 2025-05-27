// providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isDemoMode = false;
  String? _token;
  String? _userId;
  Map<String, dynamic>? _userData;

  bool get isAuthenticated => _isAuthenticated;
  bool get isDemoMode => _isDemoMode;
  String? get token => _token;
  String? get userId => _userId;
  Map<String, dynamic>? get userData => _userData;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    try {
      final authBox = Hive.box('appSettings');

      _isAuthenticated = authBox.get('isAuthenticated', defaultValue: false);
      _isDemoMode = authBox.get('isDemoMode', defaultValue: false);
      _token = authBox.get('authToken');
      _userId = authBox.get('userId');

      final userDataString = authBox.get('userData');
      if (userDataString != null) {
        _userData = json.decode(userDataString);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading auth state: $e');
    }
  }

  Future<void> _saveAuthState() async {
    try {
      final authBox = Hive.box('appSettings');

      await authBox.put('isAuthenticated', _isAuthenticated);
      await authBox.put('isDemoMode', _isDemoMode);
      await authBox.put('authToken', _token);
      await authBox.put('userId', _userId);

      if (_userData != null) {
        await authBox.put('userData', json.encode(_userData!));
      } else {
        await authBox.delete('userData');
      }
    } catch (e) {
      debugPrint('Error saving auth state: $e');
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      // TODO: Replace with your actual API endpoint
      const String apiUrl = 'https://your-api-endpoint.com/auth/login';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        _isAuthenticated = true;
        _isDemoMode = false;
        _token = responseData['token'];
        _userId = responseData['userId'];
        _userData = responseData['userData'];

        await _saveAuthState();
        notifyListeners();

        return true;
      } else {
        debugPrint('Login failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Login error: $e');
      // For demo purposes, we'll simulate a successful login with demo credentials
      if (username.toLowerCase() == 'demo' && password == 'demo123') {
        return await _simulateSuccessfulLogin();
      }
      return false;
    }
  }

  Future<bool> _simulateSuccessfulLogin() async {
    _isAuthenticated = true;
    _isDemoMode = false;
    _token = 'demo_token_${DateTime.now().millisecondsSinceEpoch}';
    _userId = 'demo_user_123';
    _userData = {
      'id': 'demo_user_123',
      'username': 'demo',
      'email': 'demo@example.com',
      'firstName': 'Demo',
      'lastName': 'User',
      'dueDate': DateTime.now().add(const Duration(days: 120)).toIso8601String(),
      'doctorName': 'Dr. Schmidt',
      'clinicName': 'Demo Klinik',
    };

    await _saveAuthState();
    notifyListeners();

    return true;
  }

  Future<void> setDemoMode(bool isDemoMode) async {
    _isDemoMode = isDemoMode;
    _isAuthenticated = isDemoMode; // In demo mode, we consider user as "authenticated"

    if (isDemoMode) {
      _token = null;
      _userId = 'demo_user';
      _userData = {
        'id': 'demo_user',
        'username': 'demo_user',
        'firstName': 'Demo',
        'lastName': 'Nutzer',
        'dueDate': DateTime.now().add(const Duration(days: 120)).toIso8601String(),
      };
    }

    await _saveAuthState();
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _isDemoMode = false;
    _token = null;
    _userId = null;
    _userData = null;

    await _saveAuthState();
    notifyListeners();
  }

  // Method to check if token is still valid
  Future<bool> validateToken() async {
    if (_token == null || _isDemoMode) {
      return _isDemoMode; // Demo mode is always "valid"
    }

    try {
      // TODO: Replace with your actual API endpoint for token validation
      const String apiUrl = 'https://your-api-endpoint.com/auth/validate';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // Token is invalid, logout user
        await logout();
        return false;
      }
    } catch (e) {
      debugPrint('Token validation error: $e');
      // In case of network error, assume token is still valid
      // You might want to handle this differently based on your needs
      return true;
    }
  }

  // Method to refresh token
  Future<bool> refreshToken() async {
    if (_isDemoMode) return true;

    try {
      // TODO: Replace with your actual API endpoint for token refresh
      const String apiUrl = 'https://your-api-endpoint.com/auth/refresh';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _token = responseData['token'];

        await _saveAuthState();
        notifyListeners();

        return true;
      } else {
        await logout();
        return false;
      }
    } catch (e) {
      debugPrint('Token refresh error: $e');
      return false;
    }
  }

  // Method to get API headers with authentication
  Map<String, String> get apiHeaders {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (_token != null && !_isDemoMode) {
      headers['Authorization'] = 'Bearer $_token';
    }

    return headers;
  }

  // Method to check if user data is available
  bool get hasUserData => _userData != null;

  // Method to get specific user data
  String? getUserDataField(String field) {
    return _userData?[field]?.toString();
  }
}