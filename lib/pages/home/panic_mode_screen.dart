import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/controller/user_controller.dart';

class PanicModeScreen extends StatelessWidget {
  final String rideId;
  PanicModeScreen({super.key, required this.rideId});
  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Warning Icon
            const Icon(Icons.error, color: Colors.red, size: 50),
            const SizedBox(height: 10),
            const Text(
              "PANIC MODE",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            const Text(
              "Activate the panic button only if you sense any type of danger with the driver. This will alert the security operatives around that area.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
            ),
            SizedBox(height: Get.height * 0.09),
            const Text(
              "ACTIVATE PANIC MODE?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.09),
            // Buttons
            Column(
              children: [
                // Yes Button
                SizedBox(
                  width: Get.width / 1.7,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Get.to(() => ActivatedPanicModeScreen());
                      await _userController.panicMode(rideId: rideId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Obx(
                      () =>
                          _userController.isloading.value
                              ? CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                "Yes",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
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
                      Get.back();
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
          ],
        ),
      ),
    );
  }
}
