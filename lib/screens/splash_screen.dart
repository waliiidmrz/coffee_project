import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> checkFirstTime(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    // If it's the first time, navigate to '/start'. Otherwise, navigate to '/login'.
    if (isFirstTime) {
      prefs.setBool('isFirstTime',
          false); // Set the flag to indicate the app has been opened.
      Navigator.pushReplacementNamed(context, '/start');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if the app is being opened for the first time.
    checkFirstTime(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/splash_background.png'), // Splash background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/bisou_logo.png', // Logo in the center
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
