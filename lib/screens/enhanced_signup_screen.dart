import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class EnhancedSignUpScreen extends StatefulWidget {
  @override
  _EnhancedSignUpScreenState createState() => _EnhancedSignUpScreenState();
}

class _EnhancedSignUpScreenState extends State<EnhancedSignUpScreen>
    with TickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late AnimationController _backgroundController;
  late Animation<Color?> _backgroundAnimation;

  late AnimationController _logoController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoBounceAnimation;

  bool showNextFields = false;

  @override
  void initState() {
    super.initState();

    // Background animation controller
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundAnimation = ColorTween(
      begin: Colors.orangeAccent,
      end: Colors.pinkAccent,
    ).animate(_backgroundController);

    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _logoBounceAnimation = Tween<double>(begin: -30, end: 0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.bounceOut),
    );

    _logoController.forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_backgroundAnimation.value!, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: child,
          );
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              _buildLogo(),
              const SizedBox(height: 20),
              _buildFormFields(),
              const SizedBox(height: 20),
              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _logoBounceAnimation.value),
          child: Transform.scale(
            scale: _logoScaleAnimation.value,
            child: child,
          ),
        );
      },
      child: Image.asset(
        'assets/images/bisou_logo.png',
        width: 100,
        height: 100,
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildInputField(
          controller: nameController,
          label: 'Name',
          icon: Icons.person,
        ),
        const SizedBox(height: 10),
        _buildInputField(
          controller: emailController,
          label: 'Email',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
        if (showNextFields) ...[
          const SizedBox(height: 10),
          _buildInputField(
            controller: passwordController,
            label: 'Password',
            icon: Icons.lock,
            obscureText: true,
          ),
          const SizedBox(height: 10),
          _buildInputField(
            controller: confirmPasswordController,
            label: 'Confirm Password',
            icon: Icons.lock,
            obscureText: true,
          ),
        ],
        if (!showNextFields)
          TextButton(
            onPressed: () {
              setState(() {
                showNextFields = true;
              });
            },
            child: const Text('Next'),
          ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.pinkAccent),
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        // Add submission logic here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text('Sign Up', style: TextStyle(fontSize: 18)),
    );
  }
}
