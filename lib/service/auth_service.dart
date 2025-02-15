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
            headers: {"Accept": "application/json"},
            body: userModel.toJson(),
          )
          .timeout(const Duration(seconds: 15));

      return response;
    } on SocketException catch (e) {
      CustomSnackbar.showErrorSnackBar("Check internet connection, $e");
      debugPrint("No internet connection");
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
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await client.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Accept": "application/json"},
        body: {
          "email": email,
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
        "Request timeout, probably Bad network, try again",
      );
      debugPrint("Request Time out");
      return null;
    } catch (e) {
      throw Exception("unexpected error $e");
    }
  }

}
