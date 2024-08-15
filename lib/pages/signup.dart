import 'package:flutter/material.dart';
import 'package:membermanagementsystem/components/my_textfield.dart';

class Signup extends StatefulWidget {
  Function()? onTap;
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final firstnamecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final emailaddresscontroller = TextEditingController();
  final dateofbirthcontroller = TextEditingController();
  final createpasswordcontroller = TextEditingController();

  void signupUser() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 50,
            ),
            Icon(
              Icons.app_registration,
              size: 70,
              color: Colors.blue,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Register here!',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            SizedBox(
              height: 25,
            ),
            Mytextfield(
              controller: firstnamecontroller,
              hintText: 'First Name',
              obscureText: false,
            ),
            SizedBox(height: 10),
            Mytextfield(
              controller: lastnamecontroller,
              hintText: 'Last Name',
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
              controller: dateofbirthcontroller,
              hintText: 'Date of Birth',
              obscureText: false,
            ),
            SizedBox(height: 10),
            Mytextfield(
              controller: createpasswordcontroller,
              hintText: 'Create Password',
              obscureText: true,
            ),
            SizedBox(height: 25),
            GestureDetector(
                onTap: signupUser,
                child: Container(
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                )),
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
                Text(
                  'Register Here',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
