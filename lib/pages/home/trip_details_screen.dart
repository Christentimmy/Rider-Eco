import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/pages/home/notifcation_screen.dart';
import 'package:rider/pages/home/payment_method_screen.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/widgets/custom_button.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 25),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/map.png"),
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
              Image.asset(
                "assets/images/avater2.png",
                width: 55,
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
                  // Get.to(() => ChatScreen());
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
                // onTap: () => Get.to(() => CallScreen()),
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
          const Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              SizedBox(width: 10),
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
          const Divider(color: AppColors.primaryColor),
          const Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              SizedBox(width: 10),
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
                    Get.to(()=> PaymentMethodScreen());
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
                    Get.offAll(() => HomeScreen());
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
