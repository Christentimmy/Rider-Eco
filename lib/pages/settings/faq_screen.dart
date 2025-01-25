import 'package:rider/resources/color_resources.dart';
import 'package:rider/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "FAQ",
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.05),
            CustomTextField(
              hintText: "Search",
              textController: _searchController,
              prefixIcon: Icons.search,
            ),
            const SizedBox(height: 20),
            Text(
              "FAQ",
              style: TextStyle(
                fontSize: 17,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 120,
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 39, 39, 39),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How do I schedule an appointment?",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras scelerisque leo non dignissim blandit",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            FaqCard(text: "Can I reschedule or cancel appointments"),
            FaqCard(text: "How do I receive appointment reminders?"),
            FaqCard(text: "How do Checked Pre- Booked Appointments"),
            FaqCard(text: "How do I pay for appointments"),
            FaqCard(text: "How to add reviews?"),
          ],
        ),
      ),
    );
  }
}

class FaqCard extends StatelessWidget {
  final String text;
  const FaqCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: Get.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(255, 51, 51, 51),
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Icon(Icons.keyboard_arrow_down_outlined, color: Colors.grey),
        ],
      ),
    );
  }
}
