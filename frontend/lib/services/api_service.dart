import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:8000/api';
  
  // Login
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  // Register
  Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
    String role,
    String firstName,
    String lastName,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'role': role,
        'first_name': firstName,
        'last_name': lastName,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  // Get Courses
  Future<List<dynamic>> getCourses(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/courses/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch courses');
    }
  }

  // Get Lessons
  Future<List<dynamic>> getLessons(String token, int courseId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/lessons/?course_id=$courseId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch lessons');
    }
  }
}
