import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/pages/home/notifcation_screen.dart';
import 'package:rider/pages/home/panic_mode_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/widgets/custom_button.dart';

class TripStatusScreen extends StatelessWidget {
  const TripStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {},
        child: Container(
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
              _buildWidgetBelowMap(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildWidgetBelowMap({
    required BuildContext context,
  }) {
    return Container(
      height: Get.height * 0.5,
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
          Container(
            height: 30,
            width: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: AppColors.primaryColor,
              ),
              color: Colors.white,
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "RIDE ACCEPTED",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.primaryColor,
                  child: const Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 12,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
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
              InkWell(
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
              InkWell(
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
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Get.to(()=> const PanicModeScreen());
                },
                child: const Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.circleExclamation,
                      color: Colors.red,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "PANIC MODE",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
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
              Expanded(child: Builder(
                builder: (context) {
                  return CommonButton(
                    text: "Emergency",
                    textColor: Colors.yellow,
                    ontap: () {
                      displayEmergencySheet(context);
                    },
                    bgColor: Colors.black,
                    border: Border.all(width: 1, color: Colors.yellow),
                  );
                },
              )),
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

  displayEmergencySheet(
    BuildContext context,
  ) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: Get.height * 0.6,
          width: Get.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Emergency",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CommonButton(
                text: "Contact Support",
                ontap: () {},
                bgColor: Colors.black,
                border: Border.all(
                  width: 1,
                  color: AppColors.primaryColor,
                ),
                textColor: AppColors.primaryColor,
              ),
              const SizedBox(height: 10),
              CommonButton(
                text: "Car been hijacked",
                ontap: () {},
                bgColor: Colors.black,
                border: Border.all(
                  width: 1,
                  color: AppColors.primaryColor,
                ),
                textColor: AppColors.primaryColor,
              ),
              const SizedBox(height: 10),
              CommonButton(
                text: "Rude driver and attitude",
                ontap: () {},
                bgColor: Colors.black,
                border: Border.all(
                  width: 1,
                  color: AppColors.primaryColor,
                ),
                textColor: AppColors.primaryColor,
              ),
              const SizedBox(height: 10),
              CommonButton(
                text: "Other",
                ontap: () {},
                bgColor: Colors.black,
                border: Border.all(
                  width: 1,
                  color: AppColors.primaryColor,
                ),
                textColor: AppColors.primaryColor,
              ),
            ],
          ),
        );
      },
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
