import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/controller/socket_controller.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/widgets/custom_button.dart';

class WaitingRideScreen extends StatefulWidget {
  final String fromLoactionName;
  final String toLoactionName;
  const WaitingRideScreen({
    super.key,
    required this.fromLoactionName,
    required this.toLoactionName,
  });

  @override
  State<WaitingRideScreen> createState() => _WaitingRideScreenState();
}

class _WaitingRideScreenState extends State<WaitingRideScreen> {
  final socketService = Get.find<SocketController>();
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!socketService.socket!.connected == false) {
        socketService.initializeSocket();
      }
      print("Socket Connected ${socketService.socket?.connected}");
    });

    super.initState();
  }

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(59.9139, 10.7522),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.height * 0.6,
            width: Get.width,
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              mapType: MapType.hybrid,
              onTap: (argument) async {},
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height * 0.7,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(height: Get.height * 0.04),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ride Request",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Your ride request will\n be pending for maximum\n10mins",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Cancel",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset(
                        "assets/images/image10.png",
                        width: 150,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildToAndFroWidget(),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 0.7,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                    child: ListTile(
                      leading: Image.asset("assets/images/babycar.png"),
                      title: const Text(
                        "Local Ride",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const ListTile(
                    minTileHeight: 40,
                    leading: Text(
                      "OTP",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text(
                      "4553",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const ListTile(
                    minTileHeight: 40,
                    leading: Text(
                      "Total Fare",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text(
                      "\$500",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  Obx(
                    () => CommonButton(
                      ontap: () async {
                        await _userController.cancelRideRequest(
                          rideId: _userController.currentRideModel.value?.id ?? '',
                        );
                      },
                      child: _userController.isloading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Cancel Ride Request",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildToAndFroWidget() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _buildCircle("A"),
                _buildDashedLine(),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.fromLoactionName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Divider(color: Colors.grey, thickness: 1),
                ],
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _buildCircle("B"),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.toLoactionName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Green Circle Widget
  Widget _buildCircle(String label) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Dashed Line Widget
  Widget _buildDashedLine() {
    return Container(
      width: 2,
      height: 20,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.black,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
