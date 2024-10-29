import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/controllers/authentication.dart';

class Login extends StatefulWidget {
  Login({
    super.key,
  });

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
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Icon(
                    Icons.vpn_key,
                    size: 100,
                    color: Color(0xFF003049),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(color: Color(0xFF003049), fontSize: 30),
                  ),
                  SizedBox(height: 50),
                  TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter your email address',
                      hintStyle: TextStyle(color: Colors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xFF003049),
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF003049),
                      ),
                    ),
                    obscureText: false,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xFF003049),
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF003049),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          color: Colors.blueGrey.shade500,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      await _authenticationController.login(
                        email: emailcontroller.text.trim(),
                        password: passwordcontroller.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(25),
                      backgroundColor: Color(0xFF003049),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Obx(() {
                        return _authenticationController.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Sign in",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?',
                        style: TextStyle(
                          color: Color(0xFF003049),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: navigateToSignUp,
                        child: Text(
                          'Register Here',
                          style: TextStyle(color: Colors.blueGrey.shade500),
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
}
