import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:membermanagementsystem/controllers/membershipcontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? fullName,
      email,
      address,
      phoneNumber,
      gender,
      currentPassword,
      newPassword;
  int? age, membership;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fullNameController.text = prefs.getString('userName') ?? '';
      _emailController.text = prefs.getString('userEmail') ?? '';
      membership = prefs.getInt('userMembership');
      _addressController.text = prefs.getString('userAddress') ?? '';
      _ageController.text = prefs.getString('userAge') ?? '';
      _phoneNumberController.text = prefs.getString('userPhoneNumber') ?? '';
      gender = prefs.getString('userGender') ?? 'male';
    });
  }

  Future<void> updateProfileAPI(
      String? fullName,
      String? email,
      String? address,
      String? phoneNumber,
      String? gender,
      int? age,
      int? membership,
      String? currentPassword,
      String? newPassword) async {
    final response = await http.post(
      Uri.parse(url + 'updateprofile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ', // Replace with your actual auth token
      },
      body: jsonEncode({
        'full_name': fullName,
        'email': email,
        'address': address,
        'phone_number': phoneNumber,
        'gender': gender,
        'age': age,
        'membership': membership,
        'current_password': currentPassword,
        'new_password': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await storeUserData(data['user']);
    } else {
      throw Exception('Failed to update profile');
    }
  }

  Future<void> storeUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userData['name'] ?? 'Unknown');
    await prefs.setString(
        'userEmail', userData['email'] ?? 'unknown@example.com');
    await prefs.setInt('userMembership', userData['membership'] ?? 0);
    await prefs.setString('userAddress', userData['address'] ?? 'N/A');
    await prefs.setString('userAge', userData['age']?.toString() ?? 'N/A');
    await prefs.setString('userPhoneNumber', userData['phone_number'] ?? 'N/A');
    await prefs.setString('userGender', userData['gender'] ?? 'N/A');
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Call the backend API to update the profile
      await updateProfileAPI(
        _fullNameController.text,
        _emailController.text,
        _addressController.text,
        _phoneNumberController.text,
        gender,
        int.tryParse(_ageController.text),
        membership!,
        _currentPasswordController.text,
        _newPasswordController.text,
      );
      // Update local storage
      await storeUserData({
        'name': _fullNameController.text,
        'email': _emailController.text,
        'membership': membership,
        'address': _addressController.text,
        'age': int.tryParse(_ageController.text),
        'phoneNumber': _phoneNumberController.text,
        'gender': gender,
      });
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF003049),
        title: Text('Update Profile', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextField('Full Name', _fullNameController),
              _buildTextField('Email', _emailController,
                  keyboardType: TextInputType.emailAddress),
              _buildTextField('Address', _addressController),
              _buildTextField('Phone Number', _phoneNumberController,
                  keyboardType: TextInputType.phone),
              _buildStringDropdownField('Gender', gender, ['male', 'female'],
                  (value) => setState(() => gender = value)),
              _buildTextField('Age', _ageController,
                  keyboardType: TextInputType.number),
              GetBuilder<MembershipController>(
                init: MembershipController(),
                builder: (controller) {
                  return _buildIntDropdownField(
                    'Membership',
                    membership,
                    controller.memberships.map((e) => e.id).toList(),
                    (value) => setState(() => membership = value),
                  );
                },
              ),
              _buildPasswordField(
                  'Current Password', _currentPasswordController),
              _buildPasswordField('New Password', _newPasswordController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF003049),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text('Update Profile',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildIntDropdownField(
      String label, int? value, List<int> items, ValueChanged<int?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<int>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: items.map((int item) {
          return DropdownMenuItem<int>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildStringDropdownField(String label, String? value,
      List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }
}
