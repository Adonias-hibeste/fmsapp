import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:membermanagementsystem/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:get/get.dart';

class Drawerscreen extends StatefulWidget {
  const Drawerscreen({super.key});

  @override
  _DrawerscreenState createState() => _DrawerscreenState();
}

class _DrawerscreenState extends State<Drawerscreen> {
  String userName = '';
  String userEmail = '';
  String userMembership = '';
  String userAddress = '';
  String userAge = '';
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Guest';
      userEmail = prefs.getString('userEmail') ?? 'guest@example.com';
      userMembership = prefs.getString('userMembership') ?? 'N/A';
      userAddress = prefs.getString('userAddress') ?? 'N/A';
      userAge = prefs.getString('userAge') ?? 'N/A';
      String? imagePath = prefs.getString('userImage');
      if (imagePath != null) {
        _image = File(imagePath);
      }
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userImage', pickedFile.path);

      // Upload the image to the backend
      await _uploadImage(File(pickedFile.path));
    }
  }

  Future<void> _uploadImage(File image) async {
    final prefs = await SharedPreferences.getInstance();
    final userId =
        prefs.getInt('userId'); // Ensure you store userId in SharedPreferences

    var request =
        http.MultipartRequest('POST', Uri.parse(url + 'upload-profile-image'));
    request.fields['user_id'] = userId.toString();
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        Get.snackbar(
          'Success',
          'Profile image uploaded successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Failed to upload image: ${response.statusCode} - $responseBody');
        Get.snackbar(
          'Error',
          'Failed to upload image: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error uploading image: $e');
      Get.snackbar(
        'Error',
        'An error occurred while uploading the image',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF003049),
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : AssetImage('lib/images/google.png') as ImageProvider,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userEmail,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                // Navigate to Membership page
                Navigator.pushNamed(context, '/membership');
              },
              child: NewRow(
                text: 'Membership: $userMembership',
                icon: Icons.card_membership,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Logout page
                Navigator.pushNamed(context, '/Orders');
              },
              child: NewRow(
                text: 'Orders',
                icon: Icons.store,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Settings page
                Navigator.pushNamed(context, '/Settings');
              },
              child: NewRow(
                text: 'Settings',
                icon: Icons.settings,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Logout page
                Navigator.pushNamed(context, '/logout');
              },
              child: NewRow(
                text: 'Logout',
                icon: Icons.logout,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const NewRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
