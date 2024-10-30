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
  bool canChangeMembership = true; // Flag to track membership change permission

  @override
  void initState() {
    super.initState();
    membershipController.fetchMemberships(); // Fetch memberships
    profileController.fetchProfileData(widget.userId); // Fetch profile data
    profileController.fetchMembershipEndDate(widget.userId).then((_) {
      checkMembershipChangeEligibility(); // Check if the user can change membership
    });
  }

  // Method to check if the user can change the membership
  void checkMembershipChangeEligibility() {
    String endDateString = profileController.membershipEndDate.value;
    if (endDateString.isNotEmpty) {
      DateTime membershipEndDate = DateTime.parse(endDateString);
      DateTime now = DateTime.now();

      // Check if less than 30 days have passed since the end of membership
      if (now.isBefore(membershipEndDate.add(Duration(days: 30)))) {
        setState(() {
          canChangeMembership = false; // Disable membership change
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text('Update Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Obx(() {
        // Check if the profile data is loading
        if (profileController.isLoading.value ||
            membershipController.memberships.isEmpty) {
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
                  onChanged: canChangeMembership
                      ? (newValue) {
                          setState(() {
                            selectedMembership = newValue;
                          });
                        }
                      : null, // Disable if the user cannot change the membership
                  decoration: InputDecoration(
                    labelText: 'Membership',
                    helperText: canChangeMembership
                        ? 'Select your membership'
                        : 'You cannot change membership before 30 days',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade800,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () async {
                    // Logic for updating the profile
                    String email = emailController.text.trim();
                    String fullName = fullNameController.text.trim();
                    String address = addressController.text.trim();
                    String age = ageController.text.trim();
                    String gender = selectedGender ?? '';
                    String phoneNumber = phoneNumberController.text.trim();
                    String membership = selectedMembership ?? '';

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
                  child: Text(
                    'Update Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
