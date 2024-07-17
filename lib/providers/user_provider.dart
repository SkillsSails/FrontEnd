import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:skillssails/model/user_model.dart';
import 'package:skillssails/services/user_apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as Dio;

class UserProvider with ChangeNotifier {
  String _userId = '';
  String _username = '';
  String _password = '';
    User? _user;
  User? get user => _user;

  String get userId => _userId;
  String get username => _username;
  String get password => _password;
  String _email = '';
  String _phone = '';
  String _github = '';
  String _linkedin = '';
  String _technicalSkills = '';
  String _professionalSkills = '';
  String _certificationOrganization = '';
  String _certificationName = '';
  String _certificationYear = '';

  String get email => _email;
  String get phone => _phone;
  String get github => _github;
  String get linkedin => _linkedin;
  String get technicalSkills => _technicalSkills;
  String get professionalSkills => _professionalSkills;
  String get certificationOrganization => _certificationOrganization;
  String get certificationName => _certificationName;
  String get certificationYear => _certificationYear;

  UserProvider() {
    loadUserDetailsLocally();
  }

  Future<void> createUser(String username, String password, String filePath) async {
    try {
      final pdfFile = File(filePath);

      if (!pdfFile.existsSync()) {
        throw Exception('File not found: $filePath');
      }

      await UserApiService.createUser(username, password, pdfFile);

      _username = username;
      _password = password;

      await saveUserDetailsLocally();
      notifyListeners();
    } catch (e) {
      print('Error in createUser: $e');
      throw Exception('Failed to register user: ${e.toString()}');
    }
  }


 Future<void> createUserR(String username, String password) async {
    try {
      await UserApiService.createUserR(username, password);

      _username = username;
      _password = password;

      await saveUserDetailsLocally();
      notifyListeners();
    } catch (e) {
      print('Error in createUserR: $e');
      throw Exception('Failed to register recruiter: ${e.toString()}');
    }
  }
Future<User> authenticateUserR(String username, String password) async {
    try {
      final User user = await UserApiService.authenticateUserR(username, password);
      _userId = user.id ?? '';
      _username = username;
      _password = password;
      await saveUserDetailsLocally();
      notifyListeners();
      return user;
    } catch (e) {
      print('Error: $e');
      throw e; // Pass the error back to the UI
    }
  }


  Future<void> saveUserDetailsLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', _userId);
    await prefs.setString('username', _username);
    await prefs.setString('password', _password);
    notifyListeners();
  }

   Future<void> loadUserDetailsLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId') ?? '';
    if (_userId.isNotEmpty) {
      fetchProfile(); // Fetch profile when loading local details
    }
    notifyListeners();
  }

  Future<User> authenticateUser(String username, String password) async {
    try {
      final User user = await UserApiService.authenticateUser(username, password);
      _userId = user.id ?? '';
      _username = username;
      _password = password;
      await saveUserDetailsLocally();
      notifyListeners();
      return user;
    } catch (e) {
      print('Error: $e');
      throw e; // Pass the error back to the UI
    }
  }


  Future<User> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('userId') ?? '';
    return UserApiService.fetchUserProfileById(userId);
  }

  Future<void> sendOtpForForgotPassword(String contactInfo) async {
    try {
      await UserApiService.sendOtpForForgotPassword(contactInfo);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to send OTP: ${e.toString()}');
    }
  }

 Future<void> validateOtpForForgotPassword(String otp) async {
    try {
      await UserApiService.validateOtpForForgotPassword(otp);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to validate OTP: ${e.toString()}');
    }
  }

Future<void> changePassword(String email, String newPassword) async {
  try {
    await UserApiService.changePassword(email, newPassword);
    notifyListeners();
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to change password: ${e.toString()}');
  }
}
Future<void> fetchProfile() async {
    try {
      if (_userId.isEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        _userId = prefs.getString('userId') ?? '';
      }

      if (_userId.isEmpty) {
        throw Exception('User ID is empty');
      }

      _user = await UserApiService.fetchUserProfileById(_userId);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch user profile: ${e.toString()}');
    }
  }



  Future<void> saveUserIdLocally(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    _userId = userId;
    notifyListeners();
  }

  Future<void> fetchUserProfileById() async {
    try {
      if (_userId.isEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        _userId = prefs.getString('userId') ?? '';
      }

      if (_userId.isEmpty) {
        throw Exception('User ID is empty');
      }

      _user = await UserApiService.fetchUserProfileById(_userId);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch user profile: ${e.toString()}');
    }
  }
  Future<void> updateUserProfile(Map<String, dynamic> profileData) async {
  try {
    await UserApiService.updateUserProfile(_userId, profileData);
    // Optionally update local user state if needed
    notifyListeners();
  } catch (e) {
    print('Error: $e');
    throw e; // Pass the error back to the UI
  }
}

}