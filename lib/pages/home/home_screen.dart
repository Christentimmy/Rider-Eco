import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/widgets/custom_textfield.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _textController = TextEditingController();

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
          _buildIconButton(),
          _buildBottomWidget(),
        ],
      ),
    );
  }

  Container _buildIconButton() {
    return Container(
      height: 45,
      width: 45,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 50,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ]),
      child: const Icon(Icons.menu),
    );
  }

  Align _buildBottomWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.389,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Good Morning, John",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              "Where are you going today?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: "Search destination",
              textController: _textController,
              bgColor: Colors.white.withOpacity(0.3),
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 15),
            _buildListTile(),
            _buildListTile(),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minTileHeight: 40,
      leading: Container(
        height: 45,
        width: 45,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xff6CF102),
              Color(0xff3E8B01),
            ],
          ),
        ),
        child: Icon(
          Icons.location_on,
          color: Colors.white,
        ),
      ),
      title: const Text(
        "Ikeja City Mall",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        "Obafemi Awolowo Way, Ikeja Nigeria",
        style: TextStyle(
          color: AppColors.primaryColor.withOpacity(0.4),
          fontSize: 12,
        ),
      ),
    );
  }
}
