import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillssails/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Example: Form fields controllers
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();

  void _showProfileUpdateDialog(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    // Pre-fill the form fields with current user data
    _phoneController.text = user?.phoneNumber ?? '';
    _githubController.text = user?.github ?? '';
    _linkedinController.text = user?.linkedin ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
                TextFormField(
                  controller: _githubController,
                  decoration: InputDecoration(labelText: 'GitHub'),
                ),
                TextFormField(
                  controller: _linkedinController,
                  decoration: InputDecoration(labelText: 'LinkedIn'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6F61),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Construct profile data from form
                  final profileData = {
                    'phone_number': _phoneController.text.trim(),
                    'github': _githubController.text.trim(),
                    'linkedin': _linkedinController.text.trim(),
                  };

                  userProvider.updateUserProfile(profileData).then((_) {
                    userProvider.fetchProfile().then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profile updated successfully')),
                      );
                      Navigator.of(context).pop(); // Close dialog on success
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to fetch profile: $error')),
                      );
                    });
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update profile: $error')),
                    );
                  });
                }
              },
              child: Text(
                'Update',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6F61),
                ),
              ),
            ),
          ],
        
        );
      },
    );
  }

Future<void> _showRecommendedJobsDialog(BuildContext context) async {
  try {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await userProvider.scrapeAndRecommend();

    final recommendedJobss = userProvider.recommendedJobss;

    if (recommendedJobss.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No recommended jobs found.')),
      );
      return;
    }

    showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text(
        'Recommended Jobs',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFFFF6F61),
        ),
      ),
      content: SingleChildScrollView(
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(5),
          },
          children: [
            _buildTableRow('Company', 'Job Title'),
            ...recommendedJobss.map((linkedin) {
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      linkedin.company,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        launch(linkedin.link);
                      },
                      child: Text(
                        linkedin.jobTitle, // Changed here
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6F61),
            ),
          ),
        ),
      ],
    );
  },
);
  
  } catch (e) {
    print('Error fetching recommended jobs: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to fetch recommended jobs: $e')),
    );
  }
}




Future<void> _showGithubInfoDialog(BuildContext context) async {
  try {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = await userProvider.fetchUserId();

    if (userId.isEmpty) {
      throw Exception('User ID is not available.');
    }

    await userProvider.GetGithubInfo(userId);

    final githubInfo = userProvider.githubInfo;

    // Safely handle the type conversion
    final repositories = (githubInfo?['repositories'] as List<dynamic>?)?.map((repo) => repo.toString()).toList() ?? [];
    final starredRepos = (githubInfo?['starred_repos'] as List<dynamic>?)?.map((repo) => repo.toString()).toList() ?? [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('GitHub Information',
           style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF6F61),
          ),
          ),
          
          content: SingleChildScrollView(
            child: Table(
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                _buildTableRow('Username', githubInfo?['username'] ?? 'N/A'),
                _buildTableRow('User URL', githubInfo?['user_url'] ?? 'N/A'),
                _buildTableRow('Followers', '${githubInfo?['followers'] ?? 0}'),
                _buildTableRow('Following', '${githubInfo?['following'] ?? 0}'),
                _buildTableRow('Repositories', repositories.isNotEmpty ? repositories.join(', ') : 'None'),
                _buildTableRow('Starred Repositories', starredRepos.isNotEmpty ? starredRepos.join(', ') : 'None'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6F61),
                ),
              ),
            ),
          ],
        );
      },
    );
  } catch (e) {
    print('Error fetching GitHub info: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to fetch GitHub info: $e')),
    );
  }
}

TableRow _buildTableRow(String title, String value) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          value,
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    ],
  );
}



  @override
  void initState() {
    super.initState();
    // Fetch user profile when the profile page is loaded
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchProfile();
       Provider.of<UserProvider>(context, listen: false).scrapeGithubInfo();


    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      body: Stack(
        children: [
          // Background decoration with images
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
            right: -50,
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
                children: [
                  SizedBox(height: 90),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile_picture.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Welcome ${user?.username ?? ''}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 32),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF6F61),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Name: ${user?.username ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Phone: ${user?.phoneNumber ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Github: ${user?.github ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'LinkedIn: ${user?.linkedin ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Professional Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF6F61),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Technical Skills: ${user?.technicalSkills?.join(', ') ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Professional Skills: ${user?.professionalSkills?.join(', ') ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Certification',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF6F61),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Organization: ${user?.certification?['organization'] ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Name: ${user?.certification?['name'] ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Year: ${user?.certification?['year'] ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
SizedBox(height: 20),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    ElevatedButton(
      onPressed: () {
        _showProfileUpdateDialog(context);
      },
      child: Icon(
        Icons.edit,
        color: Color(0xFFFF6F61),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: CircleBorder(), // To make the button round
        backgroundColor: Colors.white, // Background color of the button
        foregroundColor: Color(0xFFFF6F61), // Icon color
      ),
    ),
ElevatedButton(
  onPressed: () {
    _showGithubInfoDialog(context);
  },
  child: Image.asset(
    'assets/images/github.png', // Use a GitHub icon image
    color: Color(0xFFFF6F61), // Apply color to the image if needed
    width: 24, // Adjust width as needed
    height: 24, // Adjust height as needed
  ),
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    shape: CircleBorder(), // To make the button round
    backgroundColor: Colors.white, // Background color of the button
  ),
),
    ElevatedButton(
      onPressed: () {
        _showRecommendedJobsDialog(context);
      },
      child: Icon(
        Icons.linked_camera, // Use a LinkedIn icon if available, otherwise use a placeholder
        color: Color(0xFFFF6F61),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: CircleBorder(), // To make the button round
        backgroundColor: Colors.white, // Background color of the button
        foregroundColor: Color(0xFFFF6F61), // Icon color
      ),
    ),
  ],
),
                ]
              )
            )
          )
        ]
      )
);
}
}
