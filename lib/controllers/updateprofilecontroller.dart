import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:membermanagementsystem/constants/constants.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profileData = {}.obs;

  // Fetch profile data from backend using user ID
  Future<void> fetchProfileData(String userId) async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(url + 'profile/$userId'),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        profileData.value = data;
      } else {
        Get.snackbar('Error', 'Failed to fetch profile data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }

  // Update profile data to backend using user ID
  Future<void> updateProfile({
    required String userId,
    required String email,
    required String full_name,
    required String address,
    required String age,
    required String gender,
    required String phone_number,
    required String membership,
  }) async {
    try {
      isLoading(true);
      print('Sending update request for User ID: $userId');

      var response = await http.put(
        Uri.parse(url + 'profile/update/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'full_name': full_name,
          'address': address,
          'age': age,
          'gender': gender,
          'phone_number': phone_number,
          'membership_id': membership,
        }),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        Get.snackbar('Success', 'Profile updated successfully!');
      } else {
        var errorData = json.decode(response.body);
        Get.snackbar('Error', 'Profile update failed: ${errorData['message']}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Profile update failed: $e');
    } finally {
      isLoading(false);
    }
  }
}
