import 'package:get/get.dart';
import 'package:skillssails/pages/centreaide_page.dart';
import 'package:skillssails/pages/change_password_page.dart';
import 'package:skillssails/pages/conditions-generale-Page.dart';
import 'package:skillssails/pages/forgotpassword_page.dart';
import 'package:skillssails/pages/launch_screen.dart';
import 'package:skillssails/pages/login_page.dart';
import 'package:skillssails/pages/login_pageR.dart';
import 'package:skillssails/pages/otp_verification_page.dart';
import 'package:skillssails/pages/signup_page.dart';
import 'package:skillssails/pages/signup_pageR.dart';
import 'package:skillssails/pages/verify_code_page.dart';
import 'package:skillssails/pages/faq_page.dart';
import 'package:skillssails/pages/contact_page.dart';
import 'package:skillssails/pages/home_page.dart'; // Make sure to import HomePage

class AppPages {
  static final pages = [
    GetPage(name: '/condition', page: () => conditiongeneralePage()),
    GetPage(name: '/aide', page: () => centreaidePage()),
    GetPage(name: '/splash', page: () => LaunchScreen()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/signup', page: () => SignupPage()),
    GetPage(name: '/verify', page: () => VerifyCodePage()),
    GetPage(name: '/otp', page: () => OTPVerificationPage()),
    GetPage(name: '/changePassword', page: () => ChangePasswordPage()),
    GetPage(name: '/forgotpassword', page: () => ForgotPasswordPage()), // Add this line
    GetPage(name: '/faq', page: () => FAQPage()),
    GetPage(name: '/contact', page: () => ContactPage()),
    GetPage(name: '/home', page: () => HomePage()), // Add this line
    GetPage(name: '/signupR', page: () => RecruiterSignupPage()), // Add this line
    GetPage(name: '/loginR', page: () => RecruiterLoginPage()), // Add this line



  ];
}
