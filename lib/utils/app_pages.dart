import 'package:get/get.dart';
import 'package:skillssails/pages/launch_screen.dart';
import 'package:skillssails/pages/login_page.dart';
import 'package:skillssails/pages/signup_page.dart';
import 'package:skillssails/pages/home_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/signup', page: () => SignupPage()),
    GetPage(name: '/signin', page: () => LoginPage()),
    GetPage(name: '/home', page: () => HomePage()),

    // Add other routes here
  ];
}
