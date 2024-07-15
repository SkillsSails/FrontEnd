import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillssails/providers/user_provider.dart';
class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}
class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

  bool _isLoading = false;

Future<void> _changePassword() async {
    final String email = emailController.text; // Retrieve email from controller
  final String newPassword = newPasswordController.text;

  if (newPassword.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please enter the new password')),
    );
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    await Provider.of<UserProvider>(context, listen: false).changePassword(email, newPassword);
    _showDialog('Change Password Succeeded', 'Password has been changed successfully.', Icons.check_circle, Colors.green);
  } catch (e) {
    _showDialog('Change Password Failed', 'Failed to change password, please try again.', Icons.error, Colors.red);
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


void _showDialog(String title, String message, IconData icon, Color color) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, 
        child: Padding( // Add padding around the content
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Keep the dialog as small as possible
            children: [
              Row(
                children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 10),
                  Text(title),
                ],
              ),
              const SizedBox(height: 20), 
              Flexible( // Allow the text to expand and scroll
                child: SingleChildScrollView(
                  child: Text(message),
                ),
              ),
              const SizedBox(height: 20), 
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
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
                      'Change Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF6F61),
                      ),
                    ),
                    TextFormField(
               controller: emailController, // Use TextEditingController
               decoration: InputDecoration(
                hintText: 'Email',
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
                      controller: newPasswordController,
                      decoration: InputDecoration(
                        hintText: 'New Password',
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
                              'Change Password',
                              style: TextStyle(
                                color: Color(0xFFFF6F61),
                              ),
                            ),
                      onPressed: _isLoading ? null : _changePassword,
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
