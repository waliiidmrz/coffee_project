import 'package:BISOU/screens/admin_main_screen.dart';
import 'package:flutter/material.dart';
import '../utils/validators.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode surnameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  late final AnimationController backgroundController;
  late final Animation<Color?> backgroundColor;
  late final AnimationController logoController;
  late final Animation<double> logoAnimation;
  bool showFields = false;

  @override
  void initState() {
    super.initState();

    // Background Animation
    backgroundController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    backgroundColor = ColorTween(
      begin: const Color(0xFFB8C6DB),
      end: const Color(0xFFF5F7FA),
    ).animate(backgroundController);

    // Logo Animation
    logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    logoAnimation = CurvedAnimation(
      parent: logoController,
      curve: Curves.elasticOut,
    );

    logoController.forward();
  }

  @override
  void dispose() {
    backgroundController.dispose();
    logoController.dispose();
    nameFocusNode.dispose();
    surnameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: backgroundController,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [backgroundColor.value!, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Stack(
                    children: [
                      _buildFormBackground(),
                      _buildFormFields(),
                    ],
                  ),
                ),
                _buildSocialButtons(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          ScaleTransition(
            scale: logoAnimation,
            child: Image.asset(
              'assets/images/bisou_logo.png',
              width: 150,
            ),
          ),
          const Text(
            'Create Your Account',
            style: TextStyle(
              fontFamily: 'GianottenLTW04-Regular',
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          const Text(
            'Please fill the form below',
            style: TextStyle(
              fontFamily: 'Arial_Regular',
              fontSize: 16,
              color: Color.fromARGB(179, 55, 54, 54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormBackground() {
    return Positioned.fill(
      top: -35,
      child: Container(
        margin: const EdgeInsets.all(40),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Positioned.fill(
      top: 5,
      bottom: 50,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ..._buildInputFields(),
            const SizedBox(height: 30),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInputFields() {
    return [
      _buildInputField(
        focusNode: nameFocusNode,
        controller: nameController,
        label: 'First Name',
        icon: Icons.person_outline,
      ),
      const SizedBox(height: 15),
      _buildInputField(
        focusNode: surnameFocusNode,
        controller: surnameController,
        label: 'Last Name',
        icon: Icons.person_outline,
      ),
      const SizedBox(height: 15),
      _buildInputField(
        focusNode: emailFocusNode,
        controller: emailController,
        label: 'Email',
        icon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 15),
      _buildInputField(
        focusNode: phoneFocusNode,
        controller: phoneController,
        label: 'Phone Number',
        icon: Icons.phone_outlined,
        keyboardType: TextInputType.phone,
      ),
      const SizedBox(height: 15),
      _buildInputField(
        focusNode: passwordFocusNode,
        controller: passwordController,
        label: 'Password',
        icon: Icons.lock_outline,
        obscureText: true,
      ),
      const SizedBox(height: 15),
      _buildInputField(
        focusNode: confirmPasswordFocusNode,
        controller: confirmPasswordController,
        label: 'Confirm Password',
        icon: Icons.lock_outline,
        obscureText: true,
      ),
    ];
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required FocusNode focusNode,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      focusNode: focusNode,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFC52127),
            width: 1,
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFF0E3C3D),
          fontFamily: 'Arial_Regular',
        ),
        prefixIcon: Icon(icon, color: const Color(0xFFC52127)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (passwordController.text != confirmPasswordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Passwords do not match!'),
            ),
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const AdminMainScreen(),
            ),
            (route) => false,
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC52127),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: const Text(
        'Sign Up',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton('assets/images/facebook.png'),
        const SizedBox(width: 15),
        _buildSocialButton('assets/images/google.png'),
        const SizedBox(width: 15),
        _buildSocialButton('assets/images/apple-logo.png'),
      ],
    );
  }

  Widget _buildSocialButton(String assetPath) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
        backgroundColor: Colors.white.withOpacity(0.9),
      ),
      child: Image.asset(
        assetPath,
        width: 30,
        height: 30,
      ),
    );
  }
}
