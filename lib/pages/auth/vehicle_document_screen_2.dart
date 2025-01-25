import 'package:rider/pages/auth/upload_eac_doc_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/pages/auth/personal_document_screen.dart';
import 'package:rider/pages/auth/set_up_finger_screen.dart';
import 'package:rider/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehichleDocumentScreen2 extends StatelessWidget {
  const VehichleDocumentScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomSheet: Container(
        height: 120,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          color: Color.fromARGB(255, 22, 22, 22),
        ),
        child: CommonButton(
          text: "Next",
          ontap: () {
            Get.to(() => const SetUpFingerScreen());
          },
        ),
      ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.05),
            UploadDocCard(
              firstText: "Rc Book",
              secondText: "Vehicle registration",
              ontap: () {
                Get.to(
                  () => UploadEacDocScreen(title: "Vehicle registration"),
                );
              },
            ),
            UploadDocCard(
              firstText: "INSURANCE POLICY",
              secondText: "A driving license is an official Id",
              ontap: () {
                Get.to(
                  () => UploadEacDocScreen(title: "INSURANCE POLICY"),
                );
              },
            ),
            UploadDocCard(
              firstText: "OWNER CERTIFICATE",
              secondText: "A passport is a travel document",
              ontap: () {
                Get.to(
                  () => UploadEacDocScreen(title: "OWNER CERTIFICATE"),
                );
              },
            ),
            UploadDocCard(
              firstText: "PUC",
              secondText: "Incorrect document type",
              ontap: () {
                Get.to(
                  () => UploadEacDocScreen(title: "PUC"),
                );
              },
            ),
            const SizedBox(height: 25),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text:
                          "By continuing, I confirm that I have read & agree to the\n",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: "Terms & conditions",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const TextSpan(
                        text: " and ",
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    TextSpan(
                      text: "Privacy policy",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
