import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/models/ride_model.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/utils/date_converter.dart';

class BalanceAndHistoryScreen extends StatefulWidget {
  const BalanceAndHistoryScreen({super.key});

  @override
  State<BalanceAndHistoryScreen> createState() =>
      _BalanceAndHistoryScreenState();
}

class _BalanceAndHistoryScreenState extends State<BalanceAndHistoryScreen> {
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    if (!_userController.isRideHistoryFetched.value) {
      _userController.fetchRideHistory();
    }
    super.initState();
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
            const SizedBox(height: 20),
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
                    itemCount: _userController.rideHistoryList.length,
                    itemBuilder: (context, index) {
                      Ride ride = _userController.rideHistoryList[index];
                      return RideHistoryCard(
                        ride: ride,
                        rideId: "UBER12345",
                        pickup: "Oslo Central Station",
                        dropoff: "Gardermoen Airport",
                        driverName: "John Doe",
                        rating: 4.8,
                        status: "Completed",
                        price: 150.00,
                        duration: "45 min",
                        date: "Feb 18, 2025",
                      );
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

  Widget _filterCardsBudget({required Ride ride}) {
    return InkWell(
      onTap: () {
        // Get.to(() => const HistoryRodeDetails());
      },
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(0.6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "June 3, 2021  12:30pm",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 30,
                  width: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 59, 126, 4),
                  ),
                  child: const Text(
                    "Trip in 2days",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 5,
              minTileHeight: 35,
              title: Text(
                "Ikeja City Mall, Alausa Road, Ikeja",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              leading: Icon(
                Icons.location_pin,
                color: Color.fromARGB(255, 68, 145, 5),
              ),
            ),
            const Divider(),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 5,
              minTileHeight: 35,
              title: Text(
                "Shoprite Event Centre, Ikeja",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              leading: Icon(
                Icons.location_pin,
                color: Color.fromARGB(255, 68, 145, 5),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 15),
                        children: [
                          const TextSpan(
                            text: "Driver: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Christen Junior",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 15),
                        children: [
                          const TextSpan(
                            text: "Status: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Completed",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(), // Add space between the two columns
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 15),
                        children: [
                          TextSpan(
                            text: "Rating: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "⭐⭐⭐⭐⭐",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 15),
                        children: [
                          const TextSpan(
                            text: "Trip ID: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "TRP24002",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 55,
                  width: 165,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Price: ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("\$5000"),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Trip duration: ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("20mins"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
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
            icon: const Icon(
              Icons.menu,
            ),
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_alt_outlined),
        ),
      ],
    );
  }
}

class RideHistoryCard extends StatelessWidget {
  final Ride ride;
  final String rideId;
  final String pickup;
  final String dropoff;
  final String driverName;
  final double rating;
  final String status;
  final double price;
  final String duration;
  final String date;

  const RideHistoryCard({
    super.key,
    required this.rideId,
    required this.ride,
    required this.pickup,
    required this.dropoff,
    required this.driverName,
    required this.rating,
    required this.status,
    required this.price,
    required this.duration,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  "Trip ID: ${ride.id}",
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
                  backgroundColor: _statusColor(status),
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
                      driverName,
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
