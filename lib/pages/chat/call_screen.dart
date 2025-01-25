import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/avater2.png",
              width: 120,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Christen E",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            "03:45",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SizedBox(height: Get.height * 0.25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xff70707280).withOpacity(0.7),
                  child: Icon(
                    Icons.volume_down_sharp,
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xff70707280).withOpacity(0.7),
                  child: Icon(
                    Icons.volume_off_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
