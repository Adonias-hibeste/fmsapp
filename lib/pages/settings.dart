import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/controllers/Themeservice.dart';
import 'package:membermanagementsystem/pages/updateprofile.dart';

class SettingsPage extends StatelessWidget {
  final String userId; // Accept userId as a parameter

  SettingsPage({required this.userId}); // Constructor to receive userId

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          _buildSectionTitle('App Settings'),
          _buildListTile(
            icon: Icons.person,
            title: 'Update Profile',
            onTap: () {
              Get.to(UpdateProfilePage(userId: userId)); // Pass userId directly
            },
          ),
          GetBuilder<ThemeController>(builder: (themeController) {
            return _buildSwitchTile(
              icon: Icons.brightness_6,
              title: 'Enable Dark Mode',
              value: themeController.isDarkMode,
              onChanged: (bool value) {
                themeController.switchTheme();
              },
            );
          }),
          Divider(),
          _buildSectionTitle('Help'),
          _buildListTile(
            icon: Icons.support,
            title: 'Support',
            onTap: () {
              // Handle support
            },
          ),
          Divider(),
          _buildSectionTitle('App Info'),
          _buildListTile(
            icon: Icons.info,
            title: 'Build Version',
            subtitle: 'V 1.0.0',
            onTap: () {
              // Handle build version info
            },
          ),
          Divider(),
          _buildSectionTitle('Account Settings'),
          _buildListTile(
            icon: Icons.delete,
            title: 'Delete Account',
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {
              // Handle delete account
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? iconColor,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: iconColor ?? Colors.black),
          title:
              Text(title, style: TextStyle(color: textColor ?? Colors.black)),
          subtitle: subtitle != null ? Text(subtitle) : null,
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Switch(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
