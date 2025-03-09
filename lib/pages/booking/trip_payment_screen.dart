import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/models/review_model.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/widgets/loader.dart';

class TripPaymentScreen extends StatefulWidget {
  final String rideId;
  final String driverUserId;
  final Reviews reviews;
  const TripPaymentScreen({
    super.key,
    required this.rideId,
    required this.driverUserId,
    required this.reviews,
  });

  @override
  State<TripPaymentScreen> createState() => _TripPaymentScreenState();
}

class _TripPaymentScreenState extends State<TripPaymentScreen> {
  final _userController = Get.find<UserController>();
  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(59.9139, 10.7522),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getPriceBrakeDown();
    });
  }

  void getPriceBrakeDown() async {
    String rideId = widget.rideId;
    await _userController.getRideFareBreakDown(
      rideId: rideId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            mapType: MapType.hybrid,
          ),
          // Blur Effect Overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.1), // Slight tint
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: Get.height * 0.45,
              width: Get.width / 1.3,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() {
                if (_userController.isRideBreakDownLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                final rideBreakDown =
                    _userController.rideFareBreakdownModel.value;
                if (rideBreakDown == null) {
                  return const Center(
                    child: Text("Ride Not Found, relaunch the app"),
                  );
                }
                String baseFare = rideBreakDown.baseFare;
                String distanceKm = rideBreakDown.distanceKm;
                String distanceFare = rideBreakDown.distanceFare;
                String totalPrice = rideBreakDown.totalFare;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Payment Break Down",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      minTileHeight: 45,
                      title: const Text(
                        "Base Fare",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Text(
                        baseFare,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    ListTile(
                      minTileHeight: 45,
                      title: const Text(
                        "Distance",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Text(
                        distanceKm,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    ListTile(
                      minTileHeight: 45,
                      title: const Text(
                        "Distance Fare",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Text(
                        distanceFare,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      minTileHeight: 45,
                      title: const Text(
                        "Total Fare",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Text(
                        "Kr$totalPrice",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CommonButton(
                      ontap: () async {
                        await _userController.makePayment(
                          rideId: widget.rideId,
                          reviews: widget.reviews,
                          driverUserId: widget.driverUserId,
                        );
                      },
                      child: _userController.isPaymentProcessing.value
                          ? const CarLoader()
                          : const Text(
                              "Payment",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
