import 'package:rider/pages/settings/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.01),
            UserPictureWithButton(),
            const SizedBox(height: 20),
            Container(
              height: 55,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 83, 83, 83),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 196, 196, 196),
                    blurRadius: 2,
                    spreadRadius: 1,
                  )
                ],
                border: Border.all(
                  color: const Color.fromARGB(255, 151, 151, 151),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Christen Timmy",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 55,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 83, 83, 83),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 196, 196, 196),
                    blurRadius: 2,
                    spreadRadius: 1,
                  )
                ],
                border: Border.all(
                  color: const Color.fromARGB(255, 151, 151, 151),
                ),
              ),
              child: ListTile(
                title: Text(
                  "11 / 22 / 2024",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.calendar_month,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 55,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 83, 83, 83),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 196, 196, 196),
                    blurRadius: 2,
                    spreadRadius: 1,
                  )
                ],
                border: Border.all(
                  color: const Color.fromARGB(255, 151, 151, 151),
                ),
              ),
              child: ListTile(
                title: Text(
                  "christentimmy@gmail.com",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.email,
                  size: 17,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 55,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 83, 83, 83),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 196, 196, 196),
                    blurRadius: 2,
                    spreadRadius: 1,
                  )
                ],
                border: Border.all(
                  color: const Color.fromARGB(255, 151, 151, 151),
                ),
              ),
              child: ListTile(
                title: Text(
                  "+234-832-932-3723",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.phone,
                  size: 17,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 55,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 83, 83, 83),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 196, 196, 196),
                    blurRadius: 2,
                    spreadRadius: 1,
                  )
                ],
                border: Border.all(
                  color: const Color.fromARGB(255, 151, 151, 151),
                ),
              ),
              child: ListTile(
                title: Text(
                  "364 Stillwater Ave. Attleboro",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.location_pin,
                  size: 17,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
