import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:membermanagementsystem/controllers/CartController.dart';
import 'package:membermanagementsystem/controllers/Themeservice.dart';

import 'package:membermanagementsystem/pages/Login.dart';
import 'package:membermanagementsystem/pages/blogs.dart';

import 'package:membermanagementsystem/pages/events.dart';

import 'package:membermanagementsystem/pages/settings.dart';
import 'package:membermanagementsystem/pages/signup.dart';

import 'package:membermanagementsystem/pages/splashscreen.dart';
import 'package:membermanagementsystem/pages/updateprofile.dart';

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
  await GetStorage.init();
  Get.put(CartController());
  Get.put(ThemeController());
  runApp(Membermanagementsystem());
}

class Membermanagementsystem extends StatefulWidget {
  const Membermanagementsystem({super.key});

  @override
  _MembermanagementsystemState createState() => _MembermanagementsystemState();
}

class _MembermanagementsystemState extends State<Membermanagementsystem> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        // return GetMaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   theme: ThemeData.light(),
        //   darkTheme: ThemeData.dark(),
        //   themeMode: themeController.theme,
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeController().theme,
          home: Splashscreen(),
          onGenerateRoute: (settings) {
            if (settings.name == '/Signup') {
              return MaterialPageRoute(builder: (context) => Signup());
            }
            if (settings.name == '/Login') {
              return MaterialPageRoute(builder: (context) => Login());
            }
            if (settings.name == '/Blogs') {
              return MaterialPageRoute(builder: (context) => Blogs());
            }
            if (settings.name == '/Events') {
              return MaterialPageRoute(builder: (context) => Events());
            }
            if (settings.name == '/Settings') {
              return MaterialPageRoute(builder: (context) => SettingsPage());
            }
            if (settings.name == '/Updateprofile') {
              return MaterialPageRoute(
                  builder: (context) => UpdateProfilePage());
            }
            // Handle other routes here
            return null;
          },
        );
      },
    );
  }
}
