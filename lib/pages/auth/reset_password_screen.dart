import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rider/resources/colors.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final RxBool _isObscure = false.obs;
  final _passwordController = TextEditingController();
  final RxString _password = "".obs;

  bool containsSpecialCharacter(String password) =>
      password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  bool containsNumber(String password) => password.contains(RegExp(r'[0-9]'));

  bool isPasswordStrong(String password) =>
      password.length > 6 &&
      containsSpecialCharacter(password) &&
      containsNumber(password);

  Color getBarColor(bool conditionMet) =>
      conditionMet ? AppColors.primaryColor : Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Reset Password",
          style: TextStyle(
            color: Colors.white,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Get.height / 15.5),
              Center(
                child: SvgPicture.asset(
                  "assets/images/rec2.svg",
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Create strong and secure password that\nprotect your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => TextFormField(
                  obscureText: _isObscure.value,
                  controller: _passwordController,
                  onChanged: (e) {
                    _password.value = e;
                  },
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    hintText: "password",
                    prefixIcon: const Icon(Icons.lock, size: 15),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isObscure.value = !_isObscure.value;
                      },
                      icon: _isObscure.value
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(162, 126, 126, 126),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 2,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const SizedBox(width: 5),
                  Obx(
                    () {
                      final password = _password.value;
                      final hasMinLength = password.length >= 5;
                      final hasSixChars = password.length >= 6;
                      final hasSpecialChar = containsSpecialCharacter(password);
                      final hasNumber = containsNumber(password);

                      return Row(
                        children: [
                          // Bar 1: Minimum 5 characters
                          Container(
                            height: 5,
                            width: 45,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration:
                                BoxDecoration(color: getBarColor(hasMinLength)),
                          ),
                          // Bar 2: At least 6 characters
                          Container(
                            height: 5,
                            width: 45,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration:
                                BoxDecoration(color: getBarColor(hasSixChars)),
                          ),
                          // Bar 3: Special character
                          Container(
                            height: 5,
                            width: 45,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                                color: getBarColor(hasSpecialChar)),
                          ),
                          // Bar 4: Contains a number
                          Container(
                            height: 5,
                            width: 45,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: getBarColor(hasNumber && hasSpecialChar),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Obx(
                    () => _password.value.isEmpty
                        ? const Text("")
                        : Text(
                            isPasswordStrong(_password.value)
                                ? "Strong"
                                : "Weak",
                            style: const TextStyle(color: Colors.white),
                          ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Obx(
                    () => CircleAvatar(
                      backgroundColor: _password.value.length >= 6
                          ? AppColors.primaryColor
                          : Colors.grey,
                      radius: 10,
                      child: const Icon(
                        Icons.done,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "At atleast 6 characters",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Obx(
                    () => CircleAvatar(
                      backgroundColor: containsNumber(_password.value)
                          ? AppColors.primaryColor
                          : Colors.grey,
                      radius: 10,
                      child: const Icon(
                        Icons.done,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Contain atleast one number",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height / 7.5),
              InkWell(
                // onTap: () => Get.to(() => ResetPasswordScreen()),
                child: Container(
                  height: 45,
                  width: Get.width / 1.5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        Color.fromARGB(212, 37, 37, 37)
                      ],
                    ),
                  ),
                  child: const Text(
                    "Send Link",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
