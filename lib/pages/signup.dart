import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/components/my_textfield.dart';
import 'package:membermanagementsystem/controllers/authentication.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final namecontroller = TextEditingController();
  final emailaddresscontroller = TextEditingController();
  final createpasswordcontroller = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  void signupUser() {}
  void navigateToLogin() {
    Navigator.pushNamed(context, '/Login'); // Navigate to the sign-up page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // Added SingleChildScrollView
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Icon(
                  Icons.app_registration,
                  size: 70,
                  color: Colors.blue,
                ),
                SizedBox(height: 50),
                Text(
                  'Register here!',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                SizedBox(height: 25),
                Mytextfield(
                  controller: namecontroller,
                  hintText: 'Name',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                Mytextfield(
                  controller: emailaddresscontroller,
                  hintText: 'Email Address',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                Mytextfield(
                  controller: createpasswordcontroller,
                  hintText: 'Create Password',
                  obscureText: true,
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () async {
                    await _authenticationController.signup(
                      name: namecontroller.text.trim(),
                      email: emailaddresscontroller.text.trim(),
                      password: createpasswordcontroller.text.trim(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(25),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(
                        double.infinity, 60), // Adjust the height as needed
                  ),
                  child: Obx(() {
                    return _authenticationController.isLoading.value
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          );
                  }),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: navigateToLogin,
                      child: Text(
                        'Login Here',
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
