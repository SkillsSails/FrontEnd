import 'package:flutter/material.dart';
import 'package:get/get.dart';

class conditiongeneralePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                    'Condition générale',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rubik',
                      color: Color(0xFF687890),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ExpansionTile(
                      title: const Text(
                        'Conditions',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(104, 120, 144, 1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                      collapsedBackgroundColor: Colors.grey[200],
                      backgroundColor: Colors.grey[200],
                      collapsedTextColor: Colors.black87,
                      iconColor: const Color.fromRGBO(104, 120, 144, 1),
                      children: const [
                        Divider(color: Colors.grey, thickness: 1),
                        SizedBox(height: 10.0),
                        Text(
                          'LES CONDITONS ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                 
              
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
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
            ),
          ),
        ],
      ),
    );
  }
}
