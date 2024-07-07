import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skillssails/model/user_model.dart';

class UserApiService {
  static const String baseUrl = "http://10.0.2.2:5000/auth";

  static Future<User> createUser(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      throw Exception('Username or password is empty');
    }

    final response = await http.post(
      Uri.parse("$baseUrl/signup"), // Change to match Flask route
      body: jsonEncode({"username": username, "password": password}),
      headers: {"Content-Type": "application/json"},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return User.fromJson(data); // Ensure this matches your backend response structure
    } else {
      final responseJson = jsonDecode(response.body);
      throw Exception('Failed to register user: ${responseJson['error']}');
    }
  }

  static Future<User> authenticateUser(String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/signin"), // Change to match Flask route
      body: jsonEncode({"username": username, "password": password}),
      headers: {"Content-Type": "application/json"},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data); // Ensure this matches your backend response structure
    } else {
      final responseJson = jsonDecode(response.body);
      throw Exception('Failed to authenticate user: ${responseJson['error']}');
    }
  }

  static Future<User> fetchUserProfileById(String userId) async {
    if (userId.isEmpty) {
      throw Exception('User ID is empty');
    }

    final response = await http.get(Uri.parse("$baseUrl/user/$userId"));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data); // Ensure this matches your backend response structure
    } else {
      final responseJson = jsonDecode(response.body);
      throw Exception('Failed to fetch user profile: ${responseJson['error']}');
    }
  }
}
