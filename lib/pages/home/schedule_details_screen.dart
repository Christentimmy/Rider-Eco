import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/widgets/custom_button.dart';

class ScheduleDetailsScreen extends StatelessWidget {
  const ScheduleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "June 3, 2021  12:30pm",
                  style: TextStyle(
                    color: Color.fromARGB(255, 41, 117, 43),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  "\$54020.00",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/map.png",
                height: Get.height * 0.3,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pickup Location",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "B Street 92025, CA - 3:00 to 3:15 PM",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // const SizedBox(height: 20),
            const Divider(color: Color.fromARGB(255, 41, 117, 43)),
            const Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Drop Off Location",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "SJC, Terminal B",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: Image.asset(
                "assets/images/avater2.png",
                width: 90,
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "David Alfredino",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: SizedBox(
                width: Get.width / 2.2,
                height: 42,
                child: CommonButton(
                  text: "Cancel Ride",
                  borderRadius: BorderRadius.circular(45),
                  textColor: AppColors.primaryColor,
                  ontap: () {},
                  bgColor: Colors.white,
                  border: Border.all(
                    width: 0.8,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Schedules Details",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          );
        },
      ),
    );
  }
}
