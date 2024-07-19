import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillssails/providers/user_provider.dart';

class JobsListPage extends StatefulWidget {
  @override
  _JobsListPageState createState() => _JobsListPageState();
}

class _JobsListPageState extends State<JobsListPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    try {
      final jobProvider = Provider.of<UserProvider>(context, listen: false);
      await jobProvider.fetchJobsByUser();
    } catch (e) {
      print('Failed to fetch jobs: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<UserProvider>(context);
    final jobs = jobProvider.jobs;

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
            child: _isLoading
                ? CircularProgressIndicator()
                : jobs.isEmpty
                    ? Text('No jobs available', style: TextStyle(fontSize: 18, color: Colors.grey))
                    : ListView.builder(
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          final job = jobs[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            elevation: 5,
                            child: ListTile(
                              title: Text(job.title),
                              subtitle: Text('${job.description}\n${job.location ?? 'No location'}'),
                              isThreeLine: true,
                              trailing: Text('\$${job.salary.toStringAsFixed(2)}'),
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
