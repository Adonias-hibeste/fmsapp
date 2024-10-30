import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/constants/constants.dart';
import 'package:membermanagementsystem/main.dart';
import 'package:membermanagementsystem/models/Registration_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends GetxController {
  var registrationData = RegistrationData().obs;
  final isLoading = false.obs;
  final storage = FlutterSecureStorage();

  void updateName(String full_name) {
    registrationData.update((data) {
      data?.full_name = full_name;
    });
  }

  void updateEmail(String email) {
    registrationData.update((data) {
      data?.email = email;
    });
  }

  void updatePassword(String password) {
    registrationData.update((data) {
      data?.password = password;
    });
  }

  void updateAddress(String address) {
    registrationData.update((data) {
      data?.address = address;
    });
  }

  void updateAge(String age) {
    registrationData.update((data) {
      data?.age = age;
    });
  }

  void updateGender(String gender) {
    registrationData.update((data) {
      data?.gender = gender;
    });
  }

  void updatePhoneNumber(String phoneNumber) {
    registrationData.update((data) {
      data?.phoneNumber = phoneNumber;
    });
  }

  void updateMembership(String membership) {
    registrationData.update((data) {
      data?.membership = membership;
    });
  }

  Future<void> signup({
    required String email,
    required String password,
    required String full_name,
    required String address,
    required String age,
    required String gender,
    required String phone_number,
    required String membership,
  }) async {
    if (email.isEmpty ||
        password.isEmpty ||
        full_name.isEmpty ||
        address.isEmpty ||
        age.isEmpty ||
        gender.isEmpty ||
        phone_number.isEmpty ||
        membership.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Invalid email format',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters long',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (full_name.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Name cannot be empty or just whitespace',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      var request = http.MultipartRequest('POST', Uri.parse(url + 'register'));

      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['full_name'] = full_name;
      request.fields['address'] = address;
      request.fields['age'] = age;
      request.fields['gender'] = gender;
      request.fields['phone_number'] = phone_number;
      request.fields['membership'] = membership;

      print('Sending request: ${request.fields}');
      var response = await request.send();
      isLoading.value = false;

      if (response.statusCode == 201) {
        var responseBody = await http.Response.fromStream(response);
        var responseData = jsonDecode(responseBody.body);
        debugPrint('Registration successful: ${responseData['user']}');
        Get.snackbar(
          'Success',
          'Registered successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/Login');
      } else {
        print('Registration failed with status code: ${response.statusCode}');
        Get.snackbar(
          'Error',
          'Registration failed',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      print('Registration error: $e');
      Get.snackbar(
        'Error',
        'An error occurred during registration',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> storeUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('userName', userData['name'] ?? 'Unknown');
    await prefs.setString(
        'userEmail', userData['email'] ?? 'unknown@example.com');
    await prefs.setString('userMembership',
        userData['membership']?.toString() ?? 'N/A'); // Membership ID
    await prefs.setString('userAddress', userData['address'] ?? 'N/A');
    await prefs.setString('userAge', userData['age']?.toString() ?? 'N/A');
    await prefs.setInt('userId', userData['id']);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Invalid email format',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters long',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      var data = {
        'email': email,
        'password': password,
      };
      var response = await http.post(
        Uri.parse(url + 'login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        // Debug: Print response body to check the structure
        print('Response Body: $responseBody');

        final user = responseBody['user'];
        final profile = responseBody['profile'];

        // Safeguard: Check if user and profile are actually maps
        if (user is! Map || profile is! Map) {
          Get.snackbar(
            'Error',
            'Unexpected data format in response',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        // Collect user data
        final userData = {
          'id': user['id'], // Ensure this is an int
          'name': user['full_name'] ?? 'Unknown',
          'email': user['email'] ?? 'unknown@example.com',
          'membership': profile['membership_id'], // This should be the ID
          'address': profile['address'] ?? 'N/A',
          'age': profile['age']?.toString() ??
              'N/A', // Convert age to String if necessary
          // Add membership details directly from the profile if available
          'membershipName': profile['membership_name'] ??
              'Default Membership', // Adjust this key if needed
          'membershipPrice':
              profile['membership_price'] ?? 0 // Adjust this key if needed
        };

        await storeUserData(userData);

        // Debugging: Print values in SharedPreferences to confirm correct storage
        final prefs = await SharedPreferences.getInstance();
        print('User ID: ${prefs.getInt('userId')}');
        print('User Name: ${prefs.getString('userName')}');
        print('Membership: ${prefs.getString('userMembership')}');
        print('Membership Name: ${prefs.getString('membershipName')}');
        print('Membership Price: ${prefs.getString('membershipPrice')}');

        // Set the user ID in the main app state
        memberManagementSystemKey.currentState
            ?.setUserId(user['id'].toString());

        Get.snackbar(
          'Success',
          'Login successful',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 1), // Set the duration here
        );

        Get.offAllNamed('/Blogs');
      } else {
        final responseBody = json.decode(response.body);
        final errorMessage = responseBody['message'] ?? 'Login failed';
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error: $e');
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
