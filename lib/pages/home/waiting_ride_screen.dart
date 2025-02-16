import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/pages/home/trip_details_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/service/socket_service.dart';
import 'package:rider/widgets/custom_button.dart';

class WaitingRideScreen extends StatefulWidget {
  const WaitingRideScreen({super.key});

  @override
  State<WaitingRideScreen> createState() => _WaitingRideScreenState();
}

class _WaitingRideScreenState extends State<WaitingRideScreen> {
  final socketService = Get.find<SocketService>();
  @override
  void initState() {
    print("build");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!socketService.socket.connected) {
        socketService.connect();
      }
      print("Socket Connected ${socketService.socket.connected}");
      print("Socket DisConnected ${socketService.socket.disconnected}");
      socketService.connect();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image.asset("assets/images/map3.png"),
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
                            "3 min to pickup",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Your car will be at the\npickup spot at 12:03pm",
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
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          text: "Cancel Trip",
                          ontap: () {
                            Get.offAll(() => HomeScreen());
                          },
                          textColor: AppColors.primaryColor,
                          bgColor: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CommonButton(
                          text: "Find Trip",
                          ontap: () {
                            Get.to(() => TripDetailsScreen());
                          },
                        ),
                      ),
                    ],
                  )
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
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tolstoy house....",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Divider(color: Colors.grey, thickness: 1),
                ],
              ),
            ),
            const Text(
              "4:30 pm",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
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
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mandi house....",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "6:30 pm",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
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
