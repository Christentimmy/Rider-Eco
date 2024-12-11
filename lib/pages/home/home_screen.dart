import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/balance_history_screen.dart';
import 'package:rider/pages/home/schedule_screen.dart';
import 'package:rider/pages/home/soure_destination_screen.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/widgets/build_icon_button.dart';
import 'package:rider/widgets/custom_textfield.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildSideBar(),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/map.png",
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 50,
                ),
                child: buildIconButton(
                  icon: Icons.menu,
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              );
            },
          ),
          _buildBottomWidget(),
        ],
      ),
    );
  }

  Widget _buildBottomWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.389,
        width: Get.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff22272B),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Good Morning, John",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              "Where are you going today?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: "Search destination",
              textController: _textController,
              bgColor: Colors.white.withOpacity(0.3),
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 15),
            _buildListTile(),
            _buildListTile(),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile() {
    return ListTile(
      onTap: () => Get.to(() => SoureDestinationScreen()),
      contentPadding: EdgeInsets.zero,
      minTileHeight: 40,
      leading: Container(
        height: 45,
        width: 45,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xff6CF102),
              Color(0xff3E8B01),
            ],
          ),
        ),
        child: Icon(
          Icons.location_on,
          color: Colors.white,
        ),
      ),
      title: const Text(
        "Ikeja City Mall",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        "Obafemi Awolowo Way, Ikeja Nigeria",
        style: TextStyle(
          color: AppColors.primaryColor.withOpacity(0.4),
          fontSize: 12,
        ),
      ),
    );
  }
}

Drawer buildSideBar() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 19, 19, 19),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/avater2.png",
                width: 60,
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Jonathon Smith",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        "4.8 (5000)",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).closeDrawer();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  );
                },
              )
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text(
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            // Get.to(() => SettingScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text(
            'Balance & History',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Get.to(() => BalanceAndHistoryScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.calendar_month),
          title: const Text(
            'Schedule',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Get.to(() => ScheduleScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.credit_card),
          title: const Text(
            'Payments',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            // Get.to(() => ChatScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            // Get.to(() => FaqScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.support_agent),
          title: const Text(
            'Support',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            // Get.to(() => FaqScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.contact_support_rounded),
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            // Get.offAll(() => SignUpScreen());
          },
        ),
      ],
    ),
  );
}
