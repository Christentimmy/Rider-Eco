import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rider/utils/base_url.dart';
import 'package:rider/widgets/snack_bar.dart';

class UserService {
  http.Client client = http.Client();

  Future<http.Response?> getUserStatus({
    required String token,
  }) async {
    try {
      final response =
          await client.get(Uri.parse('$baseUrl/user/user-status'), headers: {
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      CustomSnackbar.showErrorSnackBar("Check internet connection, $e");
      debugPrint("No internet connection");
    } on TimeoutException {
      CustomSnackbar.showErrorSnackBar(
        "Request timeout, probably bad network, try again",
      );
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getNearByDrivers({
    required String token,
    required double lat,
    required double lng,
    int? radius,
  }) async {
    try {
      final response = await client.get(
        Uri.parse("$baseUrl/user/get-nearby-drivers?latitude=$lat&longitude=$lng&radius=$radius"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      return response;
    } on SocketException catch (e) {
      CustomSnackbar.showErrorSnackBar("Check internet connection, $e");
      debugPrint("No internet connection");
    } on TimeoutException {
      CustomSnackbar.showErrorSnackBar(
        "Request timeout, probably bad network, try again",
      );
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
