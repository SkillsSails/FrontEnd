import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skillssails/pages/signup_page.dart';
import 'package:skillssails/providers/user_provider.dart';
import 'app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),


        ),

        // Add other providers here
      ],
      child: GetMaterialApp(
        initialRoute: '/splash',
        getPages: AppPages.pages,
      ),
    );
  }
}
