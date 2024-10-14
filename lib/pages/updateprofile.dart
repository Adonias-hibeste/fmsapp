import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/controllers/membershipcontroller.dart';
import 'package:membermanagementsystem/controllers/updateprofilecontroller.dart';

class UpdateProfilePage extends StatefulWidget {
  final String userId;

  UpdateProfilePage({required this.userId});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final ProfileController profileController = Get.put(ProfileController());
  final MembershipController membershipController = Get.find();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String? selectedGender;
  String? selectedMembership;

  @override
  void initState() {
    super.initState();
    membershipController.fetchMemberships(); // Fetch memberships here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        // Check if the memberships are loaded
        if (membershipController.memberships.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        final membershipItems =
            membershipController.memberships.map((membership) {
          return DropdownMenuItem<String>(
            value: membership.id.toString(),
            child: Text(membership.name),
          );
        }).toList();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  items: ['male', 'female'].map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedMembership,
                  items: membershipItems,
                  onChanged: (newValue) {
                    setState(() {
                      selectedMembership = newValue;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Membership'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String fullName = fullNameController.text.trim();
                    String address = addressController.text.trim();
                    String age = ageController.text.trim();
                    String gender = selectedGender ?? '';
                    String phoneNumber = phoneNumberController.text.trim();
                    String membership = selectedMembership ?? '';

                    // Debugging statements
                    print('Updating profile for User ID: ${widget.userId}');
                    print('Data being updated:');
                    print('Email: $email');
                    print('Full Name: $fullName');
                    print('Address: $address');
                    print('Age: $age');
                    print('Gender: $gender');
                    print('Phone Number: $phoneNumber');
                    print('Membership ID: $membership');

                    await profileController.updateProfile(
                      userId: widget.userId,
                      email: email,
                      full_name: fullName,
                      address: address,
                      age: age,
                      gender: gender,
                      phone_number: phoneNumber,
                      membership: membership,
                    );
                    Get.offAllNamed('/Login');
                  },
                  child: Text('Update Profile'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
