import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:skillssails/model/job_model.dart';
import 'package:skillssails/model/linkedin_model.dart';
import 'package:skillssails/model/review_model.dart';
import 'package:skillssails/model/user_model.dart';
import 'package:skillssails/services/user_apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as Dio;

class UserProvider with ChangeNotifier {
   String _userId = '';
  String _username = '';
  String _password = '';
  List<Job> _recommendedJobs = [];
Map<String, User> _freelancers = {};
Map<String, User> get freelancers => _freelancers;


  Map<String, Linkedin> _recommendedJobsMap = {};

  bool _isLoading = false;
  String _errorMessage = '';
  List<Review> _topRatedReviews = [];
  Map<String, User> _users = {};
  Map<String, Job> _jobs = {}; // Changed to Map
  List<Review> _reviews = [];
  User? _user;
  Map<String, dynamic>? _githubInfo; // Added property for GitHub info

  // Getters
  List<Job> get jobs => _jobs.values.toList();
  List<Review> get reviews => _reviews;
  User? get user => _user;
  User? getUserById(String? userId) => _users[userId];
  Job? getJobById(String? jobId) => _jobs[jobId];
  String get userId => _userId;
  String get username => _username;
  String get password => _password;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<Review> get topRatedReviews => _topRatedReviews;
  List<Job> get recommendedJobs => _recommendedJobs;
  Map<String, dynamic>? get githubInfo => _githubInfo; // Getter for GitHub info
  List<Linkedin> get recommendedJobss => _recommendedJobsMap.values.toList();



  String _email = '';
  String _phone = '';
  String _github = '';
  String _linkedin = '';
  String _technicalSkills = '';
  String _professionalSkills = '';
  String _certificationOrganization = '';
  String _certificationName = '';
  String _certificationYear = '';
  String get email => _email;
  String get phone => _phone;
  String get github => _github;
  String get linkedin => _linkedin;
  String get technicalSkills => _technicalSkills;
  String get professionalSkills => _professionalSkills;
  String get certificationOrganization => _certificationOrganization;
  String get certificationName => _certificationName;
  String get certificationYear => _certificationYear;

  UserProvider() {
    loadUserDetailsLocally();
    fetchTopRatedReviews();
  }

  Future<void> createUser(String username, String password, String filePath) async {
    try {
      final pdfFile = File(filePath);

      if (!pdfFile.existsSync()) {
        throw Exception('File not found: $filePath');
      }

      await UserApiService.createUser(username, password, pdfFile);

      _username = username;
      _password = password;

      await saveUserDetailsLocally();
      notifyListeners();
    } catch (e) {
      print('Error in createUser: $e');
      throw Exception('Failed to register user: ${e.toString()}');
    }
  }
Future<void> submitReview({
  required String jobId,
  required String userId, // Ensure this is here
  required int rating,
  required String comment,
}) async {
  try {
    // Fetch userId from the authentication service or user session
    final userId = await fetchUserId();

    if (userId.isEmpty) {
      throw Exception('User ID is not available.');
    }

    // Call addReview with the fetched userId
    await UserApiService.addReview(
      jobId: jobId,
      userId: userId,
      rating: rating,
      comment: comment,
    );

    // Optionally, handle success and fetch updated reviews
    await fetchTopRatedReviews();
  } catch (e) {
    print('Error submitting review: $e');
  }
}



Future<void> fetchTopRatedReviews() async {
    try {
      final reviews = await UserApiService.getTopRatedReviews();
      _topRatedReviews = reviews;

      // Fetch user and job details for each review
      for (var review in _topRatedReviews) {
        if (review.userId != null) {
          try {
            final user = await UserApiService.fetchUserById(review.userId!);
            _users[review.userId!] = user;
          } catch (e) {
            print('Error fetching user for review: $e');
          }
        }
        if (review.jobId != null) {
          try {
            final job = await UserApiService.fetchJobById(review.jobId!);
            _jobs[review.jobId!] = job;
          } catch (e) {
            print('Error fetching job for review: $e');
          }
        }
      }

      notifyListeners();
    } catch (e) {
      print('Error fetching top-rated reviews: $e');
      _errorMessage = 'Failed to fetch top-rated reviews: ${e.toString()}';
      notifyListeners();
    }
  }


Future<void> fetchUserProfileAndJobs() async {
    try {
      if (_userId.isEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        _userId = prefs.getString('userId') ?? '';
      }
      if (_userId.isEmpty) {
        throw Exception('User ID is empty');
      }
      _user = await UserApiService.fetchUserById(_userId);
      notifyListeners();
      
      await fetchJobsByUser();
    } catch (e) {
      throw Exception('Failed to fetch user profile: ${e.toString()}');
    }
  }


  String getUserRole() {
    return _user?.role ?? '';
  }

  Future<void> createUserR(String username, String password) async {
    try {
      await UserApiService.createUserR(username, password);

      _username = username;
      _password = password;

      await saveUserDetailsLocally();
      notifyListeners();
    } catch (e) {
      print('Error in createUserR: $e');
      throw Exception('Failed to register recruiter: ${e.toString()}');
    }
  }

  Future<User> authenticateUserR(String username, String password) async {
    try {
      final User user = await UserApiService.authenticateUserR(username, password);
      _userId = user.id ?? '';
      _username = username;
      _password = password;
      await saveUserDetailsLocally();
      notifyListeners();
      return user;
    } catch (e) {
      print('Error: $e');
      throw e; // Pass the error back to the UI
    }
  }

  Future<void> saveUserDetailsLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', _userId);
    await prefs.setString('username', _username);
    await prefs.setString('password', _password);
    notifyListeners();
  }

  Future<void> loadUserDetailsLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId') ?? '';
    if (_userId.isNotEmpty) {
      fetchProfile(); // Fetch profile when loading local details
    }
    notifyListeners();
  }

  Future<User> authenticateUser(String username, String password) async {
    try {
      final User user = await UserApiService.authenticateUser(username, password);
      _userId = user.id ?? '';
      _username = username;
      _password = password;
      await saveUserDetailsLocally();
      notifyListeners();
      return user;
    } catch (e) {
      print('Error: $e');
      throw e; // Pass the error back to the UI
    }
  }

  Future<User> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('userId') ?? '';
    return UserApiService.fetchUserProfileById(userId);
  }

  Future<void> sendOtpForForgotPassword(String contactInfo) async {
    try {
      await UserApiService.sendOtpForForgotPassword(contactInfo);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to send OTP: ${e.toString()}');
    }
  }

  Future<void> validateOtpForForgotPassword(String otp) async {
    try {
      await UserApiService.validateOtpForForgotPassword(otp);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to validate OTP: ${e.toString()}');
    }
  }

  Future<void> changePassword(String email, String newPassword) async {
    try {
      await UserApiService.changePassword(email, newPassword);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to change password: ${e.toString()}');
    }
  }

  Future<void> fetchProfile() async {
    try {
      if (_userId.isEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        _userId = prefs.getString('userId') ?? '';
      }

      if (_userId.isEmpty) {
        throw Exception('User ID is empty');
      }

      _user = await UserApiService.fetchUserProfileById(_userId);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch user profile: ${e.toString()}');
    }
  }

  Future<void> saveUserIdLocally(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    _userId = userId;
    notifyListeners();
  }

  Future<void> fetchUserProfileById() async {
    try {
      if (_userId.isEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        _userId = prefs.getString('userId') ?? '';
      }

      if (_userId.isEmpty) {
        throw Exception('User ID is empty');
      }

      _user = await UserApiService.fetchUserProfileById(_userId);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch user profile: ${e.toString()}');
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> profileData) async {
    try {
      await UserApiService.updateUserProfile(_userId, profileData);
      // Optionally update local user state if needed
      notifyListeners();
    } catch (e) {
      print('Error: $e');
      throw e; // Pass the error back to the UI
    }
  }

Future<void> createJob({
    required String title,
    required String description,
    required String location,
    required String userId,
    required double salary,
    required DateTime datePosted,
    required List<String> requirements,
  }) async {
    try {
      // Convert DateTime to String
      final String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(datePosted);

      await UserApiService.createJob(
        title: title,
        description: description,
        location: location,
        userId: userId,
        salary: salary,
        datePosted: formattedDate,
        requirements: requirements,
      );

     Future<void> fetchJobs() async {
    try {
      List<Job> jobsList = await UserApiService.getJobs();
      _jobs = { for (var job in jobsList) job.id : job }; // Populate the map
      notifyListeners();
    } catch (e) {
      print('Error fetching jobs: $e');
      // Handle error as needed
    }
  }



      // Fetch jobs again to ensure the list is up-to-date
      await fetchJobs();
    } catch (e) {
      print('Error in createJob: $e');
      throw Exception('Failed to create job: ${e.toString()}');
    }
  } 
   Future<void> fetchJobsByUser() async {
    try {
      await fetchUserIdFromPreferences();
      if (_userId.isEmpty) {
        throw Exception('User ID is empty');
      }

      List<Job> jobList = await UserApiService.fetchJobsByUser(_userId);

      // Convert the list to a map
      _jobs = { for (var job in jobList) job.id: job };

      notifyListeners();
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch jobs: ${e.toString()}');
    }
  }

  Future<void> fetchUserIdFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId') ?? '';
  }

Future<String> fetchUserId() async {
  // Replace with your actual implementation to fetch userId from preferences
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId') ?? ''; // Return empty string if userId is not found
}

  Future<void> fetchRecommendedJobs() async {
    try {
      _recommendedJobs = await UserApiService.recommendJobsBasedOnSkills(_userId);
      notifyListeners();
    } catch (e) {
      print('Error in fetchRecommendedJobs: $e');
      throw Exception('Failed to fetch recommended jobs: ${e.toString()}');
    }
  }
Future<void> GetGithubInfo(String userId) async {
  try {
    if (userId.isEmpty) {
      throw Exception('User ID is not available.');
    }
    
    // Fetch GitHub info from the API
    final githubInfo = await UserApiService.getInfo(userId);
    
    // Set the fetched GitHub info
    _githubInfo = githubInfo;
    
    notifyListeners();
  } catch (e) {
    print('Error fetching GitHub info: $e');
    throw Exception('Failed to fetch GitHub info: ${e.toString()}');
  }
}



  Future<void> scrapeGithubInfo() async {
    try {
      final userId = await fetchUserId();
      if (userId.isEmpty) {
        throw Exception('User ID is not available.');
      }
      await UserApiService.scrapeGithub(userId);
      notifyListeners();
    } catch (e) {
      print('Error scraping GitHub info: $e');
      throw Exception('Failed to scrape GitHub info: ${e.toString()}');
    }
  }


Future<void> scrapeAndRecommend() async {
  try {
    const String url = 'https://www.linkedin.com/jobs/search/';
    final userId = await fetchUserId();
    final response = await UserApiService.scrapeAndRecommend(url, userId);
    
    // Assuming response is a List of Linkedin
    _recommendedJobsMap = { for (var job in response) job.id : job }; // Use _recommendedJobsMap
    notifyListeners();
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to fetch recommended jobs: ${e.toString()}');
  }
}

Future<void> getFreelancers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final freelancersList = await UserApiService.getFreelancers();
      _freelancers = {
        for (var u in freelancersList)
          if (u.id != null) u.id!: u
      };
      _errorMessage = '';
    } catch (e) {
      print('Error fetching freelancers: $e');
      _errorMessage = 'Failed to fetch freelancers: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}