import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/controller/call_controller.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/models/driver_model.dart';
import 'package:rider/models/user_model.dart';
import 'package:rider/pages/chat/chat_screen.dart';
import 'package:rider/pages/home/notifcation_screen.dart';
import 'package:rider/pages/home/panic_mode_screen.dart';
import 'package:rider/pages/home/support_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/loader.dart';

class TripDetailsScreen extends StatefulWidget {
  final DriverModel? driver;
  final String rideId;
  final String? driverId;
  const TripDetailsScreen({
    super.key,
    this.driver,
    required this.rideId,
    this.driverId,
  });

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  final _userController = Get.find<UserController>();
  final _callController = Get.find<CallController>();

  @override
  void initState() {
    super.initState();
    getDriverUser();
  }

  void getDriverUser() async {
    UserModel? user = await _userController.getUserById(
      userId: widget.driverId ?? widget.driver?.userId ?? "",
    );
    if (user != null) {
      _driverUserModel.value = user;
    }
  }

  GoogleMapController? _mapController;
  final _driverUserModel = UserModel().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            if (_mapController != null) {
              _mapController?.animateCamera(
                CameraUpdate.newLatLng(_userController.driverLocation.value),
              );
            }

            return SizedBox(
              height: Get.height * 0.65,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _userController.driverLocation.value,
                  zoom: 15,
                ),
                mapType: MapType.hybrid,
                markers: {
                  Marker(
                    markerId: const MarkerId('driver'),
                    position: _userController.driverLocation.value,
                    infoWindow: const InfoWindow(title: 'Driver'),
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
              ),
            );
          }),
          Padding(
            padding: EdgeInsets.only(top: Get.height / 22.5),
            child: _buildNavBarOnMap(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildWidgetBelowMap(),
          ),
        ],
      ),
    );
  }

  Container _buildWidgetBelowMap() {
    return Container(
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            width: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: AppColors.primaryColor),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  if (_userController.isloading.value) {
                    return const SizedBox.shrink();
                  }
                  String title = _userController.getStatusTitle();
                  String status =
                      _userController.currentRideModel.value?.status ?? "";
                  return Text(
                    title,
                    style: TextStyle(
                      color:
                          status == "panic"
                              ? Colors.red
                              : AppColors.primaryColor,
                    ),
                  );
                }),
                Obx(() {
                  if (_userController.isloading.value) {
                    return const SizedBox.shrink();
                  }
                  String status =
                      _userController.currentRideModel.value?.status ?? "";
                  return CircleAvatar(
                    radius: 10,
                    backgroundColor:
                        status == "panic" ? Colors.red : AppColors.primaryColor,
                    child: const Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 12,
                    ),
                  );
                }),
              ],
            ),
          ),
          // const SizedBox(width: 20),
          Row(
            children: [
              Obx(() {
                if (_userController.isloading.value) {
                  return const SizedBox.shrink();
                }
                final image = _driverUserModel.value.profilePicture;
                if (image == null || image.isEmpty) {
                  return const SizedBox.shrink();
                }
                return CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(image),
                );
              }),
              const SizedBox(width: 5),
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_driverUserModel.value.firstName} ${_driverUserModel.value.lastName}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    widget.driver?.reviews == null
                        ? const SizedBox.shrink()
                        : Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellowAccent,
                              size: 12,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${widget.driver?.reviews?.averageRating} ${widget.driver?.reviews?.totalRatings}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                  ],
                );
              }),
              const Spacer(),
              InkWell(
                onTap: () {
                  Get.to(() => ChatScreen(rideId: widget.rideId));
                },
                child: Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.primaryColor,
                  ),
                  child: const Icon(Icons.message, color: Colors.white),
                ),
              ),
              InkWell(
                onTap: () async {
                  displayEmergency();
                },
                child: Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.redAccent,
                  ),
                  child: const Icon(Icons.security, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pickup Location",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Text(
                        _userController
                                .currentRideModel
                                .value
                                ?.pickupLocation
                                ?.address ??
                            "",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: AppColors.primaryColor),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Drop Off Location",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Text(
                        _userController
                                .currentRideModel
                                .value
                                ?.dropoffLocation
                                ?.address ??
                            "",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(
            () => CommonButton(
              child:
                  _userController.isloading.value
                      ? const CarLoader()
                      : const Text(
                        "Cancel Trip",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
              ontap: () async {
                String? rideId = _userController.currentRideModel.value?.id;
                await _userController.cancelTrip(
                  rideId: rideId ?? widget.rideId,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> displayEmergency() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: Container(
            color: const Color.fromARGB(255, 24, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.call, color: Colors.white),
                  title: const Text(
                    "Call Driver",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _callController.callDriver(
                      _driverUserModel.value.phoneNumber ?? "",
                    );
                    Get.back();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.support_agent, color: Colors.white),
                  title: const Text(
                    "Contact Support",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Get.off(() => SupportScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.security, color: Colors.red),
                  title: const Text(
                    "Panic Mode",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Get.off(() => PanicModeScreen(rideId: widget.rideId));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.support_agent, color: Colors.white),
                  title: Obx(
                    () =>
                        _userController.isloading.value
                            ? LinearProgressIndicator(color: Colors.green)
                            : const Text(
                              "Rude Driver and attitude",
                              style: TextStyle(color: Colors.white),
                            ),
                  ),
                  onTap: () async {
                    await _userController.reportDriver(rideId: widget.rideId);
                  },
                ),
                // ListTile(
                //   leading: const Icon(Icons.dangerous, color: Colors.red),
                //   title: const Text(
                //     "Car been hijacked",
                //     style: TextStyle(color: Colors.red),
                //   ),
                //   onTap: () {},
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Padding _buildNavBarOnMap() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back, size: 15),
            ),
          ),
          const Spacer(),
          InkWell(
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
              child: const Icon(Icons.notifications_active, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
