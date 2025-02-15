import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/auth/signup_screen.dart';
import 'package:rider/resources/color_resources.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});

  final _pageController = PageController();
  final _currentPage = 0.obs;
  final List _pages = [
    [
      "Multiplied",
      "earnings",
      "Perceive up to 3 times the\namount of the ride",
      "assets/images/splashCha.png",
    ],
    [
      "Exceptional",
      "bonuses",
      "Up to 100\$ welcome bonus\nthe fast week.",
      "assets/images/splash2.png",
    ],
    [
      "Quick",
      "start",
      "Your registration is validate\nwithin 12 hours.",
      "assets/images/splash3.png",
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            padding: EdgeInsets.only(left: Get.width * 0.1),
            decoration: const BoxDecoration(
              color: Color(0xff22272B),
              image: DecorationImage(
                image: AssetImage("assets/images/OBJECTS.png"),
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                _currentPage.value = value;
                if (value == _pages.length - 1) {
                  Future.delayed(const Duration(seconds: 1), () {
                    Get.to(() => SignUpScreen());
                  });
                }
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return _buildSwipeCards(
                  text1: _pages[index][0],
                  text2: _pages[index][1],
                  text3: _pages[index][2],
                  image: _pages[index][3],
                  index: index,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                if (_currentPage.value == _pages.length - 1) {
                  Get.to(() => SignUpScreen());
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.ease,
                  );
                }
              },
              child: Image.asset("assets/images/splash1.png"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwipeCards({
    required String text1,
    required String text2,
    required String text3,
    required String image,
    required int index,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        index == 0
            ? Center(
                child: Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.17),
                  child: Image.asset(
                    image,
                    width: 120,
                  ),
                ),
              )
            : Image.asset(
                image,
                width: 250,
              ),
        index == 0 ? _buildPlantStep() : const SizedBox(),
        const SizedBox(height: 45),
        Text(
          text1,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text2,
              style: const TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
            ),
            SizedBox(width: Get.width * 0.15),
            CircleAvatar(
              radius: 5,
              backgroundColor: AppColors.primaryColor,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          text3,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Column _buildPlantStep() {
    return Column(
      children: [
        Image.asset(
          "assets/images/plant.png",
          width: 250,
        ),
        Image.asset(
          "assets/images/floor.png",
          width: 250,
        ),
      ],
    );
  }
}
