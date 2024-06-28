import 'package:get/get.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/map_page.dart';
import 'pages/profile_page.dart';
import 'pages/signup_page.dart';
import 'pages/verify_code_page.dart';
import 'pages/menu_page.dart';
import 'pages/history_page.dart';
import 'pages/faq_page.dart';
import 'pages/contact_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/map', page: () => MapPage()),
    GetPage(name: '/profile', page: () => ProfilePage()),
    GetPage(name: '/signup', page: () => SignupPage()),
    GetPage(name: '/verify', page: () => VerifyCodePage()),
    GetPage(name: '/menu', page: () => MenuPage()),
    GetPage(name: '/history', page: () => HistoryPage()),
    GetPage(name: '/faq', page: () => FAQPage()),
    GetPage(name: '/contact', page: () => ContactPage()),
  ];
}
