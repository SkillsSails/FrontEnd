import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPage extends StatelessWidget {
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
              'Centre d\'aide',
              style: TextStyle(
                fontSize: 22,
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
              child: const Row(
                children: [
                  Icon(Icons.phone, size: 30, color: Color(0xFF799CF0)),
                  SizedBox(width: 10),
                  Text(
                    '01.42.71.91.34',
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Rubik',
                      color: Color(0xFF799CF0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: const Row(
                children: [
                  Icon(Icons.email, size: 30, color: Color(0xFF799CF0)),
                  SizedBox(width: 10),
                  Text(
                    'hello@safypower.fr',
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Rubik',
                      color: Color(0xFF799CF0),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
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
