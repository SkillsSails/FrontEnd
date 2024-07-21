import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetX;
import 'package:provider/provider.dart';
import 'package:skillssails/providers/user_provider.dart';

class CreateJobPage extends StatefulWidget {
  @override
  _CreateJobPageState createState() => _CreateJobPageState();
}

class _CreateJobPageState extends State<CreateJobPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  
  bool _isLoading = false;

  Future<void> _createJob() async {
    final String title = titleController.text;
    final String description = descriptionController.text;
    final double salary = salaryController.text.isNotEmpty ? double.tryParse(salaryController.text) ?? 0 : 0;
    final String location = locationController.text.isNotEmpty ? locationController.text : '';
    final List<String> requirements = requirementsController.text.split(',').map((e) => e.trim()).toList();
    final DateTime datePosted = DateTime.now(); // Current date and time

    if (title.isEmpty || description.isEmpty) {
      return; // Handle validation errors as needed
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final jobProvider = Provider.of<UserProvider>(context, listen: false);

      await jobProvider.createJob(
        title: title,
        description: description,
        salary: salary,
        requirements: requirements,
        location: location,
        datePosted: datePosted,
        userId: jobProvider.userId, // Assuming you have a userId in your jobProvider
      );

      GetX.Get.toNamed('/jobs_list'); // Navigate to the job list page after creation
    } catch (e) {
      print('Failed to create job: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create New Job',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6F61),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                            hintText: 'Job Title',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Job Description',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: salaryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Salary (Optional)',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: locationController,
                          decoration: InputDecoration(
                            hintText: 'Location (Optional)',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: requirementsController,
                          decoration: InputDecoration(
                            hintText: 'Requirements (Comma separated)',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFBCDBDF),
                            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: _isLoading ? null : _createJob,
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6F61)),
                                )
                              : Text(
                                  'Create Job',
                                  style: TextStyle(
                                    color: Color(0xFFFF6F61),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            GetX.Get.back(); // Navigate back if needed
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Back to ',
                              style: TextStyle(color: Color(0xFF6F6E6E)),
                              children: [
                                TextSpan(
                                  text: 'Home',
                                  style: TextStyle(
                                    color: Color(0xFFFF6F61),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
