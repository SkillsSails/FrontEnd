import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillssails/providers/user_provider.dart';
import 'package:skillssails/model/job_model.dart';

class RecommendationPage extends StatefulWidget {
  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchRecommendedJobs();
    userProvider.fetchUserId(); // Ensure userId is fetched
  });
}


@override
Widget build(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);
  final jobProvider = userProvider;
  final userId = userProvider.userId; // Ensure userId is fetched from UserProvider

  return Scaffold(
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
          left: 235,
          child: Image.asset(
            'assets/images/bottom_circle2.png',
            width: 200,
            height: 200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.lightBlue[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/career_path.png',
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Unlock Your Perfect Career Path',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'We guide you in achieving your career goals.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Skill based Recommendations',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                jobProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : jobProvider.errorMessage.isNotEmpty
                        ? Center(child: Text(jobProvider.errorMessage))
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: jobProvider.recommendedJobs.length,
                            itemBuilder: (context, index) {
                              final job = jobProvider.recommendedJobs[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  JobCard(job: job),
                                  SizedBox(height: 16),
                                  ReviewSection(
                                    jobId: job.id ?? '',
                                    userId: userId, // Use the fetched userId
                                  ),
                                ],
                              );
                            },
                          ),
                SizedBox(height: 200), // Add extra space at the bottom
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

}

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16),
                      SizedBox(width: 4),
                      Text(job.location),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(job.description),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.attach_money, size: 16),
                      SizedBox(width: 4),
                      Text('\$${job.salary}'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.list, size: 16),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          job.requirements.join(', '),
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewSection extends StatefulWidget {
  final String jobId;
  final String userId;

  const ReviewSection({
    Key? key,
    required this.jobId,
    required this.userId,
  }) : super(key: key);

  @override
  _ReviewSectionState createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  double _rating = 0;
  TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink[50],
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add a Review',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1.0;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your comment...',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            _isSubmitting
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isSubmitting = true;
                      });
                      try {
                        await Provider.of<UserProvider>(context, listen: false)
                            .submitReview(
                          jobId: widget.jobId,
                          userId: widget.userId,
                          rating: _rating.toInt(),
                          comment: _commentController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Review submitted successfully!')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to submit review.')),
                        );
                      } finally {
                        setState(() {
                          _isSubmitting = false;
                        });
                      }
                    },
                    child: Text('Submit Review'),
                  ),
          ],
        ),
      ),
    );
  }
}
