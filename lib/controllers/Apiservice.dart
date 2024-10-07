import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/constants/constants.dart';

class ApiService {
  Future<List<dynamic>> fetchMemberships() async {
    final response = await http.get(Uri.parse(url + 'memberships'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load memberships');
    }
  }
}
