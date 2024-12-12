import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
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
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "New Password",
              textController: _newPassword,
              prefixIcon: Icons.lock,
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "Confirm Password",
              textController: _confirmPassword,
              prefixIcon: Icons.lock,
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 30),
            CommonButton(
              text: "Save",
              ontap: () {},
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Change Password",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
    );
  }
}
