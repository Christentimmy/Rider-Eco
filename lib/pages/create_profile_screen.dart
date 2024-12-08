import 'dart:typed_data';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/utils/image_picker.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';

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
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor, // Customize the primary color
              onPrimary: Colors.white, // Text color on selected date
              onSurface: Colors.black, // Default text color
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
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();

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
      bottomSheet: Container(
        height: 90,
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
          text: "Continue",
          ontap: () {
            // Get.to(() => BankDetailsScreen());
          },
        ),
      ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
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
            ),
            SizedBox(height: Get.height * 0.05),
            CustomTextField(
              hintText: "First Name",
              textController: _firstNameController,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              hintText: "Last Name",
              textController: _lastNameController,
            ),
            const SizedBox(height: 15),
            Obx(
              () => CustomTextField(
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
              hintText: "Email",
              suffixIcon: Icons.email,
              textController: _emailController,
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                ),
              ),
              child: Row(
                children: [
                  CountryCodePicker(
                    onChanged: (value) {
                      print(value);
                    },
                    initialSelection: '+234',
                    textStyle: const TextStyle(color: Colors.white),
                    barrierColor: Colors.transparent,
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    // optional. aligns the flag and the Text left
                    alignLeft: false,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Mobile number",
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            CustomTextField(
              hintText: "Home Address",
              suffixIcon: Icons.location_on,
              textController: _homeAddressController,
            ),
          ],
        ),
      ),
    );
  }
}
