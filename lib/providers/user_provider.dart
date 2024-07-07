import 'package:flutter/cupertino.dart';
import 'package:skillssails/model/user_model.dart';
import 'package:skillssails/services/user_apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String _userId = '';
  String _username = '';
  String _password = '';

  String get userId => _userId;
  String get username => _username;
  String get password => _password;

  UserProvider() {
    loadUserDetailsLocally();
  }

  Future<void> createUser(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      throw Exception('Username or password is empty');
    }

    try {
      final user = await UserApiService.createUser(username, password);
      _userId = user.id ?? ''; // Handle potential null value for user.id
      _username = username;
      _password = password;
      await saveUserDetailsLocally();
      notifyListeners();
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to register user: ${e.toString()}');
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
    _username = prefs.getString('username') ?? '';
    _password = prefs.getString('password') ?? '';
    notifyListeners();
  }

  Future<User> authenticateUser(String username, String password) async {
    try {
      final User user = await UserApiService.authenticateUser(username, password);
      _userId = user.id ?? ''; // Handle potential null value for user.id
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
}
