import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/resources/colors.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final List _notifactionList = [
    [
      "System",
      "Your booking #1234 has been suc...",
      Icons.done_outline_sharp,
    ],
    [
      "Promotion",
      "Invite friends - Get 3 coupons each!",
      Icons.topic,
    ],
    [
      "System",
      "Your booking #1034 has been suc...",
      Icons.cancel,
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.05),
            Expanded(
              child: ListView.builder(
                itemCount: _notifactionList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xff22272B),
                      border: Border.all(
                        color: const Color(0xff2D343C),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(_notifactionList[index][2]),
                      ),
                      title: Text(
                        _notifactionList[index][0],
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _notifactionList[index][1],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      leadingWidth: 40,
      centerTitle: true,
      title: const Text(
        "Notification",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      leading: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.white,
        child: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      actions: const [
        CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.primaryColor,
          child: Text(
            "12",
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
