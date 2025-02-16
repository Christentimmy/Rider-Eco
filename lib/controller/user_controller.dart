import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/controller/storage_controller.dart';
import 'package:rider/pages/auth/create_profile_screen.dart';
import 'package:rider/pages/auth/signup_screen.dart';
import 'package:rider/pages/auth/verify_phone_screen.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/service/user_service.dart';
import 'package:rider/widgets/snack_bar.dart';

class UserController extends GetxController {
  final UserService _userService = UserService();

  Future<void> getUserStatus() async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;
      final response = await _userService.getUserStatus(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      String status = decoded["data"]["status"] ;
      String email = decoded["data"]["email"];
      bool isEmailVerified = decoded["data"]["is_email_verified"] ?? false;
      bool isProfileCompleted = decoded["data"]["profile_completed"] ?? false;
      bool isPhoneNumberVerified =
          decoded["data"]["is_phone_number_verified"] ?? false;
      if (status == "banned" || status == "blocked") {
        CustomSnackbar.showErrorSnackBar("Your account has been banned.");
        Get.offAll(() => SignUpScreen());
        return;
      }
      if (!isEmailVerified && !isPhoneNumberVerified) {
        CustomSnackbar.showErrorSnackBar("Your account email is not verified.");
        Get.offAll(() => VerifyPhoneNumberScreen(
            email: email,
            nextScreenMethod: () {
              Get.offAll(() => HomeScreen());
            }));
        return;
      }
      if (!isProfileCompleted) {
        CustomSnackbar.showErrorSnackBar("Your profile is not completed.");
        Get.offAll(() => CreateProfileScreen());
        return;
      }
      Get.to(() => HomeScreen());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
