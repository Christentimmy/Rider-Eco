import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/widgets/build_icon_button.dart';

class EndTripAfterPanicScreen extends StatelessWidget {
  const EndTripAfterPanicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/map.png",
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 50,
            ),
            child: buildIconButton(
              icon: Icons.arrow_back,
              onTap: () => Get.back(),
            ),
          ),
          _buildBottomWidget(),
        ],
      ),
    );
  }

  Widget _buildBottomWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.45,
        width: Get.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff22272B),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Are you sure you want to end ride?",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Divider(),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width / 1.7,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(()=> HomeScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Yes",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // No Button
            SizedBox(
              width: Get.width / 1.7,
              child: OutlinedButton(
                onPressed: () {
                 Get.to(()=> HomeScreen());
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "No",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
