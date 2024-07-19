import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillssails/pages/create_job_page.dart';
import 'package:skillssails/pages/favorites_page.dart';
import 'package:skillssails/pages/job_list_page.dart';
import 'package:skillssails/pages/profile_page.dart';
import 'package:skillssails/pages/recommendation_page.dart';
import 'package:skillssails/providers/user_provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final role = userProvider.getUserRole();

    List<BottomNavigationBarItem> items;
    List<Widget> pages;

    if (role == 'freelancer') {
      items = [
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/images/recommendation.png')),
          label: 'RecommendationAndRating',
        ),
     
      ];

      pages = [
        FavoritesPage(),
        ProfilePage(),
        RecommendationPage(),
        // Add the new page if needed
      ];
    } else {
      items = [
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Create Job',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Job List',
        ),
      ];

      pages = [
        CreateJobPage(),
        JobsListPage(),
      ];
    }

    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF9BD7DF), // Background color from the second code snippet
      selectedItemColor: Colors.white,     // Selected item color from the second code snippet
      unselectedItemColor: Colors.black,   // Unselected item color from the second code snippet
      items: items,
    );
  }
}
