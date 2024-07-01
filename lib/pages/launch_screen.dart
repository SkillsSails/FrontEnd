import 'package:flutter/material.dart';
import 'package:safypower_app/main.dart';
import 'package:safypower_app/pages/signup_page.dart';

class LaunchScreen  extends StatefulWidget {
  static const String routeName = '/splash'; 

  const LaunchScreen ({super.key});

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen > {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignupPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Color(0xFFEEEEEE),
          ),
          Center(
            child: Image.asset(
              "assets/images/sp.png",
              width: screenWidth,
              height: MediaQuery.of(context).size.height, 
            ),
          ),
        ],
      ),
    );
  }
}