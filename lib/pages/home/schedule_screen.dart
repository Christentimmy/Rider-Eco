import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/models/ride_model.dart';
import 'package:rider/pages/home/create_new_schedule_screen.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/utils/date_converter.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    if (!_userController.isScheduleFetched.value) {
      _userController.getUserScheduledRides();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildSideBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateNewScheduleScreen());
        },
        child: const Icon(Icons.add),
      ),
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                List<Ride> userSchedules = _userController.userScheduleList;
                List sorted = userSchedules
                    .where((e) => (e.isScheduled == true &&
                        (e.status == "failed" || e.status == "schedule")))
                    .toList();
                if (_userController.isloading.value) {
                  return CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  );
                } else if (sorted.isEmpty) {
                  return const Center(
                    child: Text(
                      "Empty Schedule",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: sorted.length,
                    itemBuilder: (context, index) {
                      Ride schedule = sorted[index];
                      return _buildFilterCards(ride: schedule);
                    },
                  );
                }
              }),
            ),
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

  InkWell _buildFilterCards({
    required Ride ride,
  }) {
    return InkWell(
      onTap: () {
        // Get.to(() => const ScheduleDetailsScreen());
      },
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  ride.pickupLocation?.address != null &&
                          ride.pickupLocation!.address.length > 20
                      ? "${ride.pickupLocation!.address.substring(0, 19)}..."
                      : ride.pickupLocation!.address,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
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
                Text(
                  ride.dropoffLocation?.address != null &&
                          ride.dropoffLocation!.address.length > 22
                      ? "${ride.dropoffLocation!.address.substring(0, 21)}..."
                      : ride.dropoffLocation!.address,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  convertDateToNormal(ride.scheduledTime.toString()),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 41, 117, 43),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
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
                  child: Text(
                    ride.scheduleStatus.toString(),
                    style: const TextStyle(
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
