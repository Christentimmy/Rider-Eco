import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/pages/home/trip_status_screen.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';

class PayScreen extends StatelessWidget {
  PayScreen({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.05),
            Container(
              height: 50,
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset("assets/images/access.png"),
                  FaIcon(
                    FontAwesomeIcons.ccVisa,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Christen Timmy",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "************45",
                        style: TextStyle(
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Enter Amount",
              style: TextStyle(
                fontSize: 15,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 5),
            CustomTextField(
              hintText: "Enter Amount",
              textStyle: const TextStyle(color: Colors.white),
              textController: _searchController,
              textInputType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Min of \$10",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                )
              ],
            ),
            SizedBox(height: Get.height * 0.1),
            CommonButton(
              text: "Pay",
              ontap: () {
                displayDiaogBox(context);
                Future.delayed(const Duration(seconds: 1), () {
                  Get.to(()=> TripStatusScreen());
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      title: const Text(
        "Make Payment",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<dynamic> displayDiaogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 45,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  "assets/images/suc.json",
                  width: 120,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "Withdraw Successful",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
