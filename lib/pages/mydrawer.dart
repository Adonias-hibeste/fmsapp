import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/constants/constants.dart';
import 'package:membermanagementsystem/controllers/authentication.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer>
    with SingleTickerProviderStateMixin {
  final AuthenticationController authController =
      Get.put(AuthenticationController());

  late Future<Map<String, dynamic>> profile;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    profile = fetchProfile();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = selectedImage;
    });
  }

  Future<Map<String, dynamic>> fetchProfile() async {
    final token = await authController.getToken(); // Fetch token dynamically
    final response = await http.get(
      Uri.parse(url + 'viewprofile'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to load profile: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Color(0xFF003049), // Set the color to 0xFF003049
            child: Stack(
              children: [
                FutureBuilder<Map<String, dynamic>>(
                  future: profile,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Color(
                              0xFF003049), // Ensure the header is 0xFF003049
                        ),
                        accountName: Text('Loading...'),
                        accountEmail: Text('Loading...'),
                        currentAccountPicture: CircleAvatar(
                          radius: 50,
                          backgroundImage: _image != null
                              ? FileImage(File(_image!.path))
                              : AssetImage('lib/images/google.png')
                                  as ImageProvider,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Color(
                              0xFF003049), // Ensure the header is 0xFF003049
                        ),
                        accountName: Text('Error'),
                        accountEmail: Text('Error'),
                        currentAccountPicture: CircleAvatar(
                          radius: 50,
                          backgroundImage: _image != null
                              ? FileImage(File(_image!.path))
                              : AssetImage('lib/images/google.png')
                                  as ImageProvider,
                        ),
                      );
                    } else {
                      final profileData = snapshot.data!;
                      return UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Color(0xFF003049),
                        ),
                        accountName: Text(profileData['name']),
                        accountEmail: Text(profileData['email']),
                        currentAccountPicture: CircleAvatar(
                          radius: 50,
                          backgroundImage: _image != null
                              ? FileImage(File(_image!.path))
                              : AssetImage('lib/images/google.png')
                                  as ImageProvider,
                        ),
                      );
                    }
                  },
                ),
                Positioned(
                  top: 150,
                  right: 5,
                  child: ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Change Profile'),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<Map<String, dynamic>>(
            future: profile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final data = snapshot.data!;
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Name: ${data['name']}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Email: ${data['email']}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone Number: ${data['phone_number']}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.card_membership),
                      title:
                          Text('Membership Type: ${data['membership_type']}'),
                    ),
                  ],
                );
              } else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ],
      ),
    );
  }
}
