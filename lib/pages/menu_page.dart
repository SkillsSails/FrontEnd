import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPage extends StatelessWidget {
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
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed('/profile');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF799CF0), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.person, size: 24, color: Colors.white),
              label: const Text(
                'Profil',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  color: Colors.white, 
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed('/history');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF799CF0), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.history, size: 24, color: Colors.white),
              label: const Text(
                'Historique',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  color: Colors.white, 
                ),
              ),
            ),
            const SizedBox(height: 20),
            MouseRegion(
              onEnter: (_) {
                setState(() {
                  hoverFaq = true;
                });
              },
              onExit: (_) {
                setState(() {
                  hoverFaq = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: hoverFaq ? Color(0xFF87CEFA) : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  title: const Center(
                    child: Text(
                      'Foire aux questions',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik',
                        color: Color(0xFF687890),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed('/faq');
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            MouseRegion(
              onEnter: (_) {
                setState(() {
                  hoverContact = true;
                });
              },
              onExit: (_) {
                setState(() {
                  hoverContact = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: hoverContact ? Color(0xFF87CEFA) : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  title: const Center(
                    child: Text(
                      'Avez-vous un problème? Contactez-nous!',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik',
                        color: Color(0xFF687890),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed('/contact');
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            MouseRegion(
              onEnter: (_) {
                setState(() {
                  hoverFeedback = true;
                });
              },
              onExit: (_) {
                setState(() {
                  hoverFeedback = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: hoverFeedback ? Color(0xFF87CEFA) : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  title: const Center(
                    child: Text(
                      'Dites-nous ce que vous pensez de notre appli',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik',
                        color: Color(0xFF687890),
                      ),
                    ),
                  ),
                  onTap: () {
                    // Handle feedback action
                  },
                ),
              ),
            ),
            const Spacer(),
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
    );
  }

  // State variables for hover effects
  bool hoverFaq = false;
  bool hoverContact = false;
  bool hoverFeedback = false;

  // Function to rebuild the widget on hover changes
  void setState(Function fn) {
    fn();
  }
}
