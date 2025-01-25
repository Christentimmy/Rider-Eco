import 'package:rider/resources/color_resources.dart';
import 'package:rider/widget/custom_button.dart';
import 'package:rider/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WithdrawScreen extends StatelessWidget {
  WithdrawScreen({super.key});

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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/access.png"),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Christen Timmy",
                        style: const TextStyle(
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
            Text(
              "Enter Amount",
              style: TextStyle(
                fontSize: 15,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 5),
            CustomTextField(
              hintText: "Enter Amount",
              textStyle: TextStyle(color: Colors.white),
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
              text: "Withdraw",
              ontap: () {
                displayDiaogBox(context);
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
        "Withdraw Earnings",
        style: TextStyle(
          fontSize: 15,
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
