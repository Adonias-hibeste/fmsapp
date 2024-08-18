import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/pages/Login.dart';
import 'package:membermanagementsystem/pages/blogs.dart';
import 'package:membermanagementsystem/pages/events.dart';
import 'package:membermanagementsystem/pages/payment.dart';
import 'package:membermanagementsystem/pages/paymentsuccess.dart';
import 'package:membermanagementsystem/pages/profile.dart';
import 'package:membermanagementsystem/pages/reciept.dart';
import 'package:membermanagementsystem/pages/settings.dart';
import 'package:membermanagementsystem/pages/signup.dart';
import 'package:membermanagementsystem/pages/Completeregister.dart';

void main() {
  runApp(Membermanagementsystem());
}

class Membermanagementsystem extends StatelessWidget {
  const Membermanagementsystem({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Blogs(),
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
        // Handle other routes here
        return null;
      },
    );
  }
}
