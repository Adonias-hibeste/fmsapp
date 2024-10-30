import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart'; // Ensure you have GetX for snackbars
import 'package:membermanagementsystem/constants/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String? _message;

  Future<void> _sendResetPassword() async {
    final String email = _emailController.text;

    if (email.isEmpty) {
      setState(() {
        _message = "Please enter your email.";
      });
      return;
    }

    final response = await http.post(
      Uri.parse(url + 'forgot-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _message = json.decode(response.body)['success'];
      });
      // Show success message
      Get.snackbar('Success', _message!,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      setState(() {
        _message = "Failed to reset password. Please try again.";
      });
      // Show error message
      Get.snackbar('Error', _message!,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed("/login");
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.green.shade800),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelStyle: TextStyle(color: Colors.green.shade800),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendResetPassword,
              child: Text(
                'Reset Password',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            if (_message != null) ...[
              SizedBox(height: 16),
              Text(_message!, style: TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}
