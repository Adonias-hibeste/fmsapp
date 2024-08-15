import "package:flutter/material.dart";
import "package:membermanagementsystem/pages/Login.dart";
import "package:membermanagementsystem/pages/blogs.dart";
import "package:membermanagementsystem/pages/events.dart";
import "package:membermanagementsystem/pages/payment.dart";
import "package:membermanagementsystem/pages/paymentsuccess.dart";
import "package:membermanagementsystem/pages/profile.dart";
import "package:membermanagementsystem/pages/reciept.dart";
import "package:membermanagementsystem/pages/settings.dart";
import "package:membermanagementsystem/pages/signup.dart";
import "package:membermanagementsystem/pages/Completeregister.dart";

void main() {
  runApp(Membermanagementsystem());
}

class Membermanagementsystem extends StatelessWidget {
  const Membermanagementsystem({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Reciept(),
    );
  }
}
