import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/widgets/custom_button.dart';

class HistoryRodeDetails extends StatelessWidget {
  const HistoryRodeDetails({super.key});

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
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 10),
                const Column(
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
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 10),
                const Column(
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
                  ontap: () {
                    displayCancelRideBottomSheet(context);
                  },
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

  Future<dynamic> displayCancelRideBottomSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          height: Get.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Do you want to cancel\nthis schedule?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Get.width / 3.5,
                      height: 42,
                      child: CommonButton(
                        text: "No",
                        ontap: () {
                          Get.back();
                        },
                        border: Border.all(
                          width: 0.8,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: Get.width / 3.5,
                      height: 42,
                      child: CommonButton(
                        text: "Yes",
                        textColor: AppColors.primaryColor,
                        ontap: () {
                          Get.offAll(() => HomeScreen());
                        },
                        bgColor: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Ride Details",
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
