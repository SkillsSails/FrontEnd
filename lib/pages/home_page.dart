import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
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
              'SAFYPOWER',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik',
                color: Color(0xFF132FBA), 
                shadows: [
                  Shadow(
                    offset: Offset(-1.5, -1.5),
                    color: Colors.blueGrey, 
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF132FBA), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.qr_code_scanner, size: 24, color: Colors.white),
              label: const Text(
                'Flashez le QR code',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  color: Colors.white, 
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/faq');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:Color(0xFF799CF0).withOpacity(0.7), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Comment ça marche?',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  color: Colors.white, 
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF799CF0), width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed('/home');
                    },
                    icon: const Icon(Icons.home, size: 30, color: Color(0xFF799CF0)),
                  ),
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF799CF0), width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed('/menu');
                    },
                    icon: const Icon(Icons.menu, size: 30, color: Color(0xFF799CF0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
