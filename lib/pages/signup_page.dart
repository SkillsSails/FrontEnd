import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _sendVerificationCode() async {
    Get.toNamed('/verify');
  }

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
 
        print('Google User: ${googleUser.displayName}, ${googleUser.email}');
        Get.toNamed('/home'); 
      } else {
        print('Google sign-in cancelled.');
      }
    } catch (error) {
      print('Google sign-in error: $error');
    }
  }

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
            Image.asset(
              'assets/images/logo.png',
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Créer votre compte',
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
              'Veuillez renseigner votre numéro de téléphone',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Rubik',
                color: Color(0xFF687890),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                hintText: 'Numéro de téléphone',
                hintStyle: const TextStyle(
                  color: Color(0xFFC4C4C4),
                  fontSize: 16,
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.person,
                  color: Color(0xFFC4C4C4),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendVerificationCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF799CF0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Envoyer le code de verification',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sinon, créer un compte avec',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Rubik',
                color: Color(0xFF687890),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _handleSignIn, // Handle Google sign-up
                  child: Image.asset(
                    'assets/images/google_icon.png',
                    height: 40,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    // Handle Apple sign-up
                  },
                  child: Image.asset(
                    'assets/images/apple_icon.png',
                    height: 40,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    // Handle email sign-up
                  },
                  child: Image.asset(
                    'assets/images/email_icon.png',
                    height: 40,
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
