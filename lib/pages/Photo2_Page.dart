import 'package:flutter/material.dart';
import 'package:safypower_app/pages/Photo3_Page';
import 'package:safypower_app/pages/centreaide_page.dart';
import 'package:safypower_app/pages/conditions-generale-Page.dart';
import 'package:safypower_app/pages/faq_page.dart';
import 'package:safypower_app/styles/styles.dart';


class Photo2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.57,
              child: Image.asset(
                'assets/images/station.png',
                fit: BoxFit.cover,
              ),
            ),
          
            const SizedBox(height: 20),
         Text(
              'Emplacement',
              style: TextStyle(fontSize: 18, color: Styles.defaultGreyColor, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
              'SafyPower - Monoprix',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 18, color: Styles.defaultGreyColor),
                children: [
                  const TextSpan(
                    text: 'Prix : ',
                  ),
                  TextSpan(
                    text: 'Gratuit',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  
                ],
              ),
            ),
                const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'En poursuivant la réservation, vous vous engagez à accepter nos ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                  color: Color(0xFF687890), ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => conditiongeneralePage()),
                );
              },
              child: Text(
                'Conditions Générales d\'Utilisation',
                style: TextStyle(
                  color: Styles.defaultBlueColor,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Photo3Page()),
                  );
                },
                child: const Text(
                  'Déverrouiller',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(121, 157, 240, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: Styles.defaultBorderRadius,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FAQPage()),
                  );
                },
                child: const Text(
                  'Besoin d\'aide ?',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(121, 157, 240, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: Styles.defaultBorderRadius,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
