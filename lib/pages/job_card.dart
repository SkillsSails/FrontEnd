import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:skillssails/model/review_model.dart'; // Update with your actual user model import
import 'package:skillssails/model/user_model.dart'; // Update with your actual user model import
import 'package:skillssails/model/job_model.dart'; // Update with your actual user model import

class JobCard extends StatelessWidget {
  final Review review;
  final User? user;
  final Job? job;

  const JobCard({Key? key, required this.review, this.user, this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (job != null) ...[
              Row(
                children: [
                  Icon(Icons.work, color: Colors.blue),
                  SizedBox(width: 5),
                  Text(job!.title ?? 'No job title', style: TextStyle(fontWeight: FontWeight.bold)), // Display job title or default text
                ],
              ),
              SizedBox(height: 8),
            ],
            if (user != null) ...[
              Row(
                children: [
                  Icon(Icons.person, color: Colors.blue),
                  SizedBox(width: 5),
                  Text(user!.username ?? 'No username'), // Display username or default text
                ],
              ),
              SizedBox(height: 8),
            ],
             if (job != null) ...[
              Row(
                children: [
                  Icon(Icons.work, color: Colors.yellow),
                  SizedBox(width: 5),
                  SizedBox(height: 4),

                  Text(job!.title ?? 'No Job'), // Display username or default text
                  Icon(Icons.place, color: Colors.orange),
                  Text(job!.location ?? 'No location'), // Display username or default text

                ],
              ),
              SizedBox(height: 8),
            ],
            
            Row(
              children: [
                Text("Rates: "),
                SizedBox(width: 5),
                RatingBarIndicator(
                  rating: review.rating?.toDouble() ?? 0.0, // Convert rating to double
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text("comment :"),
            Text(review.comment ?? "No comment"), // Display comment or default text
          ],
        ),
      ),
    );
  }
}
