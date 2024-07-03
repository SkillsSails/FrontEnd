import 'package:flutter/material.dart';
import 'package:skillssails/pages/login_page.dart';

double figmaY = -31;  // Replace with the actual Y coordinate of the eclipse center in Figma
double figmaX = 200;  // Replace with the actual X coordinate of the eclipse center in Figma

// Figma Coordinates
double figmaY2 = -131;  // Replace with the actual Y coordinate of the eclipse center in Figma
double figmaX2 = 0;  //test
double figmaY3 = 612;  // Replace with the actual Y coordinate of the eclipse center in Figma
double figmaX3 = 267;  //test
double figmaY4 = 512;  // Replace with the actual Y coordinate of the eclipse center in Figma
double figmaX4 = 339;  //test

// Eclipse Dimensions
double eclipseHeight = 200;  // Replace with the actual height of your eclipse asset
double eclipseWidth = 200;  // Replace with the actual width of your eclipse asset

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
        children: [
          // Background shapes
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/top_circle.png',
              width: eclipseWidth,
              height: eclipseHeight,
            ),
          ),
          Positioned(
            bottom: screenWidth * 0.5,
            right: screenWidth * 0.3,
            child: Image.asset(
              'assets/images/bottom_circle.png',
              width: eclipseWidth,
              height: eclipseHeight,
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 188, 219, 223),
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
