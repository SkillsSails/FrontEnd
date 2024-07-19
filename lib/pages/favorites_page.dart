import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10, // Replace with the number of favorite items
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(Icons.favorite, color: Colors.red), // Customize the icon
                title: Text('Favorite Item $index'), // Replace with your item data
                subtitle: Text('Description of Favorite Item $index'), // Replace with your item data
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red), // Customize the delete icon
                  onPressed: () {
                    // Handle delete action
                  },
                ),
                onTap: () {
                  // Handle item tap action
                },
              ),
            );
          },
        ),
      ),
    
    );
  }
}
