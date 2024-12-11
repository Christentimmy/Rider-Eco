import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rider/pages/home/schedule_payment_screen.dart';
import 'package:rider/widgets/custom_textfield.dart';

class CreateNewScheduleScreen extends StatelessWidget {
  CreateNewScheduleScreen({super.key});

  final _yourPickUpLocation = TextEditingController();

  final Rxn<DateTime> _selectDate = Rxn<DateTime>();
  final Rxn<TimeOfDay> _selectTime = Rxn<TimeOfDay>();

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    return DateFormat('hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "Your Pick-Up Location",
              textController: _yourPickUpLocation,
              prefixIcon: Icons.location_searching_rounded,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              hintText: "Your Destination",
              textController: _yourPickUpLocation,
              prefixIcon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    _selectDate.value = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                      initialDate: DateTime.now(),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month),
                        const SizedBox(width: 10),
                        Obx(
                          () => Text(
                            _selectDate.value != null
                                ? DateFormat("MMM dd yyyy")
                                    .format(_selectDate.value!)
                                : "DD-MM-YYYY",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    _selectTime.value = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    print(_selectTime.value);
                  },
                  child: Container(
                    height: 50,
                    width: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.timelapse),
                        const SizedBox(width: 10),
                        Obx(
                          () => Text(
                            _selectTime.value != null
                                ? formatTimeOfDay(_selectTime.value!)
                                : "HH:MM",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),
            Text(
              "Search Result",
              style: TextStyle(
                fontSize: 17,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            _recentSearched(),
          ],
        ),
      ),
    );
  }

  ListView _recentSearched() {
    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => Get.to(() => SchedulePaymentScreen()),
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.location_on_outlined),
          ),
          title: const Text(
            "Soft Bank",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("364 Stillwater Ave. Attleboro"),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Create New Schedule",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
    );
  }
}
