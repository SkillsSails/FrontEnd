import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:skillssails/model/user_model.dart';

class UserApiService {
  static const String baseUrl = "http://192.168.1.11:3000";

  static Future<User> createUser(String username, String password, String? cvFilePath) async {
    try {
      final Uri requestUri = Uri.parse('$baseUrl/user/registerclient');
      var request = http.MultipartRequest('POST', requestUri);
      request.fields['username'] = username;
      request.fields['password'] = password;

      if (cvFilePath != null) {
        var cvFile = File(cvFilePath);
        var cvStream = http.ByteStream(cvFile.openRead());
        var length = await cvFile.length();
        var cvFilePart = http.MultipartFile(
          'cv',
          cvStream,
          length,
          filename: cvFile.path.split('/').last,
        );
        request.files.add(cvFilePart);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return User.fromJson(responseData);
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      throw Exception('Failed to create user');
    }
  }

  static Future<User> authenticateUser(String username, String password) async {
    final Uri requestUri = Uri.parse('$baseUrl/user/loginclient');
    final Map<String, String> requestBody = {
      'username': username,
      'password': password,
    };

    final http.Response response = await http.post(
      requestUri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return User.fromJson(responseData['user']);
    } else {
      throw Exception('Failed to authenticate user');
    }
  }

  static Future<User> fetchUserProfileById(String userId) async {
    final Uri requestUri = Uri.parse('$baseUrl/user/profile/$userId');

    final http.Response response = await http.get(
      requestUri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return User.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }
}
