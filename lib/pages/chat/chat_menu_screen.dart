import 'package:rider/resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMenuScreen extends StatelessWidget {
  ChatMenuScreen({super.key});

  final List _issues = [
    'Accepted trip by accident',
    "Problem with pickup route",
    "Made a wrong turn",
    "Pickup isn’t worth it",
    "Not safe to pick up",
    'Vehicle issue'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Clara Smith",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(
            Icons.call,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 10),
          // Icon(Icons.more_vert_sharp),
          // SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.05),
            Text(
              "Something wrong? Choose an issue: ",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.09),
            Expanded(
              child: ListView.builder(
                itemCount: _issues.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      Icons.cancel_sharp,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      _issues[index],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.more_vert,
                color: AppColors.primaryColor,
              ),
              title: const Text(
                "More Issues",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
