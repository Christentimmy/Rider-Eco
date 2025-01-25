import 'package:rider/resources/color_resources.dart';
import 'package:rider/pages/auth/personal_document_screen.dart';
import 'package:rider/widget/custom_button.dart';
import 'package:rider/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankDetailsScreen extends StatelessWidget {
  BankDetailsScreen({super.key});

  final _bankNameController = TextEditingController();
  final _accountHolderController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _swiftController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height / 8.5),
              _buildTextFieldsForBankDetails(),
              const SizedBox(height: 25),
              _buildPolicyText(),
              SizedBox(height: Get.height * 0.2),
              CommonButton(
                text: "Next",
                ontap: () {
                  Get.to(() => PersonalDocumentScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center _buildPolicyText() {
    return Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text:
                          "By continuing, I confirm that I have read & agree to the\n",
                    ),
                    TextSpan(
                      text: "Terms & conditions",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const TextSpan(
                      text: " and ",
                    ),
                    TextSpan(
                        text: "Privacy policy",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        )),
                  ],
                ),
              ),
            );
  }

  Form _buildTextFieldsForBankDetails() {
    return Form(
              child: Column(
                children: [
                  CustomTextField(
                    hintText: "Bank Name",
                    textController: _bankNameController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: "Account Holder Name",
                    textController: _accountHolderController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: "Account Number",
                    textController: _accountNumberController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: "Swift/FSC code",
                    textController: _swiftController,
                  ),
                ],
              ),
            );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Bank Details",
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
    );
  }
}
