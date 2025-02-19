import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/models/review_model.dart';
import 'package:rider/models/user_model.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:rider/widgets/loader.dart';

class ReviewScreen extends StatefulWidget {
  final Reviews reviews;
  final String driverUserId;
  const ReviewScreen({
    super.key,
    required this.reviews,
    required this.driverUserId,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final RxDouble _value = 3.5.obs;
  final _userController = Get.find<UserController>();
  final _driverUserModel = UserModel().obs;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDriverUser();
    });
    super.initState();
  }

  void getDriverUser() async {
    UserModel? user = await _userController.getUserById(
      userId: widget.driverUserId,
    );
    if (user != null) {
      _driverUserModel.value = user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              indoorViewEnabled: true,
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: _userController.driverLocation.value,
                zoom: 15,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        "Rate The Driver",
                        style: TextStyle(
                          fontSize: 17,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.04),
                    Obx(
                      () => Center(
                        child: RatingStars(
                          value: _value.value,
                          onValueChanged: (v) {
                            _value.value = v;
                          },
                          starBuilder: (index, color) => Icon(
                            Icons.star,
                            color: color,
                            size: 39,
                          ),
                          starCount: 5,
                          starSize: 44,
                          maxValue: 5,
                          starSpacing: 2,
                          maxValueVisibility: true,
                          valueLabelVisibility: false,
                          animationDuration: const Duration(milliseconds: 1000),
                          starOffColor: const Color(0xffe7e8ea),
                          starColor: Colors.yellow,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => CommonButton(
                        child: _userController.isloading.value
                            ? const CarLoader()
                            : const Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                        ontap: () async {
                          String rideId =
                              _userController.currentRideModel.value?.id ?? "";
                          String rating = _value.value.toString().split(".")[0];
                          await _userController.rateDriver(
                            rating: rating,
                            rideId: rideId,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
