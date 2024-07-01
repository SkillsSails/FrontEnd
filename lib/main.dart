import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safypower_app/pages/launch_screen.dart';
import 'app_pages.dart';
import 'pages/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: AppPages.pages,
      home: LaunchScreen(),
    );
  }
}
