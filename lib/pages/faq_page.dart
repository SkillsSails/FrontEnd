import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Color(0xFF1E1E1E)),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'FAQ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik',
                color: Color(0xFF687890),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comment ça marche?',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF687890),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Rubik',
                      color: Color(0xFF687890),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const Center(
                child: Text(
                  'Question 2',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik',
                    color: Color(0xFF687890),
                  ),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF799CF0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.email, size: 24, color: Colors.white),
              label: const Text(
                'Envoyez-nous un question',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                  icon: const Icon(Icons.home, size: 30, color: Color(0xFF799CF0)),
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF799CF0), width: 4),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed('/map');
                    },
                    icon: const Icon(Icons.map, size: 30, color: Color(0xFF799CF0)),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.menu, size: 30, color: Color(0xFF799CF0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
