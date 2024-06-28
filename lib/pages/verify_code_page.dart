import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyCodePage extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();

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
              'Vérifiez le code',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik',
                color: Color(0xFF1E1E1E), 
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Veuillez renseigner le code reçu',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Rubik',
                color: Color(0xFF687890), 
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '------',
                hintStyle: const TextStyle(
                  color: Color(0xFF687890), 
                  letterSpacing: 8.0, 
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                letterSpacing: 8.0, 
                fontSize: 24,
                color: Color(0xFF1E1E1E),
              ),
              maxLength: 6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('/login'); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF799CF0), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Vérifier le code',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  color: Colors.white, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
