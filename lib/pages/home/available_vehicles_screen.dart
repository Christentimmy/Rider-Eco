import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/models/driver_model.dart';
import 'package:rider/pages/home/waiting_ride_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/widgets/build_icon_button.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';

class AvailableVehiclesScreen extends StatefulWidget {
  final LatLng fromLocaton;
  const AvailableVehiclesScreen({
    super.key,
    required this.fromLocaton,
  });

  @override
  State<AvailableVehiclesScreen> createState() =>
      _AvailableVehiclesScreenState();
}

class _AvailableVehiclesScreenState extends State<AvailableVehiclesScreen> {
  final _userController = Get.find<UserController>();

  final _radiusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userController.getNearByDrivers(
      fromLocation: widget.fromLocaton,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Available vehicles",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          buildIconButton(
            icon: Icons.filter_list_rounded,
            onTap: () {},
            shape: BoxShape.circle,
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 7),
        ],
      ),
      body: Obx(() {
        if (_userController.isloading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (_userController.availableDriverList.isEmpty) {
          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: Get.height * 0.5,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No available vehicles found.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    textController: _radiusController,
                    textInputType: TextInputType.number,
                    hintText: "Default Radius 2100, Increase the radius",
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Get.width / 1.5,
                    child: CommonButton(
                      child: const Text(
                        "Search",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ontap: () async {
                        if (_radiusController.text.isEmpty) {
                          return;
                        }
                        await _userController.getNearByDrivers(
                          fromLocation: widget.fromLocaton,
                          radius: int.parse(_radiusController.text),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: _userController.availableDriverList.length,
            itemBuilder: (context, index) {
              DriverModel driverModel =
                  _userController.availableDriverList[index];
              return InkWell(
                onTap: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      return const EachCarDetails();
                    },
                  );
                },
                child: CarCards(driverModel: driverModel),
              );
            },
          );
        }
      }),
    );
  }
}

class CarCards extends StatelessWidget {
  final DriverModel driverModel;
  const CarCards({
    super.key,
    required this.driverModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 148,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/images/image10.png",
                width: 100,
                height: 72,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Swift Dezire",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "DL16K5667",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text(
                "4 - Seater",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Text(
                "7/km",
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class EachCarDetails extends StatefulWidget {
  const EachCarDetails({
    super.key,
  });

  @override
  State<EachCarDetails> createState() => _EachCarDetailsState();
}

class _EachCarDetailsState extends State<EachCarDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      width: Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              "Cancel",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Image.asset(
              "assets/images/image10.png",
              width: 200,
            ),
          ),
          const Text(
            "Car",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wagnor",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Text(
                "4 Seats",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Text(
                "DL16K8667",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              const Text("From"),
              const SizedBox(width: 30),
              Text(
                "7/KM",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 35),
          const Text(
            "Driver",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Image.asset(
                "assets/images/avater2.png",
                height: 60,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Christen Timmy",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Atlanta, USA",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 15),
                      Icon(Icons.star, color: Colors.yellow, size: 15),
                      Icon(Icons.star, color: Colors.yellow, size: 15),
                      Icon(Icons.star, color: Colors.yellow, size: 15),
                      Icon(Icons.star, color: Colors.yellow, size: 15),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          CommonButton(
            text: "Select Vehicle",
            ontap: () {
              Get.to(() => const WaitingRideScreen());
            },
          )
        ],
      ),
    );
  }
}
