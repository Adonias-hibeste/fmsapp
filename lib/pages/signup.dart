import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/controllers/authentication.dart';
import 'package:membermanagementsystem/controllers/membershipcontroller.dart';
import 'package:membermanagementsystem/models/membership.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> storeMembershipDetails(String name, double? price) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('membershipName', name);
    await prefs.setString('membershipPrice',
        price?.toString() ?? '0'); // Use '0' if price is null
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F5F5), // Background color set to #F5F5F5
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 55),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Join Our Club Here !',
                            textStyle: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Colors
                                  .green.shade800, // Color for welcome text
                            ),
                            speed: const Duration(
                                milliseconds: 200), // Slower writing speed
                          ),
                        ],
                        repeatForever: true, // Repeat indefinitely
                        pause: const Duration(
                            milliseconds: 500), // Pause after each animation
                      ),
                      SizedBox(height: 48),
                      Column(
                        children: [
                          // Full Name Field
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: full_nameController,
                              onChanged: (value) {
                                authController1
                                        .registrationData.value.full_name =
                                    value; // Update registrationData
                              },
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                hintText: 'Enter your full name',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              style: TextStyle(color: Colors.green.shade800),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Email Field
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: emailController,
                              onChanged: (value) {
                                authController1.registrationData.value.email =
                                    value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              style: TextStyle(color: Colors.green.shade800),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Phone Number Field
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: phoneController,
                              onChanged: (value) {
                                authController1
                                    .registrationData.value.phoneNumber = value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                hintText: 'Enter your phone number',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              style: TextStyle(color: Colors.green.shade800),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Password Field
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              onChanged: (value) {
                                authController1
                                    .registrationData.value.password = value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              style: TextStyle(color: Colors.green.shade800),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Age Field
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: ageController,
                              onChanged: (value) {
                                authController1.registrationData.value.age =
                                    value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Age',
                                hintText: 'Enter your age',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              style: TextStyle(color: Colors.green.shade800),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Address Field
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: addressController,
                              onChanged: (value) {
                                authController1.registrationData.value.address =
                                    value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Address',
                                hintText: 'Enter your address',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              style: TextStyle(color: Colors.green.shade800),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Gender Dropdown
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
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
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              items: [
                                'male',
                                'female'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(
                                          color: Colors
                                              .green.shade800)), // Green text
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Membership Type Dropdown
                          Obx(() {
                            if (membershipController.memberships.isEmpty) {
                              return CircularProgressIndicator(); // or any other placeholder
                            }

                            String? selectedMembership = authController1
                                .registrationData.value.membership;
                            if (!membershipController.memberships.any(
                                (membership) =>
                                    membership.id.toString() ==
                                    selectedMembership)) {
                              selectedMembership = membershipController
                                  .memberships.first.id
                                  .toString();
                            }

                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField<String>(
                                value: selectedMembership,
                                onChanged: (String? newValue) async {
                                  setState(() {
                                    authController1.updateMembership(newValue!);
                                  });

                                  // Find the selected membership in the list
                                  try {
                                    Membership selectedMembership =
                                        membershipController.memberships
                                            .firstWhere(
                                      (membership) =>
                                          membership.id.toString() == newValue,
                                    );

                                    // Store the membership details if found
                                    await storeMembershipDetails(
                                        selectedMembership.name,
                                        selectedMembership.price);
                                  } catch (e) {
                                    print("Selected membership not found: $e");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Selected membership not found.')),
                                    );
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Membership Type',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green.shade800,
                                  ),
                                ),
                                items: membershipController.memberships
                                    .map<DropdownMenuItem<String>>(
                                        (Membership membership) {
                                  return DropdownMenuItem<String>(
                                    value: membership.id.toString(),
                                    child: Text(membership.name,
                                        style: TextStyle(
                                            color: Colors
                                                .green.shade800)), // Green text
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                          SizedBox(height: 40),
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
                              padding: EdgeInsets.all(15),
                              backgroundColor: Colors.green.shade800,
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
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(width: 7),
                              GestureDetector(
                                onTap: navigateToLogin,
                                child: Text(
                                  'Log in Here',
                                  style: TextStyle(
                                    color: Colors.green.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
