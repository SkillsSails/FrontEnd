import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetX;
import 'package:provider/provider.dart';
import 'package:skillssails/pages/login_page.dart';
import 'package:skillssails/providers/user_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart' as Dio;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? cvFilePath;
  bool _obscureText = true;
  bool _isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

Future<void> _pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    setState(() {
      cvFilePath = result.files.single.path;
    });
  }
}


  Future<void> _registerUser() async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    print('Attempting to register user with username: $username and password: $password');

    if (username.isEmpty || password.isEmpty || cvFilePath == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      // Register the user with the selected CV file path
      await userProvider.createUser(username, password, cvFilePath!);
      await userProvider.scrapeGithubInfo();

      if (userProvider.userId.isNotEmpty) {
        
        GetX.Get.toNamed('/home');
      }
    } catch (e) {
      // Handle error silently or log it for debugging
      print('Failed to register user: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: -50,
            child: Image.asset(
              'assets/images/top_circle.png',
              width: 200,
              height: 200,
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Image.asset(
              'assets/images/bottom_circle.png',
              width: 200,
              height: 200,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Onboard!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6F61),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/registerimage.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText: 'User Name',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: _pickFile,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cvFilePath != null ? 'CV selected' : 'Upload CV.pdf',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.upload_file),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFBCDBDF),
                            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: _isLoading ? null : _registerUser,
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6F61)),
                                )
                              : Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Color(0xFFFF6F61),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(color: Color(0xFF6F6E6E)),
                              children: [
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: Color(0xFFFF6F61),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}