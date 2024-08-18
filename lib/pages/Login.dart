import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:membermanagementsystem/components/my_textfield.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Icon(
                  Icons.vpn_key,
                  size: 100,
                  color: Colors.blue,
                ),
                SizedBox(height: 50),
                Text(
                  'Welcome Back!',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                SizedBox(height: 25),
                Mytextfield(
                  controller: emailcontroller,
                  hintText: 'Email Address',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                Mytextfield(
                  controller: passwordcontroller,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () async {
                    await _authenticationController.login(
                      email: emailcontroller.text.trim(),
                      password: passwordcontroller.text.trim(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(25),
                    backgroundColor: Colors.blue,
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
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: navigateToSignUp,
                      child: Text(
                        'Register Here',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
