class User {
  final String? id;
  final String username;
  final String? password;

  User({required this.id, required this.username, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      username: json['username'] as String,
      password: json['password'] as String?,
    );
  }
}


