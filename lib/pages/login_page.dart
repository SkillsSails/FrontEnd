import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool rememberMe = false;

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
      backgroundColor: Color.fromARGB(255, 188, 219, 223),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Welcome on board',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                  color: Color(0xFF1E1E1E),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/logo2.png',
                height: 150,
              ),
              const SizedBox(height: 20),
        
              const SizedBox(height: 10),
          
              const SizedBox(height: 20),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  color: Color(0xFF1E1E1E),
                ),
              ),
              const SizedBox(height: 10),
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
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  color: Color(0xFF1E1E1E),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  hintStyle: const TextStyle(
                    color: Color(0xFF687890),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Color(0xFF687890),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
           
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle CV upload
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Color(0xFF799CF0)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Upload CV (PDF)',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik',
                    color: Color(0xFF799CF0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/signup');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Color(0xFF799CF0)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik',
                    color: Color(0xFF799CF0),
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
                    onTap: _handleSignIn,
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
      ),
    );
  }
}
