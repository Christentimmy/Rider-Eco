import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/create_new_schedule_screen.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/pages/home/schedule_details_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildSideBar(),
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "Create Schedule",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Create and book your schedule ahead to\navoid unnecessary hassles",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: Get.width / 1.7,
                child: CommonButton(
                  text: "New Schedule",
                  ontap: () {
                    Get.to(()=> CreateNewScheduleScreen());
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "Search",
              textController: _searchController,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    hintText: "Search",
                    textController: _searchController,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CommonButton(
                    text: "Reset Filter",
                    ontap: () {},
                    bgColor: const Color.fromARGB(255, 41, 117, 43),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 10),
            _buildFilterCards(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Schedules",
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

  InkWell _buildFilterCards() {
    return InkWell(
      onTap: () {
        Get.to(()=> const ScheduleDetailsScreen());
      },
      child: Container(
        // height: 200,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
             Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pickup Location",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "B Street 92025, CA - 3:00 to 3:15 PM",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "₹350",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "400m",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 9,
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Drop Off Location",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "SJC, Terminal B",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Text(
                  "Express",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "June 3, 2021  12:30pm",
                    style: TextStyle(
                      color: Color.fromARGB(255, 41, 117, 43),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "35 minutes",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  "assets/images/avater2.png",
                  width: 50,
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Joe Dough",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellowAccent,
                          size: 12,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "5 (38)",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  height: 35,
                  width: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xffEAB213),
                    ),
                  ),
                  child: const Text(
                    "Just now",
                    style: TextStyle(
                      color: Color(0xffEAB213),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
