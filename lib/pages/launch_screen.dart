import 'package:flutter/material.dart';
import 'package:safypower_app/main.dart';
import 'package:safypower_app/pages/login_page.dart';
import 'package:safypower_app/pages/signup_page.dart';

class LaunchScreen extends StatefulWidget {
  static const String routeName = '/splash'; 

  const LaunchScreen({super.key});

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
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
            color: Color.fromARGB(255, 188, 219, 223),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo1.png",
                  width: screenWidth * 0.8, 
                  height: screenWidth * 0.8, 
                ),
                const SizedBox(height: 20),
                const Text(
                  "Get things done with Skills Sails",
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, 
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
