import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:skillssails/model/user_model.dart';
import 'package:skillssails/services/user_apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String? _userId;

  String? get userId => _userId;

  Future<User> createUser(String username, String password, String? cvFilePath) async {
    try {
      final User newUser = await UserApiService.createUser(username, password, cvFilePath);
      _userId = newUser.id;
      saveUserDetailsLocally();
      return newUser;
    } catch (e) {
      throw Exception('Failed to create user');
    }
  }

  void saveUserDetailsLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', _userId ?? '');
    notifyListeners();
  }

  Future<User> authenticateUser(String username, String password) async {
    try {
      final User user = await UserApiService.authenticateUser(username, password);
      _userId = user.id;
      saveUserDetailsLocally();
      notifyListeners();
      return user;
    } catch (e) {
      throw Exception('Failed to authenticate user');
    }
  }

  Future<User> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('userId') ?? '';
    return UserApiService.fetchUserProfileById(userId);
  }
}
