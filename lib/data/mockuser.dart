import '../models/user.dart'; // Adjust the import path to your project structure

class MockUser {
  static final User adminUser = User(
    firstname: "admin",
    lastname: "admin",
    phoneNumber: "96416436",
    password: "admin",
    email: "admin@gmail.com",
    role: "admin",
  );

  static bool authenticate(String email, String password) {
    // Mock authentication logic
    return email == adminUser.email && password == adminUser.password;
  }
}
