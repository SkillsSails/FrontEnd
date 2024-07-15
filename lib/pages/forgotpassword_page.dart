import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skillssails/providers/user_provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailPhoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendOTP() async {
    final String emailPhone = emailPhoneController.text;

    if (emailPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email or phone number')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<UserProvider>(context, listen: false).sendOtpForForgotPassword(emailPhone);
      Get.toNamed('/otp'); // Navigate using GetX
    } catch (e) {
      String errorMessage = 'Failed to send OTP';
      try {
        // Attempt to decode JSON error response
        final Map<String, dynamic> errorResponse = json.decode(e.toString());
        if (errorResponse.containsKey('detail')) {
          errorMessage = errorResponse['detail'];
        }
      } catch (_) {
        // If JSON decoding fails, use a generic error message
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF6F61),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailPhoneController,
                      decoration: InputDecoration(
                        hintText: 'Email or Phone Number',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
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
                      child: _isLoading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6F61)),
                            )
                          : const Text(
                              'Send OTP',
                              style: TextStyle(
                                color: Color(0xFFFF6F61), // Setting the text color
                              ),
                            ),
                      onPressed: _isLoading ? null : _sendOTP,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
