import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:membermanagementsystem/controllers/CartController.dart';
import 'package:membermanagementsystem/controllers/Themeservice.dart';
import 'package:membermanagementsystem/controllers/membershipcontroller.dart';
import 'package:membermanagementsystem/pages/Login.dart';
import 'package:membermanagementsystem/pages/blogs.dart';
import 'package:membermanagementsystem/pages/events.dart';
import 'package:membermanagementsystem/pages/forgotpassword.dart';
import 'package:membermanagementsystem/pages/settings.dart';
import 'package:membermanagementsystem/pages/signup.dart';
import 'package:membermanagementsystem/pages/splashscreen.dart';
import 'package:membermanagementsystem/pages/updatepassword.dart';
import 'package:membermanagementsystem/pages/updateprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Global key for MemberManagementSystem
final GlobalKey<_MemberManagementSystemState> memberManagementSystemKey =
    GlobalKey<_MemberManagementSystemState>();

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF003049),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF003049),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF003049),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.white,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.teal,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.teal,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.teal,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
  scaffoldBackgroundColor: Colors.black,
);

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure widget binding is initialized
  await GetStorage.init();
  Get.put(MembershipController());
  Get.put(CartController());
  Get.put(ThemeController());

  runApp(
      MemberManagementSystem(key: memberManagementSystemKey)); // Pass the key
}

class MemberManagementSystem extends StatefulWidget {
  const MemberManagementSystem({super.key});

  @override
  _MemberManagementSystemState createState() => _MemberManagementSystemState();
}

class _MemberManagementSystemState extends State<MemberManagementSystem> {
  String? userId; // Store the user ID here

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getUserIdFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    userId =
        prefs.getInt('userId')?.toString(); // Fetch and store userId as String
    print('Retrieved userId: $userId'); // Debugging line
    if (userId == null) {
      Get.snackbar(
        'Error',
        'User ID not found',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    setState(() {}); // Update the state after fetching the user ID
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeController.theme,
          home: Splashscreen(),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/forgot-password':
                return MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage());
              case '/Signup':
                return MaterialPageRoute(builder: (context) => Signup());
              case '/Login':
                return MaterialPageRoute(builder: (context) => Login());
              case '/Blogs':
                return MaterialPageRoute(builder: (context) => Blogs());
              case '/Events':
                return MaterialPageRoute(builder: (context) => Events());
              case '/Settings':
                if (userId != null) {
                  return MaterialPageRoute(
                      builder: (context) => SettingsPage(userId: userId!));
                } else {
                  return MaterialPageRoute(builder: (context) => Login());
                }
              case '/UpdateProfilePage':
                if (userId != null) {
                  return MaterialPageRoute(
                      builder: (context) => UpdateProfilePage(userId: userId!));
                } else {
                  return MaterialPageRoute(builder: (context) => Login());
                }
              case '/UpdatePasswordPage':
                if (userId != null) {
                  return MaterialPageRoute(
                      builder: (context) =>
                          UpdatePasswordPage(userId: userId!));
                } else {
                  return MaterialPageRoute(builder: (context) => Login());
                }
              default:
                return MaterialPageRoute(builder: (context) => Login());
            }
          },
        );
      },
    );
  }

  void setUserId(String id) {
    setState(() {
      userId = id;
    });
  }
}
