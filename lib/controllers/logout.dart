import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/constants/constants.dart';

class AuthService extends GetxService {
  static Future<void> logout() async {
    final response = await http.post(
      Uri.parse(url + 'logout'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
      },
    );

    if (response.statusCode == 200) {
      // Handle successful logout
    } else {
      // Handle error
    }
  }
}
