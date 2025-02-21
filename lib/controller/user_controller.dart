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
import 'package:rider/models/review_model.dart';
import 'package:rider/models/ride_model.dart';
import 'package:rider/models/user_model.dart';
import 'package:rider/pages/auth/create_profile_screen.dart';
import 'package:rider/pages/auth/signup_screen.dart';
import 'package:rider/pages/auth/verify_phone_screen.dart';
import 'package:rider/pages/booking/review_screen.dart';
import 'package:rider/pages/booking/trip_payment_screen.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/pages/home/trip_details_screen.dart';
import 'package:rider/pages/home/trip_started_screen.dart';
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
  RxBool isScheduleFetched = false.obs;
  RxBool isPaymentHistoryFetched = false.obs;
  var driverLocation = const LatLng(59.9139, 10.7522).obs;
  Rxn<UserModel> userModel = Rxn<UserModel>();
  Rxn<Ride> currentRideModel = Rxn<Ride>();
  RxList<Ride> userScheduleList = <Ride>[].obs;
  RxList<Ride> rideHistoryList = <Ride>[].obs;
  RxList<PaymentModel> userPaymentList = <PaymentModel>[].obs;
  Rxn<FareBreakdownModel> rideFareBreakdownModel = Rxn<FareBreakdownModel>();
  RxBool isGetUserIdLoading = false.obs;
  final UserService _userService = UserService();
  RxList<DriverModel> availableDriverList = <DriverModel>[].obs;
  RxInt totalPages = 1.obs;
  RxInt currentPage = 1.obs;
  RxBool isFetchingMore = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  onInit() {
    getUserDetails();
    fetchRideHistory();
    getUserScheduledRides();
    super.onInit();
  }

  Future<void> loadMorePayments() async {
    if (isFetchingMore.value || currentPage.value >= totalPages.value) return;
    isFetchingMore.value = true;
    await getUserPaymentHistory(page: currentPage.value + 1);
    isFetchingMore.value = false;
  }

  Future<void> getUserStatus() async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;
      final response = await _userService.getUserStatus(token: token);
      if (response == null) {
        Get.offAll(() => SignUpScreen());
        return;
      }
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        Get.offAll(() => SignUpScreen());
        debugPrint(message);
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
      // Get.to(() => const HomeScreen());
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
      String message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      final rideFromResponse = decoded["data"]["ride"];
      print(rideFromResponse);
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

      if (message == "Token has expired.") {
        Get.offAll(() => SignUpScreen());
        return;
      }

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
      await fetchRideHistory();
      await getUserScheduledRides();
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

      await fetchRideHistory();
      await getUserScheduledRides();
      Get.to(() => const HomeScreen());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> makePayment({
    required String rideId,
    required Reviews reviews,
    required String driverUserId,
  }) async {
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
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(decoded["message"]);
        return;
      }

      String clientSecret = decoded["paymentResult"]["clientSecret"];
      await _presentStripePaymentSheet(
        clientSecret: clientSecret,
        reviews: reviews,
        driverUserId: driverUserId,
      );
      await fetchRideHistory();
      await getUserScheduledRides();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isPaymentProcessing.value = false;
    }
  }

  Future<void> _presentStripePaymentSheet({
    required String clientSecret,
    required Reviews reviews,
    required String driverUserId,
  }) async {
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
      getUserPaymentHistory();
      Get.offAll(
        () => ReviewScreen(
          reviews: reviews,
          driverUserId: driverUserId,
        ),
      );
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

  Future<void> getUserPaymentHistory({
    int page = 1,
    int limit = 10,
    String? status,
    String? startDate,
    String? endDate,
  }) async {
    if (isloading.value) return;
    isloading.value = true;

    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getUserPaymentHistory(
        token: token,
        page: page,
        limit: limit,
        status: status,
        startDate: startDate,
        endDate: endDate,
      );

      if (response == null) return;
      print(response.body);
      final decoded = json.decode(response.body);
      String message = decoded["message"];

      if (response.statusCode != 200) {
        debugPrint(message);
        return;
      }

      final payments = decoded["payments"] as List;
      final totalPages = decoded["totalPages"];
      final currentPage = decoded["page"];

      if (page == 1) {
        userPaymentList.clear();
      }

      userPaymentList.addAll(
          payments.map((payment) => PaymentModel.fromJson(payment)).toList());

      this.totalPages.value = totalPages;
      this.currentPage.value = currentPage;
      if (response.statusCode == 200) isPaymentHistoryFetched.value = true;
    } catch (e) {
      debugPrint("❌ Error fetching payments: $e");
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
      if (message == "Token has expired.") {
        Get.offAll(() => SignUpScreen());
        return;
      }
      if (response.statusCode != 200) {
        debugPrint(message);
        return;
      }

      final rides = decoded["data"]["rides"] as List;

      userScheduleList.clear();
      userScheduleList.value = rides.map((e) => Ride.fromJson(e)).toList();
      if (response.statusCode == 200) isScheduleFetched.value = true;
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
      if (response.statusCode != 201) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      CustomSnackbar.showSuccessSnackBar(message);
      getUserScheduledRides();
      await fetchRideHistory();

      Get.offAll(() => const HomeScreen());
    } catch (e, stackrace) {
      debugPrint("${e.toString()} $stackrace");
    } finally {
      isScheduleLoading.value = false;
    }
  }

  Future<void> fetchRideHistory({
    String? status,
  }) async {
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
      if (decoded["message"].toString() == "Token has expired.") {
        Get.offAll(() => SignUpScreen());
        return;
      }
      if (response.statusCode != 200) {
        debugPrint(decoded["message"].toString());
        return;
      }

      List rides = decoded["rides"];
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

  Future<void> getCurrentRide() async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getCurrentRide(token: token);
      if (response == null) {
        Get.offAll(() => const HomeScreen());
        return;
      }
      final decoded = json.decode(response.body);
      String message = decoded["message"];
      if (message == "Token has expired.") {
        Get.offAll(() => SignUpScreen());
        return;
      }

      if (response.statusCode != 200) {
        Get.offAll(() => const HomeScreen());
        debugPrint(message);
        return;
      }

      currentRideModel.value = Ride.fromJson(decoded["data"]);
      if (currentRideModel.value?.status == "pending") {
        String fromLoactionName =
            currentRideModel.value!.pickupLocation?.address ?? "";
        String toLoactionName =
            currentRideModel.value!.dropoffLocation?.address ?? "";
        Get.to(
          () => WaitingRideScreen(
            fromLoactionName: fromLoactionName,
            toLoactionName: toLoactionName,
          ),
        );
        return;
      } else if (currentRideModel.value?.status == "accepted") {
        Get.offAll(
          () => TripDetailsScreen(
            rideId: currentRideModel.value?.id ?? "",
            driverId: currentRideModel.value?.driverUserId ?? "",
          ),
        );
        return;
      } else if (currentRideModel.value?.status == "progress") {
        final fromLocation = LatLng(
          currentRideModel.value?.pickupLocation?.lat ?? 0.0,
          currentRideModel.value?.pickupLocation?.lng ?? 0.0,
        );
        final toLocation = LatLng(
          currentRideModel.value?.dropoffLocation?.lat ?? 0.0,
          currentRideModel.value?.dropoffLocation?.lng ?? 0.0,
        );
        Get.offAll(
          () => TripStartedScreen(
            fromLocation: fromLocation,
            toLocation: toLocation,
            rideId: currentRideModel.value?.id ?? "",
          ),
        );
        return;
      } else if (currentRideModel.value?.status == "completed") {
        Get.offAll(
          () => TripPaymentScreen(
            rideId: currentRideModel.value?.id ?? "",
            driverUserId: currentRideModel.value?.driverUserId ?? "",
            reviews: Reviews.fromJson(currentRideModel.value?.reviews),
          ),
        );
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> rateDriver({
    required String rating,
    required String rideId,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.rateDriver(
        rating: rating,
        rideId: rideId,
        token: token,
      );

      if (response == null) return;
      final data = json.decode(response.body);
      String message = data["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      Get.offAll(() => const HomeScreen());
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<DriverModel?> getDriverWithId({
    required String driverId,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return null;

      final response = await _userService.getDriverWithId(
        driverId: driverId,
        token: token,
      );

      if (response == null) return null;
      final data = json.decode(response.body);
      String message = data["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
        return null;
      }

      return DriverModel.fromJson(data["data"]["driver"]);
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      isloading.value = false;
    }
    return null;
  }

  void clearUserData() {
    userModel.value = null;
    currentRideModel.value = null;
    userScheduleList.clear();
    rideHistoryList.clear();
    userPaymentList.clear();
    rideFareBreakdownModel.value = null;
    availableDriverList.clear();
    driverLocation.value = const LatLng(59.9139, 10.7522);
  }
}
