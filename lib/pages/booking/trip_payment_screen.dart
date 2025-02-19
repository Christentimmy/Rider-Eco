import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/pages/chat/call_screen.dart';
import 'package:rider/pages/chat/chat_screen.dart';
import 'package:rider/pages/home/notification_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/pages/booking/review_screen.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rider/widgets/loader.dart';

class TripPaymentScreen extends StatefulWidget {
  final String rideId;
  const TripPaymentScreen({super.key, required this.rideId});

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
    getPriceBrakeDown();
  }

  void getPriceBrakeDown() async {
    print(widget.rideId);
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
                color: Colors.black.withOpacity(0.8), // Slight transparency
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
                    child: Text("Ride Not Found, Refresh the app"),
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

class OldStatus extends StatelessWidget {
  const OldStatus({
    super.key,
    required RxBool isTripStart,
  }) : _isTripStart = isTripStart;

  final RxBool _isTripStart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Get.height / 22.5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_back,
                    size: 15,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => NotificationScreen());
                },
                child: Container(
                  height: 35,
                  width: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.notifications_active,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          height: 340,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SvgPicture.asset(
                      "assets/images/placeholder.svg",
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Joe Dough",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellowAccent,
                            size: 12,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "5 (38)",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ChatScreen());
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primaryColor,
                      ),
                      child: const Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CallScreen());
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.redAccent,
                      ),
                      child: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pickup Location",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "SJC, Terminal B",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Divider(color: AppColors.primaryColor),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Drop Off Location",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "SJC, Terminal B",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Price: \$5,000.00",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const Text(
                "Trip duration: 32 minutes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Expanded(
                      child: CommonButton(
                        text: _isTripStart.value ? "Pause" : "Resume",
                        bgColor: _isTripStart.value
                            ? Colors.white
                            : AppColors.primaryColor,
                        textColor: Colors.black,
                        ontap: () {
                          _isTripStart.value = !_isTripStart.value;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CommonButton(
                      text: "End Strip",
                      bgColor: Colors.red,
                      textColor: Colors.black,
                      ontap: () {
                        Get.to(() => ReviewScreen());
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
