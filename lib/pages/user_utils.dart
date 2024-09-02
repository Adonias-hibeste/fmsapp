import 'package:membermanagementsystem/controllers/api_service.dart';
import 'package:membermanagementsystem/models/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:membermanagementsystem/pages/mydrawer.dart';

// Function to fetch and store user ID
Future<void> fetchAndStoreUserId() async {
  ApiService apiService = ApiService();
  UserProfile userProfile = await apiService.fetchUserProfile();

  final userId = userProfile.id;

  // Store user ID in SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userId', userId);
}

// Function to retrieve user ID
Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId');
}
