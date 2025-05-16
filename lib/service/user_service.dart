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
      ).timeout(const Duration(seconds: 9));
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
          .put(Uri.parse('$baseUrl/user/ride/cancel-ride-request'),
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

  Future<http.Response?> initiateStripePayment({
    required String token,
    required String rideId,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse('$baseUrl/user/ride/payment'),
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

  Future<http.Response?> getRideFareBreakDown({
    required String token,
    required String rideId,
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/user/ride/get-fare-breakdown/$rideId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));
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

  Future<http.Response?> updateUserDetails({
    required String token,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    File? profilePicture,
  }) async {
    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('$baseUrl/user/update-user'),
      );

      // Set headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      if (firstName != null) request.fields['first_name'] = firstName;
      if (lastName != null) request.fields['last_name'] = lastName;
      if (email != null) request.fields['email'] = email;
      if (phoneNumber != null) request.fields['phone_number'] = phoneNumber;

      // Attach profile picture if provided
      if (profilePicture != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'profilePicture',
            profilePicture.path,
          ),
        );
      }

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

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

  Future<http.Response?> getRideHistories({
    required String token,
    String? status,
  }) async {
    try {
      Uri uri = Uri.parse("$baseUrl/user/ride-history").replace(
        queryParameters: {
          if (status != null && status.isNotEmpty) "status": status,
        },
      );

      final response = await client.get(
        uri,
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

  Future<http.Response?> getUserPaymentHistory({
    required String token,
    required int page,
    required int limit,
    String? status,
    String? startDate,
    String? endDate,
  }) async {
    try {
      String url = "$baseUrl/user/payment-history?page=$page&limit=$limit";
      if (status != null && status.isNotEmpty) {
        url += "&status=$status";
      }
      if (startDate != null && startDate.isNotEmpty) {
        url += "&startDate=$startDate";
      }
      if (endDate != null && endDate.isNotEmpty) {
        url += "&endDate=$endDate";
      }
      Uri uri = Uri.parse(url);
      final response = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
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

  Future<http.Response?> getUserScheduledRides({
    required String token,
    String? status,
  }) async {
    try {
      Uri uri = Uri.parse("$baseUrl/user/get-schedules").replace(
        queryParameters: {
          if (status != null && status.isNotEmpty) "status": status,
        },
      );
      final response = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
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

  Future<http.Response?> scheduleRide({
    required String token,
    required Map<String, dynamic> rideData,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/user/schedule"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(rideData),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint("❌ Error scheduling ride: $e");
    }
    return null;
  }

  Future<http.Response?> cancelScheduleRide({
    required String token,
    required String rideId,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/user/ride/user-cancel-schedule"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({"rideId": rideId}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint("❌ Error scheduling ride: $e");
    }
    return null;
  }

  Future<http.Response?> getCurrentRide({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/user/ride/get-current-ride"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint("❌ Error scheduling ride: $e");
    }
    return null;
  }

  Future<http.Response?> rateDriver({
    required String rating,
    required String rideId,
    required String token,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/user/rate-driver");
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "rating": rating,
          "rideId": rideId,
        }),
      );
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

  Future<http.Response?> getDriverWithId({
    required String driverId,
    required String token,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/user/get-driver-with-id/$driverId");
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
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

  Future<http.Response?> cancelledPayment({
    required String transactionId,
    required String token,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/user/ride/cancelled-payment/$transactionId");
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
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

}
