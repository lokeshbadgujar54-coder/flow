import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  String? _userName;
  String? _userRole;
  bool _isLoading = false;
  String? _error;

  // Getters
  String? get token => _token;
  String? get userName => _userName;
  String? get userRole => _userRole;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _token != null;

  final ApiService _apiService = ApiService();

  AuthProvider() {
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _userName = prefs.getString('userName');
    _userRole = prefs.getString('userRole');
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.login(username, password);
      
      _token = response['access'];
      _userName = username;
      _userRole = response['user']['role'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('userName', username);
      await prefs.setString('userRole', _userRole!);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String username, String email, String password, String role, String firstName, String lastName) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _apiService.register(username, email, password, role, firstName, lastName);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _token = null;
    _userName = null;
    _userRole = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userName');
    await prefs.remove('userRole');

    notifyListeners();
  }
}
