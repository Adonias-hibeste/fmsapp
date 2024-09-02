import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/components/my_textfield.dart';
import 'package:membermanagementsystem/controllers/authentication.dart';
import 'package:membermanagementsystem/pages/Completeregister.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final emailaddresscontroller = TextEditingController();
  final createpasswordcontroller = TextEditingController();
  final AuthenticationController authController =
      Get.put(AuthenticationController());

  void signupUser() {
    // Save data to the controller
    authController.updateName(namecontroller.text);
    authController.updatePhoneNumber(phonecontroller.text);
    authController.updateEmail(emailaddresscontroller.text);
    authController.updatePassword(createpasswordcontroller.text);

    // Navigate to the next page with arguments
    Get.to(() => Completeregister(), arguments: {
      'name': namecontroller.text,
      'phone': phonecontroller.text,
      'email': emailaddresscontroller.text,
      'password': createpasswordcontroller.text,
    });
  }

  void navigateToLogin() {
    Navigator.pushNamed(context, '/Login'); // Navigate to the login page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                    'Create your Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 35),
                  TextFormField(
                    controller: namecontroller,
                    onChanged: (value) => authController.updateName(value),
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(color: Colors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    ),
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phonecontroller,
                    onChanged: (value) =>
                        authController.updatePhoneNumber(value),
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'Enter your phone number',
                      hintStyle: TextStyle(color: Colors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    ),
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailaddresscontroller,
                    onChanged: (value) => authController.updateEmail(value),
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter your email address',
                      hintStyle: TextStyle(color: Colors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    ),
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: createpasswordcontroller,
                    onChanged: (value) => authController.updatePassword(value),
                    decoration: InputDecoration(
                      labelText: 'Create Password',
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: signupUser,
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(25),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(
                          300, 60), // Adjust the width and height as needed
                    ),
                  ),
                  SizedBox(height: 20),
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
                          ' Log in',
                          style: TextStyle(
                            color: Colors.blue,
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
}
