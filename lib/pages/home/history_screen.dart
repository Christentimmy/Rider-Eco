import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/models/ride_model.dart';
import 'package:rider/pages/booking/ride_history_details_screen.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/utils/date_converter.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_userController.isRideHistoryFetched.value) {
        _userController.fetchRideHistory();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _userController.isloading.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildSideBar(),
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                if (_userController.isloading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                } else if (_userController.rideHistoryList.isEmpty) {
                  return const Center(
                    child: Text(
                      "History is empty",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _userController.rideHistoryList.length,
                    itemBuilder: (context, index) {
                      Ride ride = _userController.rideHistoryList[index];
                      return ride.isScheduled == true
                          ? ScheduleCard(ride: ride)
                          : RideHistoryCard(ride: ride);
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "History",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          );
        },
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String status) {
            if (status == "all") {
              _userController.fetchRideHistory();
              return;
            }
            _userController.fetchRideHistory(status: status);
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(value: "all", child: Text("📜 All Rides")),
            const PopupMenuItem(value: "completed", child: Text("✅ Completed")),
            const PopupMenuItem(value: "cancelled", child: Text("❌ Cancelled")),
            const PopupMenuItem(
              value: "progress",
              child: Text("🚗 In Progress"),
            ),
            const PopupMenuItem(
              value: "paused",
              child: Text("⏸️ Paused"),
            ),
            const PopupMenuItem(
              value: "schedule_pending",
              child: Text("⏳ Scheduled (Pending)"),
            ),
            const PopupMenuItem(
              value: "schedule_assigned",
              child: Text("✔️ Scheduled (Assigned)"),
            ),
            const PopupMenuItem(
              value: "schedule_failed",
              child: Text("❌ Scheduled (Failed)"),
            ),
          ],
          icon: const Icon(Icons.filter_alt_outlined),
        ),
      ],
    );
  }
}

class RideHistoryCard extends StatelessWidget {
  final Ride ride;
  const RideHistoryCard({
    super.key,
    required this.ride,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => RideHistoryDetailsScreen(ride: ride));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trip ID: ${ride.id?.substring(0, 7)}...",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Chip(
                    label: Text(
                      ride.status?.toUpperCase() ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    backgroundColor: _statusColor(ride.status ?? ""),
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // 📍 Locations
              _locationRow(
                Icons.circle,
                Colors.green,
                ride.pickupLocation?.address.substring(0, 7) ?? "",
              ),
              _locationRow(
                Icons.location_on,
                Colors.red,
                ride.dropoffLocation?.address.substring(0, 7) ?? "",
              ),

              const SizedBox(height: 10),
              const Divider(),

              // 🚖 Driver & Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 18,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "${ride.driverFirstName} ${ride.driverLastName}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 18, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        ride.reviews?.averageRating.toString() ?? "",
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${ride.fare?.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    convertDateToNormal(ride.requestedAt.toString()),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🎨 Dynamic Color for Status
  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      case "ongoing":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  // 📍 Location Row
  Widget _locationRow(
    IconData icon,
    Color iconColor,
    String location,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              location,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final Ride ride;
  const ScheduleCard({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => RideHistoryDetailsScreen(ride: ride));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    ride.pickupLocation?.address != null &&
                            ride.pickupLocation!.address.length > 20
                        ? "${ride.pickupLocation!.address.substring(0, 19)}..."
                        : ride.pickupLocation!.address,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    ride.dropoffLocation?.address != null &&
                            ride.dropoffLocation!.address.length > 22
                        ? "${ride.dropoffLocation!.address.substring(0, 21)}..."
                        : ride.dropoffLocation!.address,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    convertDateToNormal(ride.scheduledTime.toString()),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 41, 117, 43),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 35,
                    width: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _statusColor(ride.status ?? ""),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      ride.status ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🎨 Dynamic Color for Status
  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      case "ongoing":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  // 📍 Location Row
  Widget _locationRow(
    IconData icon,
    Color iconColor,
    String location,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              location,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
