import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillssails/providers/user_provider.dart';

class FreelancersListPage extends StatefulWidget {
  @override
  _FreelancersListPageState createState() => _FreelancersListPageState();
}

class _FreelancersListPageState extends State<FreelancersListPage> {
  @override
  void initState() {
    super.initState();
    _loadFreelancers();
  }

  Future<void> _loadFreelancers() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      await userProvider.getFreelancers();
    } catch (e) {
      print('Failed to fetch freelancers: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final freelancers = userProvider.freelancers;
    final errorMessage = userProvider.errorMessage;

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
            right: -50,
            child: Image.asset(
              'assets/images/bottom_circle.png',
              width: 200,
              height: 200,
            ),
          ),
          Center(
            child: userProvider.isLoading
                ? CircularProgressIndicator()
                : errorMessage.isNotEmpty
                    ? Text(errorMessage, style: TextStyle(fontSize: 18, color: Colors.red))
                    : freelancers.isEmpty
                        ? Text('No freelancers available', style: TextStyle(fontSize: 18, color: Colors.grey))
                        : ListView.builder(
                            itemCount: freelancers.length,
                            itemBuilder: (context, index) {
                              final freelancer = freelancers.values.elementAt(index);
                              final certification = freelancer.certification;
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                elevation: 5,
                                child: ListTile(
                                  title: Text(freelancer.username ?? 'No username'),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Technical Skills: ${freelancer.technicalSkills?.join(', ') ?? 'No skills'}'),
                                      Text('Professional Skills: ${freelancer.professionalSkills?.join(', ') ?? 'No skills'}'),
                                      Text('Certification: ${certification['name'] ?? 'No certification'}, ${certification['organization'] ?? ''}, ${certification['year'] ?? ''}'),
                                      Text('LinkedIn: ${freelancer.linkedin ?? 'No LinkedIn profile'}'),
                                    ],
                                  ),
                                  isThreeLine: true,
                                  contentPadding: EdgeInsets.all(15),
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
