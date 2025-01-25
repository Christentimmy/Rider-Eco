import 'package:rider/pages/settings/refer_friends_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/pages/settings/change_password_screen.dart';
import 'package:rider/pages/settings/date_distance_screen.dart';
import 'package:rider/pages/settings/faq_screen.dart';
import 'package:rider/pages/settings/profile_screen.dart';
import 'package:rider/pages/settings/rule_terms_screen.dart';
import 'package:rider/pages/settings/vehicle_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final List _settingList = [
    [
      "Profile Settings",
      Icons.account_circle_sharp,
      (){
        Get.to(()=> ProfileScreen());
      }
    ],
    [
      "Password",
      Icons.lock,
      (){
        Get.to(()=> ChangePasswordScreen());
      }
    ],
    [
      "Vehicle Details",
      Icons.car_repair_sharp,
      (){
        Get.to(()=> VehicleProfileScreen());
      }
    ],
    [
      "FAQ",
      Icons.calendar_month_outlined,
      (){
        Get.to(()=> FaqScreen());
      }
    ],
    [
      "Date & Distance",
      Icons.calendar_month_outlined,
      (){
        Get.to(()=> DateAndDistanceScreen());
      }
    ],
    [
      "Refer Friends",
      Icons.rule_folder_sharp,
      (){
        Get.to(()=> ReferFriendsScreen());
      }
    ],
    [
      "Rules & Terms",
      Icons.rule_folder_sharp,
      (){
        Get.to(()=> RuleAndTermsScreen());
      }
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildApBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.01),
              UserPictureWithButton(),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                ],
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "234-7382-7398",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _settingList.length,
                itemBuilder: (context, index) {
                  return CustomListTile(
                    icon: _settingList[index][1],
                    text: _settingList[index][0],
                    onTap: () {
                      // Get.to(() => ProfileScreen());
                      _settingList[index][2].call();
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    displayDeleteWidget(context);
                  },
                  child: Text(
                    "Delete Account",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> displayDeleteWidget(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      barrierColor: Color.fromARGB(167, 61, 61, 61),
      builder: (context) {
        return Container(
          height: 370,
          width: Get.width,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Do you want to delete\nyour account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "All data associated with you account will be\nerased within 48 hours.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "If there are any unresolved issues related to\nyour account we can’t delete it.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 45,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                width: Get.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Delete",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 45,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                width: Get.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    width: 2,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  AppBar _buildApBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      title: const Text(
        "Settings",
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }
}

class UserPictureWithButton extends StatelessWidget {
  const UserPictureWithButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
              "assets/images/avater2.png",
            ),
          ),
          Positioned(
            bottom: 5,
            right: 2,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: Colors.red,
                ),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.black,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const CustomListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: AppColors.primaryColor,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      minTileHeight: 55,
    );
  }
}
