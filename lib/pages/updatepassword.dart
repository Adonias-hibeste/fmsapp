import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/constants/constants.dart';
import 'dart:convert';
import 'package:get/get.dart';

class UpdatePasswordPage extends StatelessWidget {
  final String userId; // Store userId received from previous screen
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  UpdatePasswordPage({Key? key, required this.userId}) : super(key: key);

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    final url = Uri.parse(
        url4 + 'user/$userId/update-password'); // Use userId in the URL
    print(
        'Updating password for user ID: $userId at URL: $url'); // Debugging line

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      print('Password updated successfully.');
      Get.snackbar('Success', 'Password updated successfully.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      print('Failed with status: ${response.statusCode}'); // Debugging line
      final errorResponse = json.decode(response.body);
      print('Error: ${errorResponse['message']}');
      Get.snackbar(
          'Error', errorResponse['message'] ?? 'An unknown error occurred.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Password',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Current Password'),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            ElevatedButton(
              onPressed: () {
                final currentPassword = currentPasswordController.text;
                final newPassword = newPasswordController.text;

                if (currentPassword.isEmpty || newPassword.isEmpty) {
                  Get.snackbar('Error', 'Please fill in all fields.',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                      colorText: Colors.white);
                } else {
                  updatePassword(currentPassword, newPassword);
                }
                Get.offAllNamed('/Login');
              },
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
