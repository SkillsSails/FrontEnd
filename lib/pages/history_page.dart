import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
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
                'Votre Historique',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                  color: Color(0xFF687890),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const HistoryCard(
                  date: 'Aujourd\'hui',
                  time: '12.12h – 13h',
                  duration: '47mins',
                  address: '11 Rue de Molinel, 10eme arr. Paris',
                  store: 'Monoprix'),
              const SizedBox(height: 10),
              const HistoryCard(
                  date: '3 Sept. 2023',
                  time: '12.12h – 13h',
                  duration: '47mins',
                  address: '11 Rue de Molinel, 10eme arr. Paris',
                  store: 'Monoprix'),
              const SizedBox(height: 20),
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

class HistoryCard extends StatelessWidget {
  final String date;
  final String time;
  final String duration;
  final String address;
  final String store;

  const HistoryCard({
    required this.date,
    required this.time,
    required this.duration,
    required this.address,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF799CF0),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              date,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Rubik',
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 50,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF687890),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$time\nDurée: $duration',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Rubik',
                        color: Color(0xFF687890),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      address,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Rubik',
                        color: Color(0xFF687890),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
