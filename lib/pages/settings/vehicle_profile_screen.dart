import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleProfileScreen extends StatelessWidget {
  const VehicleProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Vehicle document",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
             VehicleProfileCard(
              firstText: "Service Type",
              secondText: "Micro",
            ),
             VehicleProfileCard(
              firstText: "Brand (Auto Suggestion)",
              secondText: "BMW",
            ),
             VehicleProfileCard(
              firstText: "Model (Auto Suggestion)",
              secondText: "M4",
            ),
             VehicleProfileCard(
              firstText: "Manufacture (Auto Suggestion)",
              secondText: "BMW",
            ),
             VehicleProfileCard(
              firstText: "Number Plate",
              secondText: "YT1234",
            ),
             VehicleProfileCard(
              firstText: "Color",
              secondText: "Blue",
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleProfileCard extends StatelessWidget {
  final String firstText;
  final String secondText;
  const VehicleProfileCard({
    super.key,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: Color.fromARGB(76, 109, 241, 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            firstText,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            secondText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
