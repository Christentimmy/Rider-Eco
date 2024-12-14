import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/available_vehicles_screen.dart';
import 'package:rider/pages/home/notifcation_screen.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/widgets/build_icon_button.dart';
import 'package:rider/widgets/custom_button.dart';

class RequestRideScreen extends StatelessWidget {
  RequestRideScreen({super.key});

  final List _cars = [
    ["Comfort", "assets/images/blackcar.png"],
    ["10 Seater", "assets/images/yellowcar.png"],
    ["BMW", "assets/images/image10.png"],
    ["Dodge", "assets/images/image11.png"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/map.png",
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
          ),
          _buildNavBar(),
          _buildBottomWidget(),
          _buildCarDisplays(),
        ],
      ),
    );
  }

  Align _buildCarDisplays() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 180,
        margin: EdgeInsets.only(bottom: Get.height * 0.38),
        child: ListView.builder(
          itemCount: _cars.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: 230,
              height: 180,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildBackgroundCar(
                      title: _cars[index][0],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 10,
                    child: Image.asset(
                      _cars[index][1],
                      width: 150,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Container _buildBackgroundCar({
    required String title,
  }) {
    return Container(
      height: 150,
      width: 230,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      // margin: EdgeInsets.only(bottom: Get.height * 0.38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 56,
                width: 180,
                decoration: const BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const Text(
                  "\$556.00",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "3-mins away",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar() {
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.1),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          buildIconButton(
            icon: Icons.arrow_back,
            onTap: () => Get.back(),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Get.to(() => NotificationScreen());
            },
            child: Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.notifications_active,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.36,
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
            _buildListTile(
              title: "Ikeja City Mall, Alausa Road, Ikeja",
              icon: Icons.location_searching_sharp,
            ),
            _buildListTile(
              title: "Shoprite Event Centre, Ikeja",
              icon: Icons.location_on,
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  "Price:  ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  "\$50000.0",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              children: [
                Text(
                  "Trip duration:  ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  "32 minutes",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CommonButton(
              text: "Request",
              ontap: () {
                Get.to(()=> AvailableVehiclesScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile({
    required String title,
    required IconData icon,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minTileHeight: 40,
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
