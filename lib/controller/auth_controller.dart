import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/controller/storage_controller.dart';
import 'package:rider/models/user_model.dart';
import 'package:rider/service/auth_service.dart';
import 'package:rider/utils/token_decrypt.dart';
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
      print(response);
      final decoded = json.decode(response.body);
      var message = decoded["message"] ?? "";
      var encryptedToken = decoded["otp"] ?? "";
      String? decryptedToken = await decryptOtp(encryptedToken);
      if (decryptedToken == null) {
        CustomSnackbar.showErrorSnackBar("Failed to decrypt OTP");
        return;
      }
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      String token = decoded["token"];
      await _storageController.storeToken(token);
     
    } catch (e) {
      debugPrint("Error From Auth Controller: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
