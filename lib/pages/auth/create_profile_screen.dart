import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rider/controller/auth_controller.dart';
import 'package:rider/models/user_model.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/utils/image_picker.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';
import 'package:rider/widgets/loader.dart';
import 'package:rider/widgets/snack_bar.dart';

class CreateProfileScreen extends StatelessWidget {
  CreateProfileScreen({super.key});

  final Rxn<DateTime> _selectedDate = Rxn<DateTime>();

  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // Customize button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      _selectedDate.value = pickedDate;
    }
  }

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _homeAddressController = TextEditingController();
  final _dobController = TextEditingController();
  final Rxn<File> _image = Rxn<File>();
  final _fomrKey = GlobalKey<FormState>();

  final _authController = Get.find<AuthController>();

  void selectImageForUser() async {
    File? im = await pickImage();
    if (im != null) {
      _image.value = im;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Create Your Profile",
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _fomrKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildimagePicker(),
                SizedBox(height: Get.height * 0.05),
                CustomTextField(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  hintText: "First Name",
                  textController: _firstNameController,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  hintText: "Last Name",
                  textController: _lastNameController,
                ),
                const SizedBox(height: 15),
                Obx(
                  () => CustomTextField(
                    validator: (value) {
                      return null;
                    },
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    readOnly: true,
                    hintText: _selectedDate.value != null
                        ? DateFormat("MMM dd yyyy").format(_selectedDate.value!)
                        : "Date of birth",
                    suffixIcon: Icons.calendar_month,
                    textController: _dobController,
                    onSuffixClick: () {
                      selectDateOfBirth(context);
                    },
                  ),
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  hintText: "Home Address",
                  suffixIcon: Icons.location_on,
                  textController: _homeAddressController,
                ),
                SizedBox(height: Get.height * 0.15),
                Obx(
                  () => CommonButton(
                    child: _authController.isLoading.value
                        ? const CarLoader()
                        : const Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                    ontap: () async {
                      await completeUserProfile();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildimagePicker() {
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
                    ? Image.file(
                        _image.value!,
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(
                        "assets/images/placeholder.svg",
                      ),
              ),
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
                  selectImageForUser();
                },
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

  Future<void> completeUserProfile() async {
    if (_authController.isLoading.value) {
      return;
    }
    if (!_fomrKey.currentState!.validate()) {
      return;
    }
    if (_image.value == null) {
      CustomSnackbar.showErrorSnackBar("Image Required");
      return;
    }
    if (_selectedDate.value == null) {
      CustomSnackbar.showErrorSnackBar("Date of Birth Required");
      return;
    }
    const maxFileSize = 5 * 1024 * 1024; // 5 MB
    if (_image.value!.lengthSync() > maxFileSize) {
      CustomSnackbar.showErrorSnackBar("Image size must be less than 5 MB");
      return;
    }
    final userModel = UserModel(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      address: _homeAddressController.text,
      dob: DateFormat("MMM dd yyyy").format(_selectedDate.value!),
    );
    await _authController.completeProfileScreen(
      userModel: userModel,
      imageFile: _image.value!,
    );
  }
}
