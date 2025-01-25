import 'package:rider/pages/home/ride_details_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestHistoryScreen extends StatelessWidget {
  RequestHistoryScreen({super.key});

  final RxInt _currentPage = 0.obs;
  final RxBool _isExpand = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            _buildDayWeekNav(),
            const SizedBox(height: 30),
            _buildRequestFilterCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestFilterCards() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      constraints: BoxConstraints(
        minHeight: 55,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
      ),
      child: Column(
        children: [
          _buildFilterHeader(),
          Obx(
            () {
              if (_isExpand.value) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildFirstTile(
                      amount: "\$500.00",
                      time: "08:00 - 10:00",
                    ),
                    _buildSecondTile(
                      amount: "\$30.00",
                      time: "09:00 - 12:00",
                    ),
                    _buildFirstTile(
                      amount: "\$900.00",
                      time: "10:00 - 2:00",
                    ),
                    _buildSecondTile(
                      amount: "\$1000.00",
                      time: "02:00 - 6:00",
                    ),
                    _buildFirstTile(
                      amount: "\$500.00",
                      time: "08:00 - 10:00",
                    ),
                    _buildSecondTile(
                      amount: "\$30.00",
                      time: "09:00 - 12:00",
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          )
        ],
      ),
    );
  }

  Row _buildFilterHeader() {
    return Row(
      children: [
        Column(
          children: [
            Text(
              "26.09",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              "Done: 1",
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 13,
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          "\$50.00",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 10),
        Obx(
          () => IconButton(
            onPressed: () => _isExpand.value = !_isExpand.value,
            icon: _isExpand.value
                ? Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.white,
                  ),
          ),
        ),
      ],
    );
  }

  Padding _buildSecondTile({
    required String time,
    required String amount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      child: Row(
        children: [
          Text(
            time,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Spacer(),
          Text(
            amount,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFirstTile({
    required String time,
    required String amount,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(() => RideDetailsScreen());
      },
      child: Container(
        height: 40,
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        child: Row(
          children: [
            Text(time),
            Spacer(),
            Text(amount),
          ],
        ),
      ),
    );
  }

  Container _buildDayWeekNav() {
    return Container(
      height: 55,
      width: Get.width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffF4F5FA),
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => GestureDetector(
                onTap: () => _currentPage.value = 0,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        _currentPage.value == 0 ? AppColors.primaryColor : null,
                  ),
                  child: Text(
                    "Day",
                    style: TextStyle(
                      color:
                          _currentPage.value == 0 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => GestureDetector(
                onTap: () => _currentPage.value = 1,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        _currentPage.value == 1 ? AppColors.primaryColor : null,
                  ),
                  child: Text(
                    "Week",
                    style: TextStyle(
                      color:
                          _currentPage.value == 1 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      title: Text(
        "Request History",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
