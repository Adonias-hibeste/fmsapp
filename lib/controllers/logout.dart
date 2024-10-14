import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/constants/constants.dart';

class AuthService extends GetxService {
  static Future<void> logout() async {
    final response = await http.post(
      Uri.parse(url + 'logout'),
      headers: {
        'Accept': 'application/json',
        'Authorization':
            'Bearer YOUR_ACCESS_TOKEN', // Make sure to use the correct token
      },
    );

    if (response.statusCode == 200) {
      // Handle successful logout
      print("Logout successful");
      // You can also perform any additional logic here if needed.
    } else {
      // Handle error
      print("Logout failed: ${response.statusCode} - ${response.body}");
    }
  }
}
