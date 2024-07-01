import 'package:flutter/material.dart';
import 'package:get/get.dart';

class centreaidePage extends StatelessWidget {
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
                'Centre d\'aide',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                  color: Color(0xFF687890),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 33),
             Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        size: 40.0,
                        color: Color.fromRGBO(121, 157, 240, 1),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '01.42.71.91.34',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(121, 157, 240, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                
              ),
               const SizedBox(height: 50.0),
                   Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
          
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mail,
                        size: 40.0,
                        color: Color.fromRGBO(121, 157, 240, 1),
                      ),
                      SizedBox(width: 10.0),
                      Text( 'hello@safypower.fr',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(121, 157, 240, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                
              ),
              const SizedBox(height: 216),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.offAllNamed('/home');
                    },
                    icon: const Icon(Icons.home,
                        size: 30, color: Color(0xFF799CF0)),
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
      ),
    );
  }
}


