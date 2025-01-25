import 'package:rider/resources/color_resources.dart';
import 'package:rider/widget/custom_button.dart';
import 'package:rider/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardScreen extends StatelessWidget {
  AddCardScreen({super.key});

  final _accountNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Add Card",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.05),
              Text(
                "Account Name",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hintText: "Enter Name",
                textController: _accountNameController,
              ),
              const SizedBox(height: 30),
              Text(
                "Bank Name",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 55,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                child: ListTile(
                  trailing: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Select bank",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Account Number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hintText: "Enter Account Number",
                textController: _accountNameController,
              ),
              const SizedBox(height: 10),
              CommonButton(text: "Save", ontap: (){}),
            ],
          ),
        ),
      ),
    );
  }
}
