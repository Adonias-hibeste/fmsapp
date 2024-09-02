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

class AuthenticationController extends GetxController {
  var registrationData = RegistrationData().obs;
  final isLoading = false.obs;
  final storage = FlutterSecureStorage();
  void updateName(String name) {
    registrationData.update((data) {
      data?.name = name;
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

  void updateFullAddress(String fullAddress) {
    registrationData.update((data) {
      data?.fullAddress = fullAddress;
    });
  }

  void updateDob(String dob) {
    registrationData.update((data) {
      data?.dob = dob;
    });
  }

  void updatePlaceOfBirth(String placeOfBirth) {
    registrationData.update((data) {
      data?.placeOfBirth = placeOfBirth;
    });
  }

  void updateNationality(String nationality) {
    registrationData.update((data) {
      data?.nationality = nationality;
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

  void updateMembershipType(String membershipType) {
    registrationData.update((data) {
      data?.membershipType = membershipType;
    });
  }

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String full_address,
    required String dob,
    required String place_of_birth,
    required String nationality,
    required String gender,
    required String phone_number,
    required String membership_type,
  }) async {
    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        full_address.isEmpty ||
        dob.isEmpty ||
        place_of_birth.isEmpty ||
        nationality.isEmpty ||
        gender.isEmpty ||
        phone_number.isEmpty ||
        membership_type.isEmpty) {
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

    if (name.trim().isEmpty) {
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
      request.fields['name'] = name;
      request.fields['full_address'] = full_address;
      request.fields['dob'] = dob;
      request.fields['place_of_birth'] = place_of_birth;
      request.fields['nationality'] = nationality;
      request.fields['gender'] = gender;
      request.fields['phone_number'] = phone_number;
      request.fields['membership_type'] = membership_type;

      // Determine the content type based on the file extension

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
        debugPrint('Logged in successfully: ${json.decode(response.body)}');
        final token = data['token'];
        await storage.write(key: 'auth_token', value: token);
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

  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }
}
