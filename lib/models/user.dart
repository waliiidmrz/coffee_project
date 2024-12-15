class User {
  final String? firstname;
  final String? lastname;
  final String? phoneNumber;
  final DateTime? birthDate;
  final String password;
  final String email;
  final String? role;
  final String? token;

  User({
    this.firstname,
    this.lastname,
    this.phoneNumber,
    this.birthDate,
    required this.password,
    required this.email,
    this.role,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'])
          : null,
      password: json['password'] as String,
      email: json['email'] as String,
      role: json['role'] as String?,
      token: json['token'] as String?,
    );
  }
}
