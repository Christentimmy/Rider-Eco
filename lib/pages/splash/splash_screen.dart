import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/controller/socket_controller.dart';
import 'package:rider/controller/storage_controller.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/pages/auth/signup_screen.dart';
import 'package:rider/pages/intro/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storageController = Get.find<StorageController>();
  final _userController = Get.find<UserController>();
  final _socketController = Get.find<SocketController>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      bool newUser = await _storageController.getUserStatus();
      if (newUser) {
        Get.offAll(() => IntroScreen());
        await _storageController.saveStatus("notNewAgain");
        return;
      }
      String? token = await _storageController.getToken();
      if (token == null || token.isEmpty) {
        Get.off(() => SignUpScreen());
        return;
      }
      await _userController.getUserStatus();
  _socketController.initializeSocket();
      await _userController.getCurrentRide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff5DCC04),
              Color(0xff2E6602),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: Get.width * 0.1),
                child: Image.asset(
                  "assets/images/simExp.png",
                  width: 184,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              "Find a best",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Taxi ride",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit. ",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
