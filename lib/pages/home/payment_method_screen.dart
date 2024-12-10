import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/add_card_screen.dart';
import 'package:rider/resources/colors.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.05),
            const Text(
              "Choose your preferred payment method",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            _buildCustomTile(
              icon: FontAwesomeIcons.moneyBill1,
              title: "Cash",
              iconColor: Colors.greenAccent,
            ),
            _buildCustomTile(
              icon: FontAwesomeIcons.ccMastercard,
              title: "**** **** ****78",
              iconColor: Colors.orange,
              subTitle: const Text(
                "Expires 05/2027",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            _buildCustomTile(
              icon: FontAwesomeIcons.ccVisa,
              title: "**** **** ****42",
              iconColor: Colors.blue,
              subTitle: const Text(
                "Expires 05/2027",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              onTap: ()=> Get.to(()=> AddCardScreen()),
              leading: const FaIcon(
                FontAwesomeIcons.creditCard,
                color: AppColors.primaryColor,
              ),
              title: const Text(
                "Add Payment Card",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildCustomTile({
    required IconData icon,
    required String title,
    Widget? subTitle,
    required Color iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: FaIcon(
            icon,
            color: iconColor,
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          subtitle: subTitle,
        ),
        const Divider(),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      title: const Text(
        "Payment Method",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
