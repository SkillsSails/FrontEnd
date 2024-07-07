import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillssails/pages/profile_page.dart';
import 'appbar.dart';
import 'top_appbar.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  
    Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/login');
  }
    void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  final List<Widget> _children = [
    HomeScreen(),
    ProfilePage(),
    RecommendationPage(),
    RatingPage(),
  ];

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: TopAppBar(
        title: 'Profile',
        onLogout: _showLogoutConfirmationDialog,
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
            left: 250,
            child: Image.asset(
              'assets/images/bottom_circle2.png',
              width: 200,
              height: 200,
            ),
          ),
          IndexedStack(
            index: _currentIndex,
            children: _children,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            _buildJobCard(
              'Mobile App developer',
              'Join a dynamic team working on cutting-edge mobile applications using swift and kotlin. Ideal candidate will have experience with swift/swift ui, kotlin, nodejs and mongodb',
              'San Francisco, CA',
              'Innovative Tech Solutions',
              'assets/images/mobile_app.png',
              4.5,
            ),
            SizedBox(height: 16),
            _buildJobCard(
              'Mern Stack developer',
              'Join a dynamic team working on cutting-edge web applications using the MERN stack. Ideal candidate will have experience with MongoDB, Express.js, React, and Node.js.',
              'New York, NY',
              'Advanced Web Solutions',
              'assets/images/mern_stack.png',
              4.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(
    String title,
    String description,
    String location,
    String company,
    String imagePath,
    double rating,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 80, // Increased width for zoom
                  height: 80, // Increased height for zoom
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover, // Ensures the image covers the container
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.black54),
                SizedBox(width: 8),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.business, color: Colors.black54),
                SizedBox(width: 8),
                Text(
                  company,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.yellow[700],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}



class RecommendationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Recommendation Page'),
    );
  }
}

class RatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Rating Page'),
    );
  }
}
