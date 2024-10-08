import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillssails/model/github_info_model.dart';
import 'package:skillssails/model/job_model.dart';
import 'package:skillssails/model/linkedin_model.dart';
import 'package:skillssails/model/user_model.dart'; // Adjust this import as per your project structure
import 'package:skillssails/model/review_model.dart'; // Adjust this import as per your project structure

class UserApiService {
  static const String baseUrl = "http://10.0.2.2:5000/auth";
  static const String contactInfoKey = 'contact_info'; // SharedPreferences key
  static const String idKey = 'id'; // SharedPreferences key
  static const String otpKey = 'otp'; // SharedPreferences key


static Future<void> saveContactInfo(String contactInfo) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(contactInfoKey, contactInfo);
}

    static Future<void> saveIdKey(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(idKey, id);
  }
  
 
  
static Future<String?> getContactInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(contactInfoKey);
}

  static Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(idKey);
  }

  // Create user
  static Future<void> createUser(String username, String password, File pdfFile) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = baseUrl;
      dio.options.connectTimeout = Duration(seconds: 5);
      dio.options.receiveTimeout = Duration(seconds: 3);

      FormData formData = FormData.fromMap({
        'username': username,
        'password': password,
        'pdf_file': await MultipartFile.fromFile(pdfFile.path, filename: 'resume.pdf'),
      });

      final response = await dio.post('/signup', data: formData);

      if (response.statusCode == 201) {
        final data = response.data;
        print('User created successfully: $data');
        // Handle successful creation as needed
      } else {
        throw Exception('Failed to register user');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to register user: ${e.toString()}');
    }
  }

 static Future<void> createUserR(String username, String password) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = baseUrl;
      dio.options.connectTimeout = Duration(seconds: 5);
      dio.options.receiveTimeout = Duration(seconds: 3);

      FormData formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      final response = await dio.post('/signupR', data: formData);

      if (response.statusCode == 201) {
        final data = response.data;
        print('User created successfully: $data');
        // Handle successful creation as needed
      } else {
        throw Exception('Failed to register user');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to register user: ${e.toString()}');
    }
  }
static Future<User> authenticateUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/signin"),
        body: jsonEncode({"username": username, "password": password}),
        headers: {"Content-Type": "application/json"},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Handle nullable fields in the response
        final id = data['_id'] as String?;
        final username = data['username'] as String;
        final password = data['password'] as String? ?? '';
        final email = data['email'] as String? ?? '';
        final phoneNumber = data['phone_number'] as String? ?? '';
        final github = data['github'] as String? ?? '';
        final linkedin = data['linkedin'] as String? ?? '';
        final technicalSkills = List<String>.from(data['technical_skills'] ?? []);
        final professionalSkills = List<String>.from(data['professional_skills'] ?? []);
        final certification = data['certification'] as Map<String, dynamic>? ?? {};
        final role = data['role'] as String?;
        final jobs = List<String>.from(data['jobs'] ?? []);

        final user = User(
          id: id,
          username: username,
          password: password,
          email: email,
          phoneNumber: phoneNumber,
          github: github,
          linkedin: linkedin,
          technicalSkills: technicalSkills,
          professionalSkills: professionalSkills,
          certification: certification,
          role: role,
          jobs: jobs,
        );

        // Example: Save contact info if email is not null (non-null assertion used)
        if (user.email.isNotEmpty) {
          await saveContactInfo(user.email);

        }

        return user; // Return User object if needed
      } else {
        final responseJson = jsonDecode(response.body);
        throw Exception('Failed to authenticate user: ${responseJson['error']}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to authenticate user: ${e.toString()}');
    }
  }


 static Future<User> authenticateUserR(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/signinR"),
        body: jsonEncode({"username": username, "password": password}),
        headers: {"Content-Type": "application/json"},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final user = User(
          id: data['_id'] as String?,
          username: data['username'] as String,
          password: data['password'] as String? ?? '',
          email: '',
          phoneNumber: '',
          github: '',
          linkedin: '',
          technicalSkills: [],
          professionalSkills: [],
          certification: {},
          role: data['role'] as String?,
        );

        if (user.id != null) {
          await saveUserId(user.id ?? "");
        }

        return user;
      } else {
        final responseJson = jsonDecode(response.body);
        throw Exception('Failed to authenticate user: ${responseJson['error']}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to authenticate user: ${e.toString()}');
    }
  }

  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  // Send OTP for forgot password
  // Send OTP for forgot password
// Send OTP for forgot password
// Function to send OTP for forgot password
static Future<void> sendOtpForForgotPassword(String contactInfo) async {
  try {
    await saveContactInfo(contactInfo); // Save contactInfo before sending OTP

    final response = await http.post(
      Uri.parse("$baseUrl/forgot_password/send_otp"),
      body: jsonEncode({"contact_info": contactInfo}),
      headers: {"Content-Type": "application/json"},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      final responseJson = jsonDecode(response.body);
      if (responseJson.containsKey('error')) {
        throw Exception('Failed to send OTP: ${responseJson['error']}');
      } else {
        throw Exception('Failed to send OTP: Unknown error');
      }
    }



  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to send OTP: ${e.toString()}');
  }
}

  static Future<String?> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('user_id');
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get user ID: ${e.toString()}');
    }
  }

static Future<void> validateOtpForForgotPassword(String otpAttempt) async {
  try {
    final contactInfo = await getContactInfo();
    final userId = await getUserId();
     print(contactInfo);

    if (contactInfo == null) {
      throw Exception('Contact info not found in SharedPreferences');
    }

    print('Contact info: $contactInfo');
    print('User ID: $userId');

    final response = await http.post(
      Uri.parse("$baseUrl/forgot_password/validate_otp"),
      body: jsonEncode({
        "otp": otpAttempt,
        "user_id": userId,
        "contact_info": contactInfo
      }),
      headers: {"Content-Type": "application/json"},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      final responseJson = jsonDecode(response.body);
      throw Exception('Failed to validate OTP: ${responseJson['error']}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to validate OTP: ${e.toString()}');
  }
}




static Future<void> changePassword(String email, String newPassword) async {
  try {
    final response = await http.post(
      Uri.parse("$baseUrl/forgot_password/change_password"),
      body: jsonEncode({
        "new_password": newPassword,
        "email": email,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200) {
      final responseJson = jsonDecode(response.body);
      throw Exception('Failed to change password: ${responseJson['error']}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to change password: ${e.toString()}');
  }
}





  
  static Future<User> fetchUserProfileById(String userId) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is empty');
      }

      final response = await http.get(Uri.parse("$baseUrl/profile/$userId"));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data); // Ensure this matches your backend response structure
      } else {
        final responseJson = jsonDecode(response.body);
        throw Exception('Failed to fetch user profile: ${responseJson['error']}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch user profile: ${e.toString()}');
    }
  }

  static Future<void> updateUserProfile(String userId, Map<String, dynamic> profileData) async {
  try {
    final response = await http.put(
      Uri.parse("$baseUrl/profile/update/$userId"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode(profileData),
    );

    if (response.statusCode == 200) {
      print('Profile updated successfully');
      // Handle success as needed
    } else {
      final responseJson = jsonDecode(response.body);
      throw Exception('Failed to update profile: ${responseJson['error']}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to update profile: ${e.toString()}');
  }
}
  static Future<void> createJob({
    required String title,
    required String description,
    String? datePosted,
    double? salary,
    List<String> requirements = const [],
    String? location,
    required String userId,
  }) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = baseUrl;
      dio.options.connectTimeout = Duration(seconds: 5);
      dio.options.receiveTimeout = Duration(seconds: 3);

      final response = await dio.post(
        '/create_job',
        data: {
          'title': title,
          'description': description,
          'date_posted': datePosted,
          'salary': salary,
          'requirements': requirements,
          'location': location,
          'user_id': userId,
        },
      );

      if (response.statusCode == 201) {
        final data = response.data;
        print('Job created successfully: $data');
        // Handle successful creation as needed
      } else {
        throw Exception('Failed to create job');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to create job: ${e.toString()}');
    }
  }
static Future<String?> fetchUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('user_id');
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get user ID: ${e.toString()}');
    }
  }
  

    static Future<Job> fetchJobById(String jobId) async {
    final response = await http.get(Uri.parse('$baseUrl/jobbs/$jobId'));
    if (response.statusCode == 200) {
      return Job.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load job');
    }
  }
    static Future<User> fetchUserById(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
  // Fetch Jobs by User ID

  static Future<List<Job>> fetchJobsByUser(String userId) async {
  try {
    if (userId.isEmpty) {
      throw Exception('User ID is empty');
    }

    final response = await http.get(
      Uri.parse("$baseUrl/jobs/$userId"),
      headers: {"Content-Type": "application/json"},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;

      // Parse the JSON data to create a list of Job objects
      final jobs = data.map((item) => Job.fromJson(item)).toList();

      return jobs;
    } else {
      final responseJson = jsonDecode(response.body);
      throw Exception('Failed to fetch jobs: ${responseJson['error']}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to fetch jobs: ${e.toString()}');
  }
}
  static Future<List<Job>> recommendJobsBasedOnSkills(String userId) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is empty');
      }

      final response = await http.get(
        Uri.parse("$baseUrl/recommendations/$userId"),
        headers: {"Content-Type": "application/json"},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final data = responseJson['recommended_jobs'] as List<dynamic>;

        // Parse the JSON data to create a list of Job objects
        final jobs = data.map((item) => Job.fromJson(item)).toList();

        return jobs;
      } else {
        final responseJson = jsonDecode(response.body);
        throw Exception('Failed to fetch recommendations: ${responseJson['error']}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch recommendations: ${e.toString()}');
    }
  }
static Future<void> addReview({
  required String jobId,
  required String userId,
  required int rating,
  required String comment,
}) async {
  try {
    // Print IDs for debugging
    print('jobId: $jobId');
    print('userId: $userId');

    final review = {
      'job_id': jobId,
      'user_id': userId,
      'rating': rating,
      'comment': comment,
      'date': DateTime.now().toIso8601String(),
    };

    final response = await http.post(
      Uri.parse("$baseUrl/reviews/post"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(review),
    );

    if (response.statusCode == 201) {
      print('Review added successfully');
    } else {
      final responseJson = jsonDecode(response.body);
      throw Exception('Failed to add review: ${responseJson['error']}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to add review: ${e.toString()}');
  }
}


static Future<List<Review>> getTopRatedReviews() async {
  try {
    final response = await http.get(
      Uri.parse("$baseUrl/reviews/top-rated"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final reviewsJson = data['reviews'] as List<dynamic>;

      // Log the raw JSON data for debugging
      for (var reviewJson in reviewsJson) {
        print('Review JSON: $reviewJson');
      }

      // Convert each review JSON to a Review object
      return reviewsJson.map((reviewJson) {
        try {
          return Review.fromJson(reviewJson as Map<String, dynamic>);
        } catch (e) {
          print('Error parsing review JSON: $reviewJson\n$e');
          throw e;
        }
      }).toList();
    } else {
      final responseJson = jsonDecode(response.body);
      throw Exception('Failed to fetch top-rated reviews: ${responseJson['error']}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to fetch top-rated reviews: ${e.toString()}');
  }
}


 static Future<List<Job>> getJobs() async {
    final dio = Dio();
    try {
      final response = await dio.get("$baseUrl/jobs");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((job) => Job.fromJson(job)).toList();
      } else {
        throw Exception('Failed to load jobs: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error in getJobs: $e');
      throw Exception('Failed to load jobs: ${e.toString()}');
    }
  }
  // Method to fetch GitHub info by user ID from backend


  // Method to save GitHub info to backend



  static Future<Map<String, dynamic>> getInfo(String userId) async {
    // Example API request
    final response = await Dio().get('$baseUrl/github_info/$userId');
    
    if (response.statusCode == 200) {
      return response.data; // This should be the GitHub info
    } else {
      throw Exception('Failed to load GitHub info');
    }
  }
  static Future<void> scrapeGithub(String userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/scrape_github/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to scrape GitHub data');
    }
  }

static Future<List<Linkedin>> scrapeAndRecommend(String url, String userId) async {
  try {
    // Prepare the request URL
    String requestUrl = '$baseUrl/scrape_and_recommend/$userId?url=$url';

    final response = await http.get(
      Uri.parse(requestUrl),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      final data = responseJson['job_details'] as List<dynamic>;

      // Parse the JSON data to create a list of Linkedin objects
      return data.map((item) => Linkedin.fromJson(item)).toList();
    } else {
      final responseJson = jsonDecode(response.body);
      throw Exception('Failed to fetch recommended jobs: ${responseJson['error']}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to fetch recommended jobs: ${e.toString()}');
  }
}

static Future<List<User>> getFreelancers() async {
    final response = await http.get(Uri.parse('$baseUrl/freelancers'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load freelancers');
    }
  }
}


  


  
