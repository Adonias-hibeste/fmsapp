import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:membermanagementsystem/constants/constants.dart';

class EventController extends GetxController {
  var events = [].obs;
  var selectedEvent = ''.obs;
  var name = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  void fetchEvents() async {
    final response = await http.get(Uri.parse(url + 'eventsapp'));
    if (response.statusCode == 200) {
      events.value = json.decode(response.body);
    } else {
      Get.snackbar('Error', 'Failed to load events',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void registerUser() async {
    final response = await http.post(
      Uri.parse(url + 'registereventsapp'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name.value,
        'email': email.value,
        'phone': phone.value,
        'event_id': selectedEvent.value,
      }),
    );
    if (response.statusCode == 201) {
      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offNamed('/Events'); // Navigate to the events page
    } else {
      Get.snackbar('Error', 'Registration failed',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
