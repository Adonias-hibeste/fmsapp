import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:membermanagementsystem/main.dart';
import 'package:membermanagementsystem/pages/Login.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset(
                "lib/lottie/Animation - 1728104673363.json"),
          )
        ],
      ),
      nextScreen: Login(),
      backgroundColor: Colors.white,
      splashIconSize: 400,
    );
  }
}
