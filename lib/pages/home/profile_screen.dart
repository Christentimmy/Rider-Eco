import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/edit_profile_screen.dart';
import 'package:rider/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.06),
            Center(
              child: Image.asset(
                "assets/images/avater2.png",
                width: 130,
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Ben Afrajames",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CommonButton(
              text: "Edit Profile",
              ontap: () {
                Get.to(() => EditProfileScreen());
              },
              width: Get.width * 0.4,
              textColor: const Color.fromARGB(255, 90, 182, 15),
              bgColor: Colors.white,
              border: Border.all(
                width: 1,
                color: const Color.fromARGB(255, 90, 182, 15),
              ),
            ),
            const SizedBox(height: 30),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              minTileHeight: 25,
              title: Text(
                "Phone Number",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              subtitle: Text("+1 8619 228 992"),
              trailing: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
            const Divider(),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              minTileHeight: 25,
              title: Text(
                "Email Address",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              subtitle: Text("john@email.com"),
              trailing: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Profile",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
    );
  }
}
