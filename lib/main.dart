import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/pages/Login.dart';
import 'package:membermanagementsystem/pages/blogs.dart';
import 'package:membermanagementsystem/pages/eventreg.dart';
import 'package:membermanagementsystem/pages/events.dart';
import 'package:membermanagementsystem/pages/news.dart';
import 'package:membermanagementsystem/pages/payments.dart';
import 'package:membermanagementsystem/pages/paymentsuccess.dart';
import 'package:membermanagementsystem/pages/profile.dart';
import 'package:membermanagementsystem/pages/settings.dart';
import 'package:membermanagementsystem/pages/signup.dart';
import 'package:membermanagementsystem/pages/Completeregister.dart';
import 'package:membermanagementsystem/pages/splashscreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
        // Handle other routes here
        return null;
      },
    );
  }
}
