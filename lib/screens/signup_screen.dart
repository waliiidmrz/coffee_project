import 'package:flutter/material.dart';
import '../utils/validators.dart'; // Import the validators file

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

  String? nameError;
  String? lastnameError;
  String? emailError;
  String? phoneError;
  String? passwordError;

  @override
  void initState() {
    super.initState();

    // Add listeners for focus changes
    nameFocusNode.addListener(() => setState(() {}));
    surnameFocusNode.addListener(() => setState(() {}));
    emailFocusNode.addListener(() => setState(() {}));
    phoneFocusNode.addListener(() => setState(() {}));
    passwordFocusNode.addListener(() => setState(() {}));
    confirmPasswordFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // Dispose of FocusNodes
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Fixed top section
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/bisou_logo.png',
                    width: 150,
                  ),
                  const Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontFamily: 'GianottenLTW04-Regular',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const Text(
                    'Please fill the form below',
                    style: TextStyle(
                      fontFamily: 'Arial_Regular',
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            // Scrollable bottom section
            // Scrollable bottom section with background rectangle
            Expanded(
              child: Stack(
                children: [
                  // White rectangle with rounded corners
                  Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        border: Border.all(
                            color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                    ),
                  ),

                  // Scrollable input fields and button
                  Positioned.fill(
                    top: 20,
                    bottom: 15,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          _buildInputField(
                            controller: nameController,
                            label: 'First Name',
                            icon: Icons.person_outline,
                            errorText: nameError,
                            onChanged: (value) {
                              setState(() {
                                nameError = Validators.validateName(value);
                              });
                            },
                          ),
                          const SizedBox(height: 15),
                          _buildInputField(
                            controller: surnameController,
                            label: 'Last Name',
                            icon: Icons.person_outline,
                            errorText: lastnameError,
                            onChanged: (value) {
                              setState(() {
                                lastnameError =
                                    Validators.validateLastName(value);
                              });
                            },
                          ),
                          const SizedBox(height: 15),
                          _buildInputField(
                            controller: emailController,
                            label: 'Email',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            errorText: emailError,
                            onChanged: (value) {
                              setState(() {
                                emailError = Validators.validateEmail(value);
                              });
                            },
                          ),
                          const SizedBox(height: 15),
                          _buildInputField(
                            controller: phoneController,
                            label: 'Phone Number',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            errorText: phoneError,
                            onChanged: (value) {
                              setState(() {
                                phoneError =
                                    Validators.validatePhoneNumber(value);
                              });
                            },
                          ),
                          const SizedBox(height: 15),
                          _buildInputField(
                            controller: passwordController,
                            label: 'Password',
                            icon: Icons.lock_outline,
                            obscureText: true,
                            errorText: passwordError,
                            onChanged: (value) {
                              setState(() {
                                passwordError =
                                    Validators.validatePassword(value);
                              });
                            },
                          ),
                          const SizedBox(height: 15),
                          _buildInputField(
                            controller: confirmPasswordController,
                            label: 'Confirm Password',
                            icon: Icons.lock_outline,
                            obscureText: true,
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Passwords do not match!'),
                                  ),
                                );
                              } else {
                                Navigator.pushNamed(context, '/home');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC52127),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? errorText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    void Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFFC52127)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorText: errorText,
      ),
    );
  }
}
