import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  final Function onLogout;

  SettingsPage({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await onLogout();
            Get.offAllNamed('/Login');
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
