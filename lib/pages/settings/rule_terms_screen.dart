import 'package:rider/resources/color_resources.dart';
import 'package:rider/pages/settings/license_screen.dart';
import 'package:rider/pages/settings/privacy_policy_screen.dart';
import 'package:rider/pages/settings/terms_condition_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RuleAndTermsScreen extends StatelessWidget {
  const RuleAndTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Date and Distance",
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
            ListTile(
              onTap: () {
                Get.to(() => TermsAndConditionScreen());
              },
              title: Text(
                "Terms & Conditions",
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => PrivacyPolicyScreen());
              },
              title: Text(
                "Privacy & Policy",
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => LicenseScreen());
              },
              title: Text(
                "Licenses",
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
