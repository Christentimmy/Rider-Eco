import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/utils/image_picker.dart';
import 'package:rider/widgets/custom_button.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final Rxn<Uint8List> _image = Rxn<Uint8List>();

  void pickImage() async {
    Uint8List? im = await selectImageFromGallery(ImageSource.gallery);
    if (im != null) {
      _image.value = im;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.02),
              _buildImageWidget(),
              SizedBox(height: Get.height * 0.04),
              Text(
                "First Name",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: const Color(0xff001F3F8C).withOpacity(0.6),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "John",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Last Name",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: const Color(0xff001F3F8C).withOpacity(0.6),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Alfred",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Phone Number",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: const Color(0xff001F3F8C).withOpacity(0.6),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "+1 8619 228 992",
                  suffixIcon: Icon(Icons.cancel, color: Colors.red),
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Email Address",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: const Color(0xff001F3F8C).withOpacity(0.6),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "john@email.com",
                  suffixIcon: Icon(Icons.cancel, color: Colors.red),
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              CommonButton(
                text: "Save",
                ontap: () {
                  Get.offAll(() => HomeScreen());
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Center _buildImageWidget() {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(85),
              border: Border.all(
                width: 3,
                color: AppColors.primaryColor,
              ),
            ),
            child: Obx(
              () => ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: _image.value != null
                      ? Image.memory(
                          _image.value!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset("assets/images/avater2.png")),
            ),
          ),
          Positioned(
            right: 5,
            bottom: 5,
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.grey,
              child: IconButton(
                onPressed: () {
                  pickImage();
                },
                icon: const Icon(
                  Icons.camera,
                  size: 17,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Profile",
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
