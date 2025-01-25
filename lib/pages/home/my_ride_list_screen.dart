import 'package:rider/pages/auth/sign_up_screen.dart';
import 'package:rider/pages/chat/chat_screen.dart';
import 'package:rider/pages/home/request_history_screen.dart';
import 'package:rider/pages/settings/faq_screen.dart';
import 'package:rider/pages/settings/setting_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/pages/booking/list_card_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyRideListScreen extends StatelessWidget {
  MyRideListScreen({super.key});

  final RxBool _isOfflineList = true.obs;
  final RxBool _isOnlineList = false.obs;

  final _pageController = Get.put(PageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingButton(context: context),
      backgroundColor: Colors.black,
      drawer: _buildSideBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: Get.height / 10.5),
            Row(
              children: [
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                      print("Sidebar opened");
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.menu),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 47,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              _isOnlineList.value = false;
                              if (!_isOfflineList.value) {
                                _isOfflineList.value = !_isOfflineList.value;
                                _pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 450),
                                  curve: Curves.ease,
                                );
                              }
                            },
                            child: Container(
                              height: 40,
                              width: Get.width / 2.55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: _isOfflineList.value ? Colors.red : null,
                              ),
                              child: Text(
                                "Offline",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _isOfflineList.value
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              _isOfflineList.value = false;
                              if (!_isOnlineList.value) {
                                _isOnlineList.value = !_isOnlineList.value;
                                _pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 450),
                                  curve: Curves.ease,
                                );
                              }
                            },
                            child: Container(
                              height: 40,
                              width: Get.width / 2.55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: _isOnlineList.value
                                    ? AppColors.primaryColor
                                    : null,
                              ),
                              child: Text(
                                "Online",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _isOnlineList.value
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  const EmptyListWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.builder(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return const ListCardWidget();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildSideBar() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 19, 19, 19),
            ),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: SvgPicture.asset(
                    "assets/images/placeholder.svg",
                    width: 65,
                  ),
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
              Get.to(() => SettingScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text(
              'Request History',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Get.to(() => RequestHistoryScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text(
              'Inbox',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Get.to(() => ChatScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_support_rounded),
            title: const Text(
              'FAQ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Get.to(() => FaqScreen());
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
              Get.offAll(() => SignUpScreen());
            },
          ),
        ],
      ),
    );
  }

  FloatingActionButton _buildFloatingButton({
    required BuildContext context,
  }) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 200,
              width: Get.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: Color(0xff22272B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Today’s Summary",
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Total Trip",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.car,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "10 Trips",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Total Trip",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.wallet,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "₦5,456.00",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      backgroundColor: AppColors.primaryColor,
      child: Image.asset(
        "assets/images/float.png",
        width: 25,
      ),
    );
  }
}

class ListCardWidget extends StatelessWidget {
  const ListCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ListCardDetailsScreen());
      },
      child: Container(
        height: 200,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: Colors.white,
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
                        color: Colors.white,
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
                        color: Colors.white,
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
                        color: Colors.white,
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
            const Divider(color: Colors.white),
            const SizedBox(height: 10),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SvgPicture.asset(
                    "assets/images/placeholder.svg",
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Joe Dough",
                      style: TextStyle(
                        color: Colors.white,
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
                const Text(
                  "Just now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
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

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/loc.svg",
          width: 250,
        ),
        const SizedBox(height: 15),
        Text(
          "Turn your location on",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Your location info is needed to find the ride\nrequests in your current area",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: Get.height / 10)
      ],
    );
  }
}
