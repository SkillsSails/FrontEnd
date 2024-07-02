import 'package:get/get.dart';


import 'package:safypower_app/pages/centreaide_page.dart';
import 'package:safypower_app/pages/conditions-generale-Page.dart';
import 'package:safypower_app/pages/launch_screen.dart';

import 'pages/login_page.dart';

import 'pages/signup_page.dart';
import 'pages/verify_code_page.dart';

import 'pages/faq_page.dart';
import 'pages/contact_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: '/condition', page: () => conditiongeneralePage()),
    
    GetPage(name: '/aide', page: () => centreaidePage()),
  
    GetPage(name: '/splash', page: () => LaunchScreen()),

    GetPage(name: '/login', page: () => LoginPage()),
   

    GetPage(name: '/signup', page: () => SignupPage()),
    GetPage(name: '/verify', page: () => VerifyCodePage()),


    GetPage(name: '/faq', page: () => FAQPage()),
    GetPage(name: '/contact', page: () => ContactPage()),
  ];
}
