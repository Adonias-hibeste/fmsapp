import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/constants/constants.dart';
import 'package:membermanagementsystem/models/Registration_model.dart';
import 'package:membermanagementsystem/models/blogspost.dart';
import 'package:http_parser/http_parser.dart';
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
    await prefs.setString(
        'userMembership', userData['membership']?.toString() ?? 'N/A');
    await prefs.setString('userAddress', userData['address'] ?? 'N/A');
    await prefs.setString('userAge', userData['age']?.toString() ?? 'N/A');
    await prefs.setInt('userId', userData['id']); // Store user ID
  }

  // Future<void> updateProfile({
  //   required String email,
  //   required String full_name,
  //   required String address,
  //   required String age,
  //   required String gender,
  //   required String phone_number,
  //   required String membership,
  // }) async {
  //   if (email.isEmpty ||
  //       full_name.isEmpty ||
  //       address.isEmpty ||
  //       age.isEmpty ||
  //       gender.isEmpty ||
  //       phone_number.isEmpty ||
  //       membership.isEmpty) {
  //     Get.snackbar(
  //       'Error',
  //       'All fields are required',
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //     return;
  //   }

  //   if (!GetUtils.isEmail(email)) {
  //     Get.snackbar(
  //       'Error',
  //       'Invalid email format',
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //     return;
  //   }

  //   try {
  //     isLoading.value = true;
  //     var request =
  //         http.MultipartRequest('POST', Uri.parse(url + 'updateprofile'));

  //     request.fields['email'] = email;
  //     request.fields['full_name'] = full_name;
  //     request.fields['address'] = address;
  //     request.fields['age'] = age;
  //     request.fields['gender'] = gender;
  //     request.fields['phone_number'] = phone_number;
  //     request.fields['membership'] = membership;

  //     var response = await request.send();
  //     isLoading.value = false;

  //     if (response.statusCode == 200) {
  //       Get.snackbar(
  //         'Success',
  //         'Profile updated successfully',
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //       );
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'Profile update failed',
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //       );
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     print('Update profile error: $e');
  //     Get.snackbar(
  //       'Error',
  //       'An error occurred during profile update',
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  Future login({
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
        final userData = {
          'id': responseBody['user']['id'], // Ensure you include the user ID
          'name': responseBody['user']['full_name'],
          'email': responseBody['user']['email'],
          'membership': responseBody['profile']['membership_id'],
          'address': responseBody['profile']['address'],
          'age': responseBody['profile']['age'],
        };

        await storeUserData(userData);

        Get.snackbar(
          'Success',
          'Login successful',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/Blogs');
      } else {
        final responseBody = json.decode(response.body);
        if (responseBody != null && responseBody['message'] != null) {
          final errorMessage = responseBody['message'];
          Get.snackbar(
            'Error',
            errorMessage,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Error',
            'Login failed',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
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
