import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/controller/storage_controller.dart';
import 'package:rider/models/driver_model.dart';
import 'package:rider/models/fare_breakdown_model.dart';
import 'package:rider/models/payment_model.dart';
import 'package:rider/models/ride_model.dart';
import 'package:rider/models/user_model.dart';
import 'package:rider/pages/auth/create_profile_screen.dart';
import 'package:rider/pages/auth/signup_screen.dart';
import 'package:rider/pages/auth/verify_phone_screen.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/pages/home/waiting_ride_screen.dart';
import 'package:rider/service/user_service.dart';
import 'package:rider/widgets/snack_bar.dart';

class UserController extends GetxController {
  RxBool isloading = false.obs;
  RxBool isScheduleLoading = false.obs;
  RxBool isRideHistoryFetched = false.obs;
  RxBool isRideBreakDownLoading = false.obs;
  RxBool isRequestRideLoading = false.obs;
  RxBool isPaymentProcessing = false.obs;
  RxBool isEditLoading = false.obs;
  var driverLocation = const LatLng(0.0, 0.0).obs;
  Rxn<UserModel> userModel = Rxn<UserModel>();
  Rxn<Ride> currentRideModel = Rxn<Ride>();
  RxList<Ride> userScheduleList = <Ride>[].obs;
  RxList<Ride> rideHistoryList = <Ride>[].obs;
  RxList<PaymentModel> userPaymentList = <PaymentModel>[].obs;
  Rxn<FareBreakdownModel> rideFareBreakdownModel = Rxn<FareBreakdownModel>();
  RxBool isGetUserIdLoading = false.obs;
  final UserService _userService = UserService();
  RxList<DriverModel> availableDriverList = <DriverModel>[].obs;

  @override
  onInit() {
    getUserDetails();
    fetchRideHistory();
    super.onInit();
  }

  Future<void> getUserStatus() async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;
      final response = await _userService.getUserStatus(token: token);
      if (response == null) {
        Get.to(() => SignUpScreen());
        return;
      }
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      String status = decoded["data"]["status"];
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
              Get.offAll(() => const HomeScreen());
            }));
        return;
      }
      if (!isProfileCompleted) {
        CustomSnackbar.showErrorSnackBar("Your profile is not completed.");
        Get.offAll(() => CreateProfileScreen());
        return;
      }
      Get.to(() => const HomeScreen());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getNearByDrivers({
    required LatLng fromLocation,
    int? radius,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;
      final response = await _userService.getNearByDrivers(
        token: token,
        fromLocation: fromLocation,
        radius: radius,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      List driversFromResponse = decoded["data"];
      if (driversFromResponse.isEmpty) return;
      List<DriverModel> driverModelList =
          driversFromResponse.map((e) => DriverModel.fromJson(e)).toList();
      availableDriverList.value = driverModelList;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<UserModel?> getUserById({
    required String userId,
  }) async {
    isGetUserIdLoading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return null;

      final response = await _userService.getUserById(
        token: token,
        userId: userId,
      );

      if (response == null) return null;
      print(response.body);
      final decoded = json.decode(response.body);
      String message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return null;
      }
      var userData = decoded["data"];
      return UserModel.fromJson(userData);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGetUserIdLoading.value = false;
    }
    return null;
  }

  Future<void> requestRide({
    required String driverId,
    required LatLng fromLocation,
    required String fromLocationName,
    required LatLng toLocation,
    required String toLocationName,
    required String paymentMethod,
  }) async {
    isRequestRideLoading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;
      final response = await _userService.requestRide(
        token: token,
        driverId: driverId,
        fromLocation: fromLocation,
        fromLocationName: fromLocationName,
        toLocation: toLocation,
        toLocationName: toLocationName,
        paymentMethod: paymentMethod,
      );

      if (response == null) return;
      final decoded = json.decode(response.body);
      print(decoded);
      String message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      final rideFromResponse = decoded["data"]["ride"];
      currentRideModel.value = null;
      currentRideModel.value = Ride.fromJson(rideFromResponse);
      print(currentRideModel.value?.id);
      CustomSnackbar.showSuccessSnackBar("Request sent successfully.");
      Get.off(
        () => WaitingRideScreen(
          fromLoactionName: fromLocationName,
          toLoactionName: toLocationName,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isRequestRideLoading.value = false;
    }
  }

  Future<void> getUserDetails() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getUserDetails(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"];

      if (response.statusCode != 200) {
        debugPrint(message);
        return;
      }

      var userData = decoded["data"];
      userModel.value = UserModel.fromJson(userData);
      userModel.refresh();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> saveUserOneSignalId({
    required String oneSignalId,
  }) async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;
      final response = await _userService.saveUserOneSignalId(
        token: token,
        id: oneSignalId,
      );
      if (response == null) return;
      print(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> cancelRideRequest({
    required String rideId,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.cancelRideRequest(
        token: token,
        rideId: rideId,
      );

      if (response == null) return;
      print(response.body);
      final decoded = json.decode(response.body);
      String message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> cancelTrip({required String rideId}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.cancelTrip(
        token: token,
        rideId: rideId,
      );

      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"];

      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }

      Get.to(() => const HomeScreen());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> makePayment({required String rideId}) async {
    isPaymentProcessing.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        CustomSnackbar.showErrorSnackBar("Authentication required");
        return;
      }

      final response = await _userService.initiateStripePayment(
        token: token,
        rideId: rideId,
      );

      if (response == null) return;
      final decoded = json.decode(response.body);
      print(decoded);
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(decoded["message"]);
        return;
      }

      String clientSecret = decoded["paymentResult"]["clientSecret"];
      print(clientSecret);
      await _presentStripePaymentSheet(clientSecret);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isPaymentProcessing.value = false;
    }
  }

  Future<void> _presentStripePaymentSheet(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          style: ThemeMode.dark,
          merchantDisplayName: 'SIM',
        ),
      );
      await Stripe.instance.presentPaymentSheet();

      CustomSnackbar.showSuccessSnackBar("Payment processing!");
      currentRideModel.value = null;
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      print(e);
      debugPrint("Stripe Payment Error: $e");
      CustomSnackbar.showErrorSnackBar("Payment failed");
    }
  }

  Future<void> getRideFareBreakDown({
    required String rideId,
  }) async {
    isRideBreakDownLoading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getRideFareBreakDown(
        token: token,
        rideId: rideId,
      );

      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      final rideFareBreakdown = decoded["breakdown"];
      if (rideFareBreakdown == null) return;
      rideFareBreakdownModel.value = FareBreakdownModel.fromMap(
        rideFareBreakdown,
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isRideBreakDownLoading.value = false;
    }
  }

  Future<void> updateUserDetails({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    File? profilePicture,
  }) async {
    isEditLoading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.updateUserDetails(
        token: token,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        profilePicture: profilePicture,
      );

      if (response == null) return;

      final decoded = json.decode(response.body);
      String message = decoded["message"];

      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }

      CustomSnackbar.showSuccessSnackBar("Profile updated successfully");
      getUserDetails();
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isEditLoading.value = false;
    }
  }

  Future<void> fetchRideHistory({String? status}) async {
    isloading.value = false;
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getRideHistories(
        token: token,
        status: status,
      );

      if (response == null) return;
      final decoded = json.decode(response.body);
      if (response.statusCode != 200) {
        return;
      }

      List rides = decoded["rides"];
      print(rides);
      List<Ride> mappedList = rides.map((e) => Ride.fromJson(e)).toList();
      rideHistoryList.clear();
      rideHistoryList.value = mappedList;
      if (response.statusCode == 200) isRideHistoryFetched.value = true;
    } catch (e) {
      debugPrint("Error fetching ride history: $e");
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getUserPaymentHistory({int page = 1, int limit = 10}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getUserPaymentHistory(
        token: token,
        page: page,
        limit: limit,
      );

      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"];

      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }

      final payments = decoded["payments"] as List;
      userPaymentList.clear();
      userPaymentList.value =
          payments.map((payment) => PaymentModel.fromJson(payment)).toList();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getUserScheduledRides({String? status}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getUserScheduledRides(
        token: token,
        status: status,
      );

      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"];

      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }

      final rides = decoded["data"]["rides"] as List;

      userScheduleList.clear();
      userScheduleList.value = rides.map((e) => Ride.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> scheduleRide({
    required Map<String, dynamic> rideData,
  }) async {
    isScheduleLoading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.scheduleRide(
        token: token,
        rideData: rideData,
      );

      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      Get.offAll(() => const HomeScreen());
    } catch (e, stackrace) {
      debugPrint("${e.toString()} $stackrace");
    } finally {
      isScheduleLoading.value = false;
    }
  }
}
