import 'package:rider/resources/color_resources.dart';
import 'package:rider/pages/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Get.off(() => SignUpScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/ecoLogo.png",
              width: 220,
              fit: BoxFit.cover,
            ),
          ),
          _buildSplashText(),
        ],
      ),
    );
  }

  Widget _buildSplashText() {
    return Column(
      children: AnimationConfiguration.toStaggeredList(
        childAnimationBuilder: (widget) => SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children: [
          const SizedBox(height: 100),
          const Text(
            "Drive with ECO",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Support your living with extra Cash",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
        duration: const Duration(seconds: 3),
      ),
    );
  }

}
