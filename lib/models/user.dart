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
      firstname: json['firstname'],
      lastname: json['lastname'],
      phoneNumber: json['phoneNumber'],
      birthDate: DateTime.parse(json['birthDate']),
      password: json['password'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
    );
  }
}
