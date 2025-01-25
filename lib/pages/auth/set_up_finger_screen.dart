import 'package:rider/resources/color_resources.dart';
import 'package:rider/pages/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetUpFingerScreen extends StatelessWidget {
  const SetUpFingerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Set Your Fingerprint",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height / 8.5),
            const Center(
              child: Text(
                "Add a fingerprint to make your account\nmore secure.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: Get.height / 9.5),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 45,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/authPic.png",
                              width: 150,
                            ),
                            const Text(
                              "Your account is ready to use. You will be redirected to the home page in a few seconds",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Center(
                child: Image.asset(
                  "assets/images/Frame.png",
                  width: 150,
                ),
              ),
            ),
            SizedBox(height: Get.height / 9.5),
            const Center(
              child: Text(
                "Please put your finger on the fingerprint\nscanner to get started",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  width: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => BottomNavigationScreen());
                  },
                  child: Container(
                    height: 45,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          const Color.fromARGB(255, 8, 44, 10),
                        ],
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
