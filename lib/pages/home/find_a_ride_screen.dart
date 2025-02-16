import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/request_ride_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/widgets/build_icon_button.dart';
import 'package:rider/widgets/custom_button.dart';

class FindARideScreen extends StatelessWidget {
  const FindARideScreen({super.key});

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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 50,
            ),
            child: buildIconButton(
              icon: Icons.arrow_back,
              onTap: () => Get.back(),
            ),
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
              text: "Find a ride",
              ontap: ()=> Get.to(()=> RequestRideScreen()),
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
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
