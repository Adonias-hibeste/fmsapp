import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/controllers/authentication.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // Import the package

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  void navigateToSignUp() {
    Navigator.pushNamed(context, '/Signup'); // Navigate to the sign-up page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Soft background color
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  // Logo Icon
                  Icon(
                    Icons.sports_soccer_rounded,
                    size: 100,
                    color: Colors.green.shade800, // Darker green for icon
                  ),
                  SizedBox(height: 20),
                  // Welcome Text with Typewriter Animation
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Welcome Back !',
                        textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color:
                              Colors.green.shade800, // Color for welcome text
                        ),
                        speed: const Duration(
                            milliseconds: 200), // Slower writing speed
                      ),
                    ],
                    repeatForever: true, // Repeat indefinitely
                    pause: const Duration(
                        milliseconds: 500), // Pause after each animation
                  ),
                  SizedBox(height: 40),
                  // Email TextField
                  _buildTextField(
                    controller: emailcontroller,
                    label: 'Email Address',
                    hint: 'Enter your email',
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  // Password TextField
                  _buildTextField(
                    controller: passwordcontroller,
                    label: 'Password',
                    hint: 'Enter your password',
                    obscureText: true,
                  ),
                  SizedBox(height: 15),
                  // Forgot Password Link
                  GestureDetector(
                    onTap: () {
                      // Navigate to the Forgot Password page
                      Get.offAllNamed("/forgot-password");
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40),
                  // Sign In Button
                  ElevatedButton(
                    onPressed: () async {
                      await _authenticationController.login(
                        email: emailcontroller.text.trim(),
                        password: passwordcontroller.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.green.shade800,
                      elevation: 5,
                      shadowColor: Colors.green.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Obx(() {
                        return _authenticationController.isLoading.value
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              );
                      }),
                    ),
                  ),
                  SizedBox(height: 25),
                  // Register Prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: navigateToSignUp,
                        child: Text(
                          'Register Here',
                          style: TextStyle(
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to build a text field with consistent style
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscureText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.green.shade800,
          ),
        ),
        style: TextStyle(color: Colors.green.shade800),
        obscureText: obscureText,
      ),
    );
  }
}
