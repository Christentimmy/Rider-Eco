import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/waiting_ride_screen.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/widgets/build_icon_button.dart';
import 'package:rider/widgets/custom_button.dart';

class AvailableVehiclesScreen extends StatelessWidget {
  const AvailableVehiclesScreen({super.key});

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
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // showModalBottomSheet(
              //   context: context,
              //   builder: (context) {
              //     return EachCarDetails();
              //   },
              // );
              showBottomSheet(
                context: context,
                builder: (context) {
                  return const EachCarDetails();
                },
              );
            },
            child: const CarCards(),
          );
        },
      ),
    );
  }
}

class CarCards extends StatelessWidget {
  const CarCards({
    super.key,
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
          const Row(
            children: [
              Text(
                "4 - Seater",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Spacer(),
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
      height: Get.height * 0.75,
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
          const Row(
            children: [
              Text("From"),
              SizedBox(width: 30),
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
              Get.to(()=> const WaitingRideScreen());
            },
          )
        ],
      ),
    );
  }
}
