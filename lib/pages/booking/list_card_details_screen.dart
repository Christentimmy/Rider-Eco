import 'package:rider/pages/chat/call_screen.dart';
import 'package:rider/pages/home/notification_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/pages/booking/arriving_pick_up_screen.dart';
import 'package:rider/pages/chat/chat_screen.dart';
import 'package:rider/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ListCardDetailsScreen extends StatelessWidget {
  const ListCardDetailsScreen({super.key});

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
            _buildNavBarOnMap(),
            const Spacer(),
            _buildWidgetBelowMap(),
          ],
        ),
      ),
    );
  }

  Container _buildWidgetBelowMap() {
    return Container(
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
              GestureDetector(
                onTap: () => Get.to(() => CallScreen()),
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
          CommonButton(
            text: "Accept",
            ontap: () {
              Get.to(() => const ArrivingPickUpScreen());
            },
          ),
        ],
      ),
    );
  }

  Padding _buildNavBarOnMap() {
    return Padding(
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
    );
  }
}
