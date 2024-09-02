import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import "package:membermanagementsystem/components/my_textfield.dart";
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:membermanagementsystem/constants/constants.dart';
import 'package:membermanagementsystem/controllers/authentication.dart';
import 'package:membermanagementsystem/pages/signup.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class Completeregister extends StatefulWidget {
  const Completeregister({super.key});

  @override
  State<Completeregister> createState() => _CompleteregisterState();
}

class _CompleteregisterState extends State<Completeregister> {
  final AuthenticationController authController = Get.find();

  final membershipTypeController = TextEditingController();
  final profilePictureController = TextEditingController();
  final placeOfBirthController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final genderController = TextEditingController();
  final fullAddressController = TextEditingController();
  final nationalityController = TextEditingController();
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final emailaddresscontroller = TextEditingController();
  final createpasswordcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final AuthenticationController authController1 =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;

    // Update the controller with the passed data
    authController.updateName(arguments['name']);
    authController.updatePhoneNumber(arguments['phone']);
    authController.updateEmail(arguments['email']);
    authController.updatePassword(arguments['password']);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signup()),
              );
            },
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
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
                      Icons.celebration_rounded,
                      size: 100,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'You are almost done!',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    Text(
                      'We need some information to complete your registration',
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                    SizedBox(height: 25),
                    // TextFormField(
                    //   initialValue: authController.registrationData.value.name,
                    //   decoration: InputDecoration(labelText: 'Name'),
                    // ),
                    // TextFormField(
                    //   initialValue:
                    //       authController.registrationData.value.phoneNumber,
                    //   decoration: InputDecoration(labelText: 'Phone Number'),
                    // ),
                    // TextFormField(
                    //   initialValue: authController.registrationData.value.email,
                    //   decoration: InputDecoration(labelText: 'Email Address'),
                    // ),
                    // TextFormField(
                    //   initialValue:
                    //       authController.registrationData.value.password,
                    //   decoration: InputDecoration(labelText: 'Password'),
                    //   obscureText: true,
                    // ),
                    SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) =>
                          authController.updatePlaceOfBirth(value),
                      decoration: InputDecoration(
                        labelText: 'Place of Birth',
                        hintText: 'Enter your place of birth',
                        hintStyle: TextStyle(color: Colors.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                        ),
                      ),
                      obscureText: false,
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: dateOfBirthController,
                      onChanged: (value) => authController.updateDob(value),
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        hintText: 'Enter your date of birth',
                        hintStyle: TextStyle(color: Colors.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today,
                              color: Colors.blueAccent),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              dateOfBirthController.text =
                                  formattedDate; // Set the text
                              authController.updateDob(
                                  formattedDate); // Update the controller
                            }
                          },
                        ),
                      ),
                      obscureText: false,
                    ),
                    SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value:
                          authController.registrationData.value.gender.isEmpty
                              ? null
                              : authController.registrationData.value.gender,
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        hintText: 'Select your gender',
                        hintStyle: TextStyle(color: Colors.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                        ),
                      ),
                      dropdownColor: Colors.white,
                      items: ['Male', 'Female'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        authController.updateGender(newValue!);
                      },
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blueAccent,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) =>
                          authController.updateFullAddress(value),
                      decoration: InputDecoration(
                        labelText: 'Full Address',
                        hintText: 'Enter your full address',
                        hintStyle: TextStyle(color: Colors.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                        ),
                      ),
                      obscureText: false,
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) =>
                          authController.updateNationality(value),
                      decoration: InputDecoration(
                        labelText: 'Nationality',
                        hintText: 'Enter your nationality',
                        hintStyle: TextStyle(color: Colors.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                        ),
                      ),
                      obscureText: false,
                    ),
                    SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: authController
                              .registrationData.value.membershipType.isEmpty
                          ? null
                          : authController
                              .registrationData.value.membershipType,
                      decoration: InputDecoration(
                        labelText: 'Membership Type',
                        hintText: 'Select your membership type',
                        hintStyle: TextStyle(color: Colors.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                        ),
                      ),
                      dropdownColor: Colors.white,
                      items: [
                        DropdownMenuItem<String>(
                          value: 'Regular',
                          child: Row(
                            children: [
                              Icon(Icons.star_border, color: Colors.grey),
                              SizedBox(width: 10),
                              Text('Regular',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Gold',
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              SizedBox(width: 10),
                              Text('Gold',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Platinum',
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.blueGrey),
                              SizedBox(width: 10),
                              Text('Platinum',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (newValue) {
                        authController.updateMembershipType(newValue!);
                      },
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blueAccent,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () async {
                        print('Complete Registration button pressed');

                        // Show loading indicator
                        authController1.isLoading.value = true;

                        try {
                          await authController1.signup(
                            email: authController1.registrationData.value.email,
                            password:
                                authController1.registrationData.value.password,
                            name: authController1.registrationData.value.name,
                            full_address: authController1
                                .registrationData.value.fullAddress,
                            place_of_birth: authController1
                                .registrationData.value.placeOfBirth,
                            dob: authController1.registrationData.value.dob,
                            nationality: authController1
                                .registrationData.value.nationality,
                            gender:
                                authController1.registrationData.value.gender,
                            phone_number: authController1
                                .registrationData.value.phoneNumber,
                            membership_type: authController1
                                .registrationData.value.membershipType,
                          );
                          print('message' 'Registration successful');
                          // Navigate to the login page after successful registration
                          Navigator.pushReplacementNamed(context, '/Login');
                        } catch (e) {
                          print('Registration error: $e');
                        } finally {
                          authController1.isLoading.value = false;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(25),
                        backgroundColor: Colors.blue,
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
                                "Complete Registration",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              );
                      }),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
