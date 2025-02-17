import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/models/driver_model.dart';
import 'package:rider/models/user_model.dart';
import 'package:rider/pages/chat/call_screen.dart';
import 'package:rider/pages/chat/chat_screen.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/pages/home/notifcation_screen.dart';
import 'package:rider/pages/home/payment_method_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/widgets/custom_button.dart';

class TripDetailsScreen extends StatefulWidget {
  final DriverModel? driver;
  const TripDetailsScreen({super.key, this.driver});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  final _userController = Get.find<UserController>();
  @override
  void initState() {
    super.initState();
  }

  void getDriverUser() async {
    UserModel? user = await _userController.getUserById(
      userId: widget.driver?.userId ?? "",
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

            return GoogleMap(
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
    // return Scaffold(
    //   body: Container(
    //     padding: const EdgeInsets.only(top: 25),
    //     decoration: const BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage("assets/images/map.png"),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         SizedBox(height: Get.height / 22.5),
    //         _buildNavBarOnMap(),
    //         const Spacer(),
    //         _buildWidgetBelowMap(),
    //       ],
    //     ),
    //   ),
    // );
  }

  Container _buildWidgetBelowMap() {
    return Container(
      height: Get.height * 0.4,
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
              Obx(() {
                if (_userController.isloading.value) {
                  return const SizedBox.shrink();
                }
                final image = _driverUserModel.value.profilePicture;
                return CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(image ?? ""),
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
                    Row(
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
                    )
                  ],
                );
              }),
              const Spacer(),
              InkWell(
                onTap: () {
                  Get.to(() => const ChatScreen());
                },
                child: Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
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
              InkWell(
                onTap: () => Get.to(() => const CallScreen()),
                child: Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
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
            children: [
              Expanded(
                child: CommonButton(
                  text: "Payment",
                  ontap: () {
                    Get.to(() => const PaymentMethodScreen());
                  },
                  bgColor: Colors.black,
                  border: Border.all(width: 1, color: Colors.white),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CommonButton(
                  text: "Cancel Trip",
                  ontap: () {
                    Get.offAll(() => const HomeScreen());
                  },
                ),
              ),
            ],
          )
        ],
      ),
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
              child: Icon(
                Icons.arrow_back,
                size: 15,
              ),
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
              child: const Icon(
                Icons.notifications_active,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
