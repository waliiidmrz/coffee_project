import 'package:flutter/material.dart';
import 'package:BISOU/widgets/welcome_back.dart';
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

  late final AnimationController _newAccountController;
  late final Animation<double> _newAccountAnimation;
  late final AnimationController _forgotPasswordController;
  late final Animation<double> _forgotPasswordAnimation;

  @override
  void initState() {
    super.initState();

    // Text Fields Animation
    _fieldsController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Logo Animation Controller
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
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

    // New Account Text Animation
    _newAccountController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _newAccountAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _newAccountController, curve: Curves.easeInOut),
    );
    _newAccountController.forward();

    // Forgot Password Text Animation
    _forgotPasswordController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _forgotPasswordAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _forgotPasswordController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _fieldsController.dispose();
    _fadeController.dispose();
    _loginButtonController.dispose();
    _logoController.dispose();
    _newAccountController.dispose();
    _forgotPasswordController.dispose();
    super.dispose();
  }

  void _toggleFieldsOrLogin() {
    if (!showFields) {
      setState(() {
        showFields = true;
      });
      _fieldsController.forward();
      _fadeController.forward();
      _forgotPasswordController.forward();
    } else {
      _handleLogin();
    }
  }

  void _handleLogin() {
    setState(() {
      if (MockUser.authenticate(
          emailController.text, passwordController.text)) {
        Navigator.pushNamed(context, '/home');
      } else {
        _loginError = "Invalid email or password";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
                  colors: [Colors.white.withOpacity(0.5), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Animated Logo and Welcome Text
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1500),
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
                WelcomeBackText(),
              ],
            ),
          ),
          // Login Button
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
            bottom: showFields ? 210 : MediaQuery.of(context).size.height / 3,
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
          // Forgot Password Text
          if (showFields)
            Positioned(
              bottom: 185,
              left: 40,
              child: FadeTransition(
                opacity: _forgotPasswordAnimation,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/forgot_password');
                  },
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Colors.blue,
                        const Color.fromARGB(255, 252, 251, 252)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (showFields)
            // Create Account Text
            Positioned(
              bottom: 145,
              left: 40,
              child: FadeTransition(
                opacity: _newAccountAnimation,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                  child: Text(
                    'Don' 't have an account ? Signup . ',
                    style: TextStyle(
                      fontSize: 14,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          // Text Fields
          if (showFields)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Align(
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
                            onTap: () {
                              setState(() {}); // Trigger rebuild on tap
                            },
                            /*onChanged: (value) {
                              setState(() {
                                if (RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$')
                                    .hasMatch(value)) {
                                  _emailError = null;
                                } else {
                                  _emailError = "Invalid email format";
                                }
                              });
                            },*/
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: emailFocusNode.hasFocus
                                    ? Color(0xFFC52127)
                                    : Color(0xFF0E3C3D),
                                fontFamily: 'Arial_Regular',
                              ),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: emailFocusNode.hasFocus
                                    ? Color(0xFFC52127)
                                    : Colors.grey,
                              ),
                              errorText: _emailError,
                              filled: true,
                              fillColor: emailFocusNode.hasFocus
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.grey.withOpacity(0.1),
                              border: emailFocusNode.hasFocus
                                  ? OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color(0xFFC52127),
                                        width: 2,
                                      ),
                                    )
                                  : OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                              contentPadding: const EdgeInsets.all(16),
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
                            onTap: () {
                              setState(() {}); // Trigger rebuild on tap
                            },
                            onChanged: (value) {
                              setState(() {
                                _loginError = null;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: passwordFocusNode.hasFocus
                                    ? Color(0xFFC52127)
                                    : Color(0xFF0E3C3D),
                                fontFamily: 'Arial_Regular',
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: passwordFocusNode.hasFocus
                                    ? Color(0xFFC52127)
                                    : Colors.grey,
                              ),
                              suffixIcon: passwordFocusNode.hasFocus &&
                                      passwordController.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Color(0xFFC52127),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    )
                                  : null,
                              filled: true,
                              fillColor: passwordFocusNode.hasFocus
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.grey.withOpacity(0.1),
                              border: passwordFocusNode.hasFocus
                                  ? OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color(0xFFC52127),
                                        width: 2,
                                      ),
                                    )
                                  : OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
