import 'package:rider/pages/bottom_navigation_screen.dart';
import 'package:rider/pages/home/notification_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/pages/booking/arriving_pick_up_screen.dart';
import 'package:rider/pages/booking/trip_status_screen.dart';
import 'package:rider/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartTripScreen extends StatelessWidget {
  const StartTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 25),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/mapImage.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
                    onTap: (){
                      Get.to(()=> NotificationScreen());
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
            SizedBox(height: Get.height / 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      displaySafetyKit(context);
                    },
                    child: Container(
                      height: 45,
                      width: 100,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.navigation_rounded,
                            color: Colors.white,
                          ),
                          Text(
                            "Navigate",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
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
                ],
              ),
            ),
            const Spacer(),
            Container(
              height: 320,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              width: double.infinity,
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
                  const SizedBox(height: 10),
                  const Text(
                    '1:35 Late',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(()=> BottomNavigationScreen());
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: const Text(
                        "Cancel Ride",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  CommonButton(
                    text: "Start Trip",
                    ontap: () {
                      Get.to(()=> TripStatusScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
