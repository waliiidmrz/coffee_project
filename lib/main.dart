import 'package:coffee_project/screens/forgot_password.dart';
import 'package:coffee_project/screens/reset_password.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/start_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/admin_dashboard.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Example provider setup
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Coffee Shop App',
        theme: ThemeData(
          primaryColor: const Color(0xFFC52127),
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: '/splash', // Initial route to splash screen
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/start': (context) => const StartScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
          '/home': (context) => HomeScreen(),
          '/adminDashboard': (context) => const AdminDashboard(),
          '/forgot_password': (context) => ForgotPasswordScreen(),
          '/reset_password': (context) => ResetPasswordScreen(),
        },
      ),
    );
  }
}

// Example Provider for State Management
class UserProvider extends ChangeNotifier {
  String _username = 'Jane Cooper';

  String get username => _username;

  void updateUsername(String username) {
    _username = username;
    notifyListeners();
  }
}
