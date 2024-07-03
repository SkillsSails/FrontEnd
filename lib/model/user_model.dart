class User {
  final String? username;
  final String? id;
  final String? password;
  final String? cvFile; // Path to the CV file

  const User({
    this.username,
    this.id,
    this.password,
    this.cvFile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      id: json['id'],
      password: json['password'],
      cvFile: json['cvFile'],
    );
  }

  const User.empty()
      : username = null,
        id = null,
        password = null,
        cvFile = null;
}
