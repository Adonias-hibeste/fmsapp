import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/constants/constants.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileController extends GetxController {
  var userId = 0.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userMembership = ''.obs;
  var userAddress = ''.obs;
  var userAge = ''.obs;
  var userImage = ''.obs;

  Future<void> fetchProfileFromBackend() async {
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getInt('userId') ?? 0;

    if (userId.value != 0) {
      try {
        var response =
            await http.get(Uri.parse(url + 'get-user-profile/${userId.value}'));

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);
          userName.value = responseBody['user']['full_name'] ?? 'No Name';
          userEmail.value = responseBody['user']['email'] ?? 'No Email';
          userMembership.value =
              responseBody['profile']['membership_id']?.toString() ?? 'N/A';
          userAddress.value =
              responseBody['profile']['address'] ?? 'No Address';
          userAge.value = responseBody['profile']['age']?.toString() ?? 'N/A';
          userImage.value = responseBody['profile']['image'] != null
              ? url3 + responseBody['profile']['image']
              : '';
        } else {
          print('Failed to fetch profile: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching profile: $e');
      }
    }
  }
}
