import 'package:flutter/material.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:get/get.dart';

class InviteFriendsScreen extends StatelessWidget {
  InviteFriendsScreen({super.key});

  final RxBool _isValue = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Friends",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            height: 43,
            width: 150,
            margin: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  const Color.fromARGB(137, 78, 78, 78),
                ],
              ),
            ),
            child: Text(
              "Invite Friends",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(143, 158, 158, 158),
              ),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 3,
                    leading: CircleAvatar(
                      radius: 24,
                    ),
                    title: Text(
                      "Maryland John",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      "+1-300-555-0135",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Obx(
                      () => _isValue.value
                          ? Container(
                              height: 35,
                              width: 90,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color.fromARGB(255, 78, 184, 81),
                              ),
                              child: Text(
                                "Invite",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(
                              height: 35,
                              width: 90,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black,
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              child: Text(
                                "Invited",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
