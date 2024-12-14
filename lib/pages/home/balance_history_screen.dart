import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/history_rode_details.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';

class BalanceAndHistoryScreen extends StatelessWidget {
  BalanceAndHistoryScreen({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildSideBar(),
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomTextField(
                    borderRadius: BorderRadius.circular(8),
                    height: 40,
                    hintText: "Search",
                    textController: _searchController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CommonButton(
                    height: 40,
                    text: "Status",
                    bgColor: Colors.white,
                    textColor: AppColors.primaryColor,
                    border: Border.all(
                      width: 1,
                      color: AppColors.primaryColor,
                    ),
                    ontap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    height: 40,
                    hintText: "Search",
                    textController: _searchController,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CommonButton(
                    height: 40,
                    text: "Reset Filter",
                    ontap: () {},
                    bgColor: const Color.fromARGB(255, 41, 117, 43),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 20),
            _filterCardsBudget(),
          ],
        ),
      ),
    );
  }

  Widget _filterCardsBudget() {
    return InkWell(
      onTap: (){
        Get.to(()=> HistoryRodeDetails());
      },
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(0.6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "June 3, 2021  12:30pm",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 30,
                  width: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 59, 126, 4),
                  ),
                  child: const Text(
                    "Trip in 2days",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 5,
              minTileHeight: 35,
              title: Text(
                "Ikeja City Mall, Alausa Road, Ikeja",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              leading: Icon(
                Icons.location_pin,
                color: Color.fromARGB(255, 68, 145, 5),
              ),
            ),
            const Divider(),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 5,
              minTileHeight: 35,
              title: Text(
                "Shoprite Event Centre, Ikeja",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              leading: Icon(
                Icons.location_pin,
                color: Color.fromARGB(255, 68, 145, 5),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 15),
                        children: [
                          const TextSpan(
                            text: "Driver: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Christen Junior",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 15),
                        children: [
                          const TextSpan(
                            text: "Status: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Completed",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(), // Add space between the two columns
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 15),
                        children: [
                          TextSpan(
                            text: "Rating: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "⭐⭐⭐⭐⭐",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 15),
                        children: [
                          const TextSpan(
                            text: "Trip ID: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "TRP24002",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 55,
                  width: 165,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Price: ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("\$5000"),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Trip duration: ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("20mins"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Balance & History",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
            ),
          );
        },
      ),
    );
  }
}
