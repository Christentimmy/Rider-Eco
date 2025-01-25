import 'package:rider/resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateAndDistanceScreen extends StatelessWidget {
  DateAndDistanceScreen({super.key});

  final RxBool _isValue = false.obs;
  final RxBool _isCeckBoxValue = true.obs;
  final RxBool _isCeckBoxValue1 = false.obs;

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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.03),
            ListTile(
              title: Text(
                "24-Hour Time",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              trailing: Obx(
                () => Switch(
                  value: _isValue.value,
                  onChanged: (value) {
                    _isValue.value = value;
                  },
                ),
              ),
            ),
            const SizedBox(height: 50),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        height: 170,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 44, 44, 44),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Distance",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Divider(color: Colors.white),
                            Row(
                              children: [
                                const Text(
                                  "Kilometer",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                Obx(
                                  () => Checkbox(
                                    value: _isCeckBoxValue.value,
                                    onChanged: (value) {
                                      _isCeckBoxValue1.value = false;
                                      _isCeckBoxValue.value = value!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Miles",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                Obx(
                                  () => Checkbox(
                                    value: _isCeckBoxValue1.value,
                                    onChanged: (value) {
                                      _isCeckBoxValue.value = false;
                                      _isCeckBoxValue1.value = value!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Distance",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Obx(
                    () => Text(
                      _isCeckBoxValue.value ? "Kilometer" : "Miles",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
