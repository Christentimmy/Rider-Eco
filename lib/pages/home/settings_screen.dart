import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/change_password_screen.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/pages/home/privacy_policy_screen.dart';
import 'package:rider/pages/home/profile_screen.dart';
import 'package:rider/pages/home/save_places_screen.dart';
import 'package:rider/pages/home/terms_and_condition_screen.dart';
import 'package:rider/resources/color_resources.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final List _settingList = [
    [
      "Edit Profile",
      Icons.account_circle_sharp,
      () {
        Get.to(() => const ProfileScreen());
      }
    ],
    [
      "Change Password",
      Icons.lock,
      () {
        Get.to(() => ChangePasswordScreen());
      }
    ],
    [
      "Save Address",
      Icons.location_pin,
      () {
        Get.to(() => SavePlacesScreen());
      }
    ],
    // [
    //   "Password Reset",
    //   Icons.lock,
    //   () {
    //     // Get.to(()=> FaqScreen());
    //   }
    // ],
    [
      "Terms & Conditon",
      Icons.local_police_rounded,
      () {
        Get.to(() => TermsAndConditionScreen());
      }
    ],
    [
      "Policy",
      Icons.local_police_rounded,
      () {
        Get.to(() => PrivacyPolicyScreen());
      }
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      drawer: buildSideBar(),
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
              const UserPictureWithButton(),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "234-7382-7398",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _settingList.length,
                itemBuilder: (context, index) {
                  return CustomListTile(
                    icon: _settingList[index][1],
                    text: _settingList[index][0],
                    onTap: () {
                      _settingList[index][2].call();
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: InkWell(
                  onTap: () {
                    displayDeleteWidget(context);
                  },
                  child: const Text(
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
      barrierColor: const Color.fromARGB(167, 61, 61, 61),
      builder: (context) {
        return Container(
          height: 370,
          width: Get.width,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          decoration: const BoxDecoration(
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
              const Text(
                "All data associated with you account will be\nerased within 48 hours.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
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
                child: const Text(
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
                child: const Text(
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

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Settings",
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
      leading: CircleAvatar(
        radius: 19,
        backgroundColor: Colors.grey.withOpacity(0.1),
        child: Icon(
          icon,
          color: const Color.fromARGB(255, 77, 167, 4),
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      minTileHeight: 55,
    );
  }
}
