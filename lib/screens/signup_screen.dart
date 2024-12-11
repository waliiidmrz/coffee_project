import 'package:coffee_project/screens/admin_main_screen.dart';
import 'package:coffee_project/screens/main_screen.dart';
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
  bool haveAccountClicked = false;
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
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/bg1.jpg'), // Path to your image
            fit: BoxFit.cover, // Adjusts the image to cover the container
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
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
            ),
            // Scrollable bottom section
            Expanded(
              child: Stack(
                children: [
                  // White rectangle with rounded corners
                  Positioned.fill(
                    top: -35,
                    child: Container(
                      margin: const EdgeInsets.all(40),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(28, 247, 245, 245)
                            .withOpacity(0.9),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.2), // Shadow color
                            blurRadius: 10, // Spread of the shadow
                            offset:
                                const Offset(0, 4), // Positioning the shadow
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Scrollable input fields and button
                  Positioned.fill(
                    top: 5,
                    bottom: 50,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 270,
                            child: Column(
                              children: [
                                _buildInputField(
                                  focusNode: nameFocusNode,
                                  controller: nameController,
                                  label: 'First Name',
                                  icon: Icons.person_outline,
                                  errorText: nameError,
                                  onChanged: (value) {
                                    setState(() {
                                      nameError =
                                          Validators.validateName(value);
                                    });
                                  },
                                ),
                                const SizedBox(height: 15),
                                _buildInputField(
                                  focusNode: surnameFocusNode,
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
                                  focusNode: emailFocusNode,
                                  controller: emailController,
                                  label: 'Email',
                                  icon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  errorText: emailError,
                                  onChanged: (value) {
                                    setState(() {
                                      emailError =
                                          Validators.validateEmail(value);
                                    });
                                  },
                                ),
                                const SizedBox(height: 15),
                                _buildInputField(
                                  focusNode: phoneFocusNode,
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
                                  focusNode: passwordFocusNode,
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
                                  focusNode: confirmPasswordFocusNode,
                                  controller: confirmPasswordController,
                                  label: 'Confirm Password',
                                  icon: Icons.lock_outline,
                                  obscureText: true,
                                  errorText: Validators.validateConfirmPassword(
                                    confirmPasswordController.text,
                                    passwordController.text,
                                  ),
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
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
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminMainScreen(),
                                    ),
                                    (route) => false);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC52127),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 8),
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
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: "Already have an account? ",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 17.0),
                                children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          haveAccountClicked = true;
                                        });
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: haveAccountClicked
                                              ? const Color.fromARGB(
                                                  255, 171, 170, 170)
                                              : const Color.fromRGBO(
                                                  233, 231, 231, 0.3),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: const Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Color(0xFFC52127),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Facebook button
                ElevatedButton(
                  onPressed: () {
                    // Add Facebook login functionality
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(
                        15), // Adjust padding for button size
                    backgroundColor:
                        Colors.white.withOpacity(0.9), // Facebook blue color
                  ),
                  child: Image.asset(
                    'assets/images/facebook.png', // Path to your Facebook logo asset
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 15), // Space between buttons

                // Google button
                ElevatedButton(
                  onPressed: () {
                    // Add Google login functionality
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                    backgroundColor:
                        Colors.white.withOpacity(0.9), // Facebook blue color
                  ),
                  child: Image.asset(
                    'assets/images/google.png', // Path to your Google logo asset
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 15),

                // Apple button
                ElevatedButton(
                  onPressed: () {
                    // Add Apple login functionality
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.white.withOpacity(0.9),
                  ),
                  child: Image.asset(
                    'assets/images/apple-logo.png', // Path to your Apple logo asset
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required FocusNode focusNode,
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
        errorText: errorText,
      ),
    );
  }
}
