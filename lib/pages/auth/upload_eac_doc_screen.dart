import 'dart:io';
import 'package:rider/utils/image_picker.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UploadEacDocScreen extends StatelessWidget {
  final String title;
  UploadEacDocScreen({
    super.key,
    required this.title,
  });

  final Rxn<File> _image = Rxn<File>();

  void _pickImage() async {
    final im = await pickImage();
    if (im != null) {
      _image.value = im;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.05),
            Center(
              child: Text(
                "Please take a clear photo of the\nentire document",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => GestureDetector(
                onTap: _pickImage,
                child: SizedBox(
                  height: Get.height * 0.6,
                  width: Get.width,
                  child: _image.value != null
                      ? Image.file(
                          _image.value!,
                          fit: BoxFit.cover,
                          height: Get.height * 0.6,
                        )
                      : SvgPicture.asset(
                          "assets/images/placeholder.svg",
                          fit: BoxFit.cover,
                          height: Get.height * 0.6,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => SizedBox(
                width: Get.width * 0.6,
                child: CommonButton(
                  text: _image.value == null ? "Take a photo" : "Upload Photo",
                  ontap: () {
                    _pickImage();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
