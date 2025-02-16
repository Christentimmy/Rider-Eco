import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/controller/storage_controller.dart';
import 'package:rider/models/user_model.dart';
import 'package:rider/pages/auth/create_profile_screen.dart';
import 'package:rider/pages/auth/verify_phone_screen.dart';
import 'package:rider/pages/bottom_navigation_screen.dart';
import 'package:rider/service/auth_service.dart';
import 'package:rider/utils/url_launcher.dart';
import 'package:rider/widgets/snack_bar.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final AuthService _authService = AuthService();
  final _storageController = Get.find<StorageController>();

  Future<void> signUpUSer({required UserModel userModel}) async {
    isLoading.value = true;

    try {
      final response = await _authService.signUpUser(userModel: userModel);
      if (response == null) return;
      print(response.body);
      final decoded = json.decode(response.body);
      var message = decoded["message"] ?? "";
      if (response.statusCode != 201) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      String token = decoded["token"];
      await _storageController.storeToken(token);
      String url = decoded["onboardingLink"] ?? "";
      if (url.isNotEmpty) {
        await launchStripeOnboarding(url);
      }

      Get.to(() => VerifyPhoneNumberScreen(email: userModel.email));
    } catch (e) {
      debugPrint("Error From Auth Controller: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendOtp() async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null) return;
      final response = await _authService.sendOtp(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(
            "Failed to get OTP, ${decoded["message"]}");
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> verifyOtp({
    required String otpCode,
    required String email,
  }) async {
    isLoading.value = true;
    try {
      Stopwatch stopwatch = Stopwatch()..start();
      String? token = await _storageController.getToken();
      if (token == null) return;
      final response = await _authService.verifyOtp(
        otpCode: otpCode,
        token: token,
        email: email,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      stopwatch.stop();
      debugPrint("Time execution: ${stopwatch.elapsed}");
      Get.offAll(() => CreateProfileScreen());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> completeProfileScreen({
    required UserModel userModel,
    required File imageFile,
  }) async {
    isLoading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;
      final response = await _authService.completeProfile(
        userModel: userModel,
        token: token,
        imageFile: imageFile,
      );
      if (response == null) return;
      final responseBody = await response.stream.bytesToString();
      final decoded = json.decode(responseBody);

      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      Get.offAll(() => BottomNavigationScreen());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
