import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rider/utils/base_url.dart';
import 'package:rider/widgets/snack_bar.dart';

class UserService {
  http.Client client = http.Client();

  Future<http.Response?> getUserStatus({
    required String token,
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/user/user-status'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getNearByDrivers({
    required String token,
    required LatLng fromLocation,
    int? radius,
  }) async {
    try {
      var url =
          "$baseUrl/user/get-nearby-drivers?longitude=${fromLocation.longitude}&latitude=${fromLocation.latitude}";
      if (radius != null && radius != 0) {
        url += "&radius=$radius";
      }
      print(url);
      final response = await client.get(
        Uri.parse(url),
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
    return null;
  }

  Future<http.Response?> getUserById({
    required String token,
    required String userId,
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/user/get-user-with-id/$userId'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ).timeout(const Duration(seconds: 15));
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

  Future<http.Response?> requestRide({
    required String token,
    required String driverId,
    required LatLng fromLocation,
    required String fromLocationName,
    required LatLng toLocation,
    required String toLocationName,
    required String paymentMethod,
  }) async {
    print(driverId);
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/user/ride/request-ride'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "driverId": driverId,
            "pickup_location": {
              "lng": fromLocation.longitude,
              "lat": fromLocation.latitude,
              "address": fromLocationName,
            },
            "dropoff_location": {
              "lat": toLocation.latitude,
              "lng": toLocation.longitude,
              "address": toLocationName,
            },
            "payment_method": paymentMethod.toLowerCase(),
          },
        ),
      );
      print(response.body);
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

  Future<http.Response?> getUserDetails({required String token}) async {
    try {
      final response = await client.get(
        Uri.parse("$baseUrl/user/get-user-details"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ).timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> saveUserOneSignalId({
    required String token,
    required String id,
  }) async {
    try {
      final response = await client.post(
        Uri.parse("$baseUrl/user/save-signal-id/$id"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ).timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> cancelRideRequest({
    required String token,
    required String rideId,
  }) async {
    try {
      final response = await client
          .post(Uri.parse('$baseUrl/user/ride/cancel-ride-request'),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
              body: json.encode({'rideId': rideId}))
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> cancelTrip({
    required String token,
    required String rideId,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse('$baseUrl/user/ride/cancel-trip'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'rideId': rideId}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection: $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }


}
