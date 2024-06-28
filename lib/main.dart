import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_pages.dart';
import 'pages/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/signup',
      getPages: AppPages.pages,
      home: SignupPage(),
    );
  }
}
