import 'package:flutter/material.dart';
import 'package:membermanagementsystem/components/my_textfield.dart';

class Login extends StatefulWidget {
  Function()? onTap;

  Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  void signUserIn() {}
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
              Icons.vpn_key,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Welcome Back!',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            SizedBox(
              height: 25,
            ),
            Mytextfield(
              controller: usernamecontroller,
              hintText: 'Username',
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
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(height: 25),
            GestureDetector(
                onTap: signUserIn,
                child: Container(
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(
                    "Sign in",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                )),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'continue with',
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ))
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Image.asset("lib/images/google.png", height: 40),
                ),
                SizedBox(width: 25),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Image.asset("lib/images/apple.png", height: 40),
                ),
              ],
            ),
            SizedBox(height: 50),
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
