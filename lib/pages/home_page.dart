import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillssails/pages/freelancers_list.dart';
import 'package:skillssails/pages/job_list_page.dart';
import 'package:skillssails/pages/profile_page.dart';
import 'package:skillssails/pages/create_job_page.dart';
import 'package:skillssails/pages/favorites_page.dart'; // Added import for FavoritesPage
import 'package:skillssails/pages/recommendation_page.dart';
import 'package:skillssails/pages/rating_page.dart';
import 'package:skillssails/providers/user_provider.dart';
import 'top_appbar.dart';
import 'custom_bottom_navigation_bar.dart'; // Ensure this import is correct

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateBasedOnUserRole();
    });
  }

  Future<void> _navigateBasedOnUserRole() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.fetchUserProfileById();
    
    final role = userProvider.getUserRole();

    if (role == 'freelancer') {
      setState(() {
        _currentIndex = 0; // Set initial index for freelancer role
      });
    } else if (role == 'recruiter') {
      setState(() {
        _currentIndex = 0; // Set initial index for recruiter role (adjust as needed)
      });
    }
  }

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

  final List<Widget> _freelancerPages = [
    FavoritesPage(), // Updated to match CustomBottomNavigationBar items
    ProfilePage(),
    RecommendationPage(),
  ];

  final List<Widget> _recruiterPages = [
    CreateJobPage(),
    JobsListPage(),
    FreelancersListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final role = userProvider.getUserRole();

    return Scaffold(
      appBar: TopAppBar(
        title: 'Home',
        onLogout: _showLogoutConfirmationDialog,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: role == 'freelancer' ? _freelancerPages : _recruiterPages,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
