import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/controllers/Apiservice.dart';
import 'package:membermanagementsystem/models/membership.dart';

class MembershipController extends GetxController {
  var memberships = <Membership>[].obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    fetchMemberships();
    super.onInit();
  }

  Future<void> fetchMemberships() async {
    try {
      var fetchedMemberships = await apiService.fetchMemberships();
      memberships.assignAll(
        fetchedMemberships.map((e) => Membership.fromJson(e)).toList(),
      );
    } catch (e) {
      print("Failed to load memberships: $e"); // Log the error for more info
      Get.snackbar(
        'Error',
        'Failed to load memberships: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
