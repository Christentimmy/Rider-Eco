import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/utils/image_picker.dart';
import 'package:rider/widgets/custom_button.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final Rxn<File> _image = Rxn<File>();
  final _userController = Get.find<UserController>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void selectImageForUser() async {
    File? im = await pickImage();
    if (im != null) {
      _image.value = im;
    }
  }

  @override
  Widget build(BuildContext context) {
    firstNameController.text = _userController.userModel.value?.firstName ?? "";
    lastNameController.text = _userController.userModel.value?.lastName ?? "";
    phoneNumberController.text =
        _userController.userModel.value?.phoneNumber ?? "";
    emailController.text = _userController.userModel.value?.email ?? "";

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
              SizedBox(height: Get.height * 0.01),
              _buildImageWidget(),
              SizedBox(height: Get.height * 0.02),
              _buildTextField("First Name", firstNameController),
              _buildTextField("Last Name", lastNameController),
              _buildTextField("Phone Number", phoneNumberController),
              _buildTextField("Email Address", emailController),
              SizedBox(height: Get.height * 0.05),
              Obx(
                () => CommonButton(
                  child: _userController.isEditLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  ontap: () async {
                    await _userController.updateUserDetails(
                      firstName: firstNameController.text.trim(),
                      lastName: lastNameController.text.trim(),
                      phoneNumber: phoneNumberController.text.trim(),
                      email: emailController.text.trim(),
                      profilePicture: _image.value,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: const Color(0xff001F3F8C).withOpacity(0.6),
          ),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: const UnderlineInputBorder(),
            focusedBorder: const UnderlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
      ],
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
            child: Obx(() {
              if (_userController.isloading.value) {
                return const CircularProgressIndicator();
              }
              String image =
                  _userController.userModel.value?.profilePicture ?? "";
              return ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: _image.value != null
                    ? Image.file(
                        _image.value!,
                        fit: BoxFit.cover,
                      )
                    : Image.network(image),
              );
            }),
          ),
          Positioned(
            right: 5,
            bottom: 5,
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.grey,
              child: IconButton(
                onPressed: selectImageForUser,
                icon: Icon(
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
