import 'package:get/get.dart';
import 'package:safypower_app/pages/Photo2_Page.dart';
import 'package:safypower_app/pages/Photo3_Page';
import 'package:safypower_app/pages/Qrcode_page.dart';
import 'package:safypower_app/pages/centreaide_page.dart';
import 'package:safypower_app/pages/conditions-generale-Page.dart';
import 'package:safypower_app/pages/launch_screen.dart';
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
    GetPage(name: '/condition', page: () => conditiongeneralePage()),
    GetPage(name: '/qr3', page: () => Photo3Page()),
    GetPage(name: '/qr2', page: () => Photo2Page()),
    GetPage(name: '/aide', page: () => centreaidePage()),
    GetPage(name: '/qr', page: () => QrcodePage()),
    GetPage(name: '/splash', page: () => LaunchScreen()),
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
