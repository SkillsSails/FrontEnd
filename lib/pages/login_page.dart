import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  bool rememberMe = false;

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
              'Connectez-vous',
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
                color: Color(0xFFC4C4C4), 
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
                  color: Color(0xFF687890), 
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.person, 
                  color: Color(0xFF687890),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('/home'); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF799CF0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Se Connecter',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  color: Colors.white, 
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value!;
                    });
                  },
                ),
                const Text(
                  'Se souvenir de moi',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik',
                    color: Color(0xFF1E1E1E), 
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Ou continuer avec',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Rubik',
                color: Color(0xFF1E1E1E), 
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle Google sign-in
                  },
                  child: Image.asset(
                    'assets/images/google_icon.png', 
                    height: 40, 
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    // Handle Apple sign-in
                  },
                  child: Image.asset(
                    'assets/images/apple_icon.png', 
                    height: 40, 
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    // Handle email sign-in
                  },
                  child: Image.asset(
                    'assets/images/email_icon.png', 
                    height: 40, 
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Vous n’avez pas de compte? ",
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik',
                    color: Color(0xFF1E1E1E), 
                  ),
                  children: [
                    TextSpan(
                      text: 'Inscrivez-vous',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik',
                        color: Color(0xFF799CF0), 
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed('/signup'); 
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
