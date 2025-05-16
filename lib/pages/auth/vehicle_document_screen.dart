import 'package:rider/pages/auth/vehicle_document_screen_2.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleDocumentScreen extends StatelessWidget {
  VehicleDocumentScreen({super.key});

  final _serviceTypeController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _manufactureController = TextEditingController();
  final _numberController = TextEditingController();
  final _colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // bottomSheet: _buildBottomSheet(),
      appBar: AppBar(
        title: const Text(
          "Vehicle Document",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height / 12.5),
              CustomTextField(
                hintText: "Service Type",
                textController: _serviceTypeController,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: "Brand (Auto Suggestion)",
                textController: _brandController,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: "Model (Auto Suggestion)",
                textController: _modelController,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: "Manufacture (Auto Suggestion)",
                textController: _manufactureController,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: "Number Plate",
                textController: _numberController,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: "Color",
                textController: _colorController,
              ),
              const SizedBox(height: 34),
              CommonButton(
                text: "Next",
                ontap: () {
                  Get.to(() => VehichleDocumentScreen2());
                },
              ),
              const SizedBox(height: 34),
            ],
          ),
        ),
      ),
    );
  }

  // Container _buildBottomSheet() {
  //   return Container(
  //     height: 120,
  //     alignment: Alignment.center,
  //     padding: const EdgeInsets.symmetric(horizontal: 20),
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.only(
  //         topRight: Radius.circular(20),
  //         topLeft: Radius.circular(20),
  //       ),
  //       color: Color.fromARGB(255, 22, 22, 22),
  //     ),
  //     child: CommonButton(
  //       text: "Next",
  //       ontap: () {
  //         Get.to(() => VehichleDocumentScreen2());
  //       },
  //     ),
  //   );
  // }


}
