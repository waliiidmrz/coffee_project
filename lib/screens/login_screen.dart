import 'package:coffee_project/data/mockuser.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool isRegisterClicked = false;
  bool _obscurePassword = true;
  String? _emailError;
  String? _loginError;

  @override
  void initState() {
    super.initState();

    // Add listeners for focus changes
    emailFocusNode.addListener(() {
      setState(() {}); // Triggers rebuild to reflect focus state
    });

    passwordFocusNode.addListener(() {
      setState(() {}); // Triggers rebuild to reflect focus state
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() {
      if (MockUser.authenticate(
          emailController.text, passwordController.text)) {
        // Navigate to Home Screen if authentication is successful
        Navigator.pushNamed(context, '/home');
      } else {
        // Show an error message if authentication fails
        _loginError = "Invalid email or password";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/bisou_logo.png',
                width: 150,
              ),
              const SizedBox(height: 20),
              // Welcome Text
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontFamily: 'GianottenLTW04-Regular',
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please login to your account',
                style: TextStyle(
                  fontFamily: 'Arial_Regular',
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              // Email Field
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                onChanged: (value) {
                  setState(() {
                    if (RegExp(
                            r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      _emailError =
                          null; // Clear error if email format is valid
                    } else {
                      _emailError =
                          "Invalid email format"; // Set error if invalid
                    }
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    color: Color(0xFF0E3C3D),
                    fontFamily: 'Arial_Regular',
                  ),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xFFC52127),
                  ),
                  filled: true,
                  fillColor: emailFocusNode.hasFocus
                      ? Colors.white
                      : Colors.grey.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFC52127),
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  errorText: _emailError, // Display error message dynamically
                ),
              ),
              const SizedBox(height: 20),
              // Password Field
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                focusNode: passwordFocusNode,
                onChanged: (value) {
                  setState(() {
                    _loginError = null; // Clear login error on text change
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Color(0xFF0E3C3D),
                    fontFamily: 'Arial_Regular',
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFFC52127),
                  ),
                  suffixIcon: passwordFocusNode.hasFocus &&
                          passwordController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xFFC52127),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword =
                                  !_obscurePassword; // Toggle password visibility
                            });
                          },
                        )
                      : null, // Show the icon only if the field has focus and contains text
                  filled: true,
                  fillColor: passwordFocusNode.hasFocus
                      ? Colors.white
                      : Colors.grey.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFC52127),
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 5),
              // Login Error Message
              if (_loginError != null)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _loginError!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 175, 43, 34),
                        fontSize: 13,
                        fontFamily: 'Arial_Regular',
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              // Forgot Password
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF0E3C3D),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Arial_Regular',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Login Button
              ElevatedButton(
                onPressed: _handleLogin, // Correctly invoke the function here
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC52127),
                  shadowColor: const Color(0xFFC52127).withOpacity(0.5),
                  elevation: 8,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: 'Arial_Regular',
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // Signup Link
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(color: Colors.black, fontSize: 14.0),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isRegisterClicked = true;
                          });
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: isRegisterClicked
                                ? Color.fromARGB(255, 171, 170, 170)
                                : const Color.fromRGBO(233, 231, 231, 0.3),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                              color: Color(0xFFC52127),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
