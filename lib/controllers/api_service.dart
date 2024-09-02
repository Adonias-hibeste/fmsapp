import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/constants/constants.dart';
import 'package:membermanagementsystem/controllers/authentication.dart';
import 'package:membermanagementsystem/models/comment.dart';
import 'package:membermanagementsystem/models/user_profile.dart';

class ApiService {
  final AuthenticationController _authService = AuthenticationController();
  // Replace with your backend URL

  Future<UserProfile> fetchUserProfile() async {
    final token = await _authService.getToken();
    final response = await http.get(
      Uri.parse(url + 'viewprofile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include the token in the headers
      },
    );

    if (response.statusCode == 200) {
      return UserProfile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse(url + 'index'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<Comment> createComment(String comment, int userId) async {
    final token = await _authService.getToken();
    final response = await http.post(
      Uri.parse(url + 'index'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token', // Include the token in the headers
      },
      body: jsonEncode(<String, String>{
        'comment': comment,
        'user_id': userId.toString(),
      }),
    );

    if (response.statusCode == 201) {
      return Comment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create comment');
    }
  }
}
