import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rider/models/user_model.dart';
import 'package:rider/utils/base_url.dart';
import 'package:rider/widgets/snack_bar.dart';

class AuthService {
  http.Client client = http.Client();

  Future<http.Response?> signUpUser({required UserModel userModel}) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/auth/register"),
            body: userModel.toJson(),
          )
          .timeout(const Duration(seconds: 15));

      return response;
    } on SocketException catch (e) {
      CustomSnackbar.showErrorSnackBar("Check internet connection");
      debugPrint("SocketException: $e");
    } on TimeoutException {
      CustomSnackbar.showErrorSnackBar(
        "Request timeout, probably Bad network, try again",
      );
      debugPrint("Request Time out");
    } catch (e) {
      debugPrint("Error From Auth Servie: ${e.toString()}");
    }
    return null;
  }

  Future<http.Response?> loginUser({
    required String identifier,
    required String password,
  }) async {
    try {
      http.Response response = await client.post(
        Uri.parse("$baseUrl/auth/login"),
        body: {
          "identifier": identifier,
          "password": password,
        },
      ).timeout(const Duration(seconds: 15));

      return response;
    } on SocketException catch (e) {
      CustomSnackbar.showErrorSnackBar("Check internet connection, $e");
      debugPrint("No internet connection");
      return null;
    } on TimeoutException {
      CustomSnackbar.showErrorSnackBar(
        "Request timeout, probably bad network, try again",
      );
      debugPrint("Request timeout");
      return null;
    } catch (e) {
      throw Exception("Unexpected error $e");
    }
  }

  Future<http.Response?> verifyOtp({
    required String otpCode,
    required String token,
    String? email,
    String? phoneNumber,
  }) async {
    try {
      final Map<String, String> body = {
        "otp": otpCode,
      };

      if (email?.isNotEmpty == true) {
        body["email"] = email!;
      }

      if (phoneNumber?.isNotEmpty == true) {
        body["phone_number"] = phoneNumber!;
      }

      final response = await client
          .post(
            Uri.parse("$baseUrl/auth/verify-otp"),
            headers: {"Authorization": "Bearer $token"},
            body: body,
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<http.Response?> sendOtp({required String token}) async {
    try {
      final response = await client.post(
        Uri.parse("$baseUrl/auth/send-otp"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      ).timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.StreamedResponse?> completeProfile({
    required UserModel userModel,
    required String token,
    required File imageFile,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/auth/complete-profile");

      var request = http.MultipartRequest('PUT', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..fields['first_name'] = userModel.firstName!
        ..fields['last_name'] = userModel.lastName!
        ..fields['dob'] = userModel.dob!
        ..fields['address'] = userModel.address!
        ..files.add(
          await http.MultipartFile.fromPath(
            'avater',
            imageFile.path,
          ),
        );

      var response = await request.send().timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
