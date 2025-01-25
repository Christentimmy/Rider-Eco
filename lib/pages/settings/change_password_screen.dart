import 'package:rider/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Password",
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
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
            SizedBox(height: Get.height * 0.03),
            CustomTextField(
              hintText: "Current Password",
              textController: _currentPassword,
              prefixIcon: Icons.lock,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "New Password",
              textController: _newPassword,
              prefixIcon: Icons.lock,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "Confirm Password",
              textController: _confirmPassword,
              prefixIcon: Icons.lock,
            ),
          ],
        ),
      ),
    );
  }
}
