import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/controllers/logout.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003049),
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile Settings'),
            onTap: () {
              // Navigate to Profile Settings
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Account Settings'),
            onTap: () {
              // Navigate to Account Settings
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification Settings'),
            onTap: () {
              // Navigate to Notification Settings
            },
          ),
          ListTile(
            leading: Icon(Icons.palette),
            title: Text('App Preferences'),
            onTap: () {
              // Navigate to App Preferences
            },
          ),
          ListTile(
            leading: Icon(Icons.support),
            title: Text('Support and Feedback'),
            onTap: () {
              // Navigate to Support and Feedback
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Navigate to About
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              AuthService.logout().then((_) {
                Get.offAllNamed('/Login');
              });
            },
          ),
        ],
      ),
    );
  }
}
