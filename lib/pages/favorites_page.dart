import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillssails/providers/user_provider.dart'; // Update with your actual user model import
import 'job_card.dart'; // Update with your actual job card import

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.fetchTopRatedReviews(); // Fetch reviews after widget is built
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (userProvider.errorMessage.isNotEmpty) {
              return Center(child: Text(userProvider.errorMessage));
            }
            return ListView.builder(
              itemCount: userProvider.topRatedReviews.length,
              itemBuilder: (context, index) {
                final review = userProvider.topRatedReviews[index];
                final user = userProvider.getUserById(review.userId);
                final job = userProvider.getJobById(review.jobId);

                // Log review data for debugging
                print('Displaying review: $review');

                return JobCard(review: review, user: user, job: job);
              },
            );
          },
        ),
      ),
    );
  }
}
