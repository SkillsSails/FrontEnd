import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  String title = 'Mr.';
  TextEditingController firstNameController = TextEditingController(text: 'Prénom');
  TextEditingController lastNameController = TextEditingController(text: 'Nom de famille');
  TextEditingController emailController = TextEditingController(text: 'E-mail');
  TextEditingController countryCodeController = TextEditingController(text: 'France (+33)');
  TextEditingController phoneController = TextEditingController(text: '62499499');

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void saveProfile() {
    
    toggleEditing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                'Votre profil',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                  color: Color(0xFF687890), 
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(20), 
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8), 
                      child: Center(
                        child: DropdownButton<String>(
                          value: title,
                          items: <String>['Mr.', 'Mrs.', 'Ms.'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: isEditing
                              ? (String? newValue) {
                                  setState(() {
                                    title = newValue!;
                                  });
                                }
                              : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(20), 
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8), 
                      child: Center(
                        child: TextField(
                          controller: firstNameController,
                          enabled: isEditing,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(8),
                            hintText: isEditing ? '' : 'Prénom',
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            color: Color(0xFF687890),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(20), 
                ),
                padding: const EdgeInsets.symmetric(vertical: 8), 
                child: Center(
                  child: TextField(
                    controller: lastNameController,
                    enabled: isEditing,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(8),
                      hintText: isEditing ? '' : 'Nom de famille',
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Rubik',
                      color: Color(0xFF687890),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(20), 
                ),
                padding: const EdgeInsets.symmetric(vertical: 8), 
                child: Center(
                  child: TextField(
                    controller: emailController,
                    enabled: isEditing,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(8),
                      hintText: isEditing ? '' : 'E-mail',
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Rubik',
                      color: Color(0xFF687890),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(20), 
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8), 
                      child: Center(
                        child: TextField(
                          controller: countryCodeController,
                          enabled: false,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            color: Color(0xFF687890),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(20), // Smaller corner radius
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8), // Smaller padding
                      child: Center(
                        child: TextField(
                          controller: phoneController,
                          enabled: isEditing,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(8),
                            hintText: isEditing ? '' : '62499499',
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            color: Color(0xFF687890),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(9),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (isEditing) {
                    saveProfile();
                  } else {
                    toggleEditing();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF799CF0), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.edit, size: 24, color: Colors.white),
                label: Text(
                  isEditing ? 'Sauvegarder' : 'Modifier',
                  style: const TextStyle(
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
      ),
    );
  }
}
