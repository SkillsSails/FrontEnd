import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillssails/model/user_model.dart'; // Adjust this import as per your project structure

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

        // Ensure password is handled properly if it's nullable
        final password = data['password'] as String? ?? '';

        final email = data['email'] as String? ?? '';
        final phoneNumber = data['phone_number'] as String? ?? '';
        final github = data['github'] as String? ?? '';
        final linkedin = data['linkedin'] as String? ?? '';
        final technicalSkills = List<String>.from(data['technical_skills'] ?? []);
        final professionalSkills = List<String>.from(data['professional_skills'] ?? []);
        final certification = data['certification'] as Map<String, dynamic>?;

        final user = User(
          id: id,
          username: username,
          password: password, // Assign nullable password with default empty string
          email: email,
          phoneNumber: phoneNumber,
          github: github,
          linkedin: linkedin,
          technicalSkills: technicalSkills,
          professionalSkills: professionalSkills,
          certification: certification,
        );

        // Example: Save contact info if email is not null (non-null assertion used)
        if (user.email != null) {
          await saveContactInfo(user.email!);
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

}