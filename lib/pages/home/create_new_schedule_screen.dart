import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/pages/home/schedule_payment_screen.dart';
import 'package:rider/service/location_service.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';
import 'package:rider/widgets/snack_bar.dart';

class CreateNewScheduleScreen extends StatelessWidget {
  CreateNewScheduleScreen({super.key});

  final _userController = Get.find<UserController>();

  final _fromLocationController = TextEditingController();
  final _fromLocationAddress = "".obs;
  final _toLocationController = TextEditingController();
  final _toLocationAddress = "".obs;
  final Rx<LatLng> _fromLocation = const LatLng(0.0, 0.0).obs;
  final Rx<LatLng> _toLocation = const LatLng(0.0, 0.0).obs;
  final RxString _paymentMethod = "".obs;

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

  void searchPlaces(String query, var list) async {
    List<Map<String, dynamic>> results =
        await LocationService.searchPlaces(query);
    list.value = results;
  }

  final RxList<Map<String, dynamic>> _places = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> _toPlaces = <Map<String, dynamic>>[].obs;

  Future<void> submitScheduledRide({
    required String paymentMethod,
    required Rx<LatLng> fromLocation,
    required Rx<LatLng> toLocation,
    required String fromAddress,
    required String toAddress,
    required Rxn<DateTime> selectedDate,
    required Rxn<TimeOfDay> selectedTime,
  }) async {
    try {
      if (fromAddress.isEmpty || toAddress.isEmpty) {
        CustomSnackbar.showErrorSnackBar(
          "Please select both pick-up and drop-off locations!",
        );
        return;
      }
      if (selectedDate.value == null || selectedTime.value == null) {
        CustomSnackbar.showErrorSnackBar("Please select both date and time!");
        return;
      }
      if (paymentMethod.isEmpty) {
        CustomSnackbar.showErrorSnackBar("Please select payment method!");
        return;
      }

      DateTime selectedDateTime = DateTime(
        selectedDate.value!.year,
        selectedDate.value!.month,
        selectedDate.value!.day,
        selectedTime.value!.hour,
        selectedTime.value!.minute,
      );

      String scheduledTimeUtc = selectedDateTime.toUtc().toIso8601String();
      print("🚀 Scheduled Time: $scheduledTimeUtc");

      Map<String, dynamic> rideData = {
        "pickup_location": {
          "lat": fromLocation.value.latitude,
          "lng": fromLocation.value.latitude,
          "address": fromAddress,
        },
        "dropoff_location": {
          "lat": toLocation.value.latitude,
          "lng": toLocation.value.latitude,
          "address": toAddress,
        },
        "is_scheduled": true,
        "scheduled_time": scheduledTimeUtc,
        "payment_method": paymentMethod,
      };

      await _userController.scheduleRide(rideData: rideData);
    } catch (e) {
      debugPrint(e.toString());
    }
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
              textController: _fromLocationController,
              onChanged: (value) {
                searchPlaces(value, _places);
              },
              prefixIcon: Icons.location_searching_rounded,
            ),
            _buildAutoComplete(
              controller: _fromLocationController,
              location: _fromLocation,
              list: _places,
              address: _fromLocationAddress,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              hintText: "Your Destination",
              textController: _toLocationController,
              prefixIcon: Icons.location_on_outlined,
              onChanged: (value) {
                searchPlaces(value, _toPlaces);
              },
            ),
            _buildAutoComplete(
              controller: _toLocationController,
              location: _toLocation,
              list: _toPlaces,
              address: _toLocationAddress,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    _selectDate.value = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025, 12, 31),
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
                InkWell(
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
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Obx(
              () => RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(
                  horizontal: -4,
                  vertical: -4,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                title: const Text("Cash"),
                value: "cash",
                groupValue: _paymentMethod.value,
                onChanged: (value) {
                  _paymentMethod.value = value!;
                },
              ),
            ),
            Obx(
              () => RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: const Text("Stripe"),
                value: "stripe",
                visualDensity: const VisualDensity(
                  horizontal: -4,
                  vertical: -4,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: _paymentMethod.value,
                onChanged: (value) {
                  _paymentMethod.value = value!;
                },
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => CommonButton(
                ontap: () async {
                  await submitScheduledRide(
                    paymentMethod: _paymentMethod.value,
                    fromLocation: _fromLocation,
                    toLocation: _toLocation,
                    fromAddress: _fromLocationAddress.value,
                    toAddress: _toLocationAddress.value,
                    selectedDate: _selectDate,
                    selectedTime: _selectTime,
                  );
                },
                child: _userController.isScheduleLoading.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Search Result",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            _recentSearched(),
          ],
        ),
      ),
    );
  }

  Obx _buildAutoComplete({
    required TextEditingController controller,
    required Rx<LatLng> location,
    required list,
    required RxString address,
  }) {
    return Obx(
      () => list.isEmpty
          ? const SizedBox.shrink()
          : ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                String title = list[index]["name"];
                String lat = list[index]["lat"];
                String lng = list[index]["lon"];
                return ListTile(
                  onTap: () {
                    controller.clear();
                    controller.text += title;
                    _places.clear();

                    location.value = LatLng(
                      double.parse(lat),
                      double.parse(lng),
                    );

                    address.value = title;
                    list.clear();
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.timelapse_sharp),
                  title: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
    );
  }

  ListView _recentSearched() {
    return ListView.builder(
      itemCount: 2,
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
