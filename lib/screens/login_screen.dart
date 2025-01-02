<<<<<<< Updated upstream
import 'package:BISOU/widgets/welcom_back.dart';
import 'package:flutter/material.dart';
=======
import 'package:flutter/material.dart';
import 'package:BISOU/widgets/welcome_back.dart';
>>>>>>> Stashed changes
import 'package:BISOU/data/mockuser.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool showFields = false;
  bool _obscurePassword = true;
  String? _emailError;
  String? _loginError;
  String? _passwordError;

  late final AnimationController _fieldsController;
  late final AnimationController _fadeController;
  late final AnimationController _loginButtonController;
  late final AnimationController _logoController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _sizeAnimation;
  late final Animation<double> _buttonScaleAnimation;
  late final Animation<double> _fadeInAnimation;
  late final Animation<double> _scaleUpAnimation;
  late final Animation<double> _rotateAnimation;

  bool showInstructionText = false;

  late final AnimationController _instructionTextController;
  late final Animation<double> _instructionTextFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Text Fields Animation
    _fieldsController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );

    // Instruction Text Animation
    _instructionTextController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _instructionTextFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _instructionTextController, curve: Curves.easeIn),
    );

    // Add Status Listener for _fieldsController
    _fieldsController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showInstructionText = true;
        });
        _instructionTextController.forward();
      }
    });

    // Logo Animation Controller
    _logoController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Fade-In Animation
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    // Scale-Up Animation
    _scaleUpAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    // Rotation Animation
    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    // Start Logo Animation Once
    _logoController.forward();
    // Fade Animation for Text Fields
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Size Animation for Text Fields
    _sizeAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _fieldsController, curve: Curves.easeOutBack),
    );

    // Login Button Hover Animation
    _loginButtonController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _buttonScaleAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(parent: _loginButtonController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fieldsController.dispose();
    _fadeController.dispose();
    _loginButtonController.dispose();
    _logoController.dispose();
    _instructionTextController.dispose();
    super.dispose();
  }

  void _toggleFieldsOrLogin() {
    if (!showFields) {
      // Show the fields with animation
      setState(() {
        showFields = true;
      });
      _fieldsController.forward();
      _fadeController.forward();
    } else {
      // Validate inputs and login
      _handleLogin();
    }
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
      resizeToAvoidBottomInset: false, // Prevent layout breaking
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/bg1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.5),
                        const Color.fromARGB(0, 253, 253, 253)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Animated Logo and Welcome Text
              AnimatedPositioned(
                duration: const Duration(seconds: 3),
                curve: Curves.easeInOut,
                top: showFields ? 50 : MediaQuery.of(context).size.height / 4,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _logoController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeInAnimation.value,
                          child: Transform.scale(
                            scale: _scaleUpAnimation.value,
                            child: Transform.rotate(
                              angle: _rotateAnimation.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.8),
                                      blurRadius: 20,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'assets/images/bisou_logo.png',
                                  width: 150,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    // Welcome Text
                    WelcomeBackText(),
                    // Instruction Text (Appears After Animation)
                    if (showInstructionText)
                      FadeTransition(
                        opacity: _instructionTextFadeAnimation,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Please fill the forms below',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 119, 113, 113),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Login Button
              AnimatedPositioned(
                duration: const Duration(seconds: 3),
                curve: Curves.easeInOut,
                bottom:
                    showFields ? 210 : MediaQuery.of(context).size.height / 3,
                left: MediaQuery.of(context).size.width / 4,
                right: MediaQuery.of(context).size.width / 4,
                child: GestureDetector(
                  onTap: _toggleFieldsOrLogin,
                  child: MouseRegion(
                    onEnter: (_) => _loginButtonController.forward(),
                    onExit: (_) => _loginButtonController.reverse(),
                    child: ScaleTransition(
                      scale: _buttonScaleAnimation,
                      child: Container(
                        constraints:
                            const BoxConstraints(maxWidth: 300, minWidth: 150),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE53935), Color(0xFFD81B60)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Naturally',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Text Fields (Appear in the Middle)
              if (showFields)
                Align(
                  alignment: Alignment.center,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _sizeAnimation,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextField(
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
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFFC52127),
                                ),
                                errorText: _emailError,
                                fillColor: emailFocusNode.hasFocus
                                    ? Colors.white.withOpacity(0.5)
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
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextField(
                              controller: passwordController,
                              obscureText: _obscurePassword,
                              focusNode: passwordFocusNode,
                              onChanged: (value) {
                                setState(() {
                                  _loginError =
                                      null; // Clear login error on text change
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
                                    ? Colors.white.withOpacity(0.5)
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
                          ),
                          const SizedBox(height: 5),
                          // Login Error Message
                          if (_loginError != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
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
                          const SizedBox(height: 33),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
