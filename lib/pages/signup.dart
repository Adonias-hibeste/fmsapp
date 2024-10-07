import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/components/my_textfield.dart';
import 'package:membermanagementsystem/controllers/authentication.dart';
import 'package:membermanagementsystem/controllers/Apiservice.dart';
import 'package:membermanagementsystem/controllers/membershipcontroller.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final full_nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final addressController = TextEditingController();
  final AuthenticationController authController1 =
      Get.put(AuthenticationController());
  final MembershipController membershipController =
      Get.put(MembershipController());

  String? selectedMembership;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    membershipController.fetchMemberships();
  }

  void navigateToLogin() {
    Navigator.pushNamed(context, '/Login');
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Complete Registration button pressed');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        SizedBox(height: 50),
                        Icon(
                          Icons.app_registration,
                          size: 70,
                          color: Color(0xFF003049),
                        ),
                        SizedBox(height: 50),
                        Text(
                          'Create your Account',
                          style: TextStyle(
                            color: Color(0xFF003049),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 35),
                        Column(children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: full_nameController,
                                  onChanged: (value) =>
                                      authController1.updateName(value),
                                  decoration: InputDecoration(
                                    labelText: 'full_Name',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xFF003049),
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF003049),
                                    ),
                                  ),
                                  obscureText: false,
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  controller: phoneController,
                                  onChanged: (value) =>
                                      authController1.updatePhoneNumber(value),
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xFF003049),
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF003049),
                                    ),
                                  ),
                                  obscureText: false,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: ageController,
                                  onChanged: (value) =>
                                      authController1.updateAge(value),
                                  decoration: InputDecoration(
                                    labelText: 'Age',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xFF003049),
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF003049),
                                    ),
                                  ),
                                  obscureText: false,
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  controller: addressController,
                                  onChanged: (value) =>
                                      authController1.updateAddress(value),
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xFF003049),
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF003049),
                                    ),
                                  ),
                                  obscureText: false,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: authController1
                                          .registrationData.value.gender.isEmpty
                                      ? null
                                      : authController1
                                          .registrationData.value.gender,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      authController1.updateGender(newValue!);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Gender',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xFF003049),
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF003049),
                                    ),
                                  ),
                                  items: ['male', 'female']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Obx(() {
                                  // Ensure the membership list is not empty
                                  if (membershipController
                                      .memberships.isEmpty) {
                                    return CircularProgressIndicator(); // or any other placeholder
                                  }

                                  // Ensure the initial value is valid
                                  String? selectedMembership = authController1
                                      .registrationData.value.membership;
                                  if (selectedMembership != null &&
                                      !membershipController.memberships.any(
                                          (membership) =>
                                              membership.id.toString() ==
                                              selectedMembership)) {
                                    selectedMembership =
                                        null; // Reset if the initial value is not valid
                                  }

                                  return DropdownButtonFormField<String>(
                                    value: selectedMembership,
                                    onChanged: (String? newValue) {
                                      print(
                                          'Selected Membership ID: $newValue'); // Debug print
                                      authController1
                                          .updateMembership(newValue!);
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Membership Type',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Color(0xFF003049),
                                          width: 2,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      labelStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF003049),
                                      ),
                                    ),
                                    items: membershipController.memberships
                                        .map((membership) {
                                      return DropdownMenuItem<String>(
                                        value: membership.id.toString(),
                                        child: Text(membership.name),
                                      );
                                    }).toList(),
                                  );
                                }),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: emailController,
                            onChanged: (value) =>
                                authController1.updateEmail(value),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xFF003049),
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF003049),
                              ),
                            ),
                            obscureText: false,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            onChanged: (value) =>
                                authController1.updatePassword(value),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xFF003049),
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF003049),
                              ),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              print('Complete Registration button pressed');

                              // Show loading indicator
                              authController1.isLoading.value = true;

                              try {
                                // Debug print to verify registration data
                                print(
                                    'Registration Data: ${authController1.registrationData.value}');

                                await authController1.signup(
                                  email: authController1
                                      .registrationData.value.email,
                                  password: authController1
                                      .registrationData.value.password,
                                  full_name: authController1
                                      .registrationData.value.full_name,
                                  address: authController1
                                      .registrationData.value.address,
                                  age: authController1
                                      .registrationData.value.age,
                                  gender: authController1
                                      .registrationData.value.gender,
                                  phone_number: authController1
                                      .registrationData.value.phoneNumber,
                                  membership: authController1
                                      .registrationData.value.membership,
                                );
                              } catch (e) {
                                print('Registration error: $e');
                              } finally {
                                authController1.isLoading.value = false;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(25),
                              backgroundColor: Color(0xFF003049),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: Size(double.infinity, 60),
                            ),
                            child: Obx(() {
                              return authController1.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    )
                                  : Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    );
                            }),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                  color: Color(0xFF003049),
                                ),
                              ),
                              SizedBox(width: 7),
                              GestureDetector(
                                onTap: navigateToLogin,
                                child: Text(
                                  'Log in Here',
                                  style: TextStyle(
                                    color: Colors.blueGrey.shade500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ])))),
        ));
  }
}
