import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:rider/pages/auth/password_recovery_screen.dart';
import 'package:rider/pages/auth/verify_phone_screen.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final RxBool _isLoginWithNumber = true.obs;
  final RxInt _currentPage = 0.obs;
  final _emailController = TextEditingController();
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 185, 185),
      body: Stack(
        children: [
          VectorDiagram(currentPage: _currentPage),
          _buildInputFields(),
        ],
      ),
    );
  }

  SingleChildScrollView _buildInputFields() {
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(),
      child: Center(
        child: Container(
          height: Get.height * 0.61,
          width: Get.width * 0.92,
          margin: EdgeInsets.only(top: Get.height * 0.35),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildAuthDecision(),
              _buildCrossFade(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCrossFade() {
    return Obx(
      () => AnimatedCrossFade(
        firstChild: signUpPage(),
        secondChild: loginPage(),
        crossFadeState: _currentPage.value == 0
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  Widget _buildAuthDecision() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Obx(
            () => GestureDetector(
              onTap: () {
                CrossFadeState.showFirst;
                _currentPage.value = 0;
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: _currentPage.value == 0
                      ? AppColors.primaryColor
                      : Colors.white,
                  fontWeight: _currentPage.value == 0 ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
          const Spacer(),
          Obx(
            () => GestureDetector(
              onTap: () {
                CrossFadeState.showSecond;
                _currentPage.value = 1;
              },
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: _currentPage.value == 1
                      ? AppColors.primaryColor
                      : Colors.white,
                  fontWeight: _currentPage.value == 1 ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: SizedBox(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Login Into Your Account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      _isLoginWithNumber.value = !_isLoginWithNumber.value;
                    },
                    child: Text(
                      _isLoginWithNumber.value
                          ? "Use Email Instead"
                          : "Change to number",
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ],
            ),
            Obx(() {
              if (_isLoginWithNumber.value) {
                return const PhoneNumberTextField();
              } else {
                return CustomTextField(
                  hintText: "john@email.com",
                  textController: _loginEmailController,
                );
              }
            }),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: "password",
              textController: _loginPasswordController,
            ),
            const SizedBox(height: 25),
            CommonButton(
              ontap: () {
                Get.to(() => HomeScreen());
              },
              text: "Login",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.to(() => const PasswordRecoveryScreen()),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Text(
              "By clicking start, you agree to our Terms and Conditions",
              style: TextStyle(
                fontSize: 9,
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }

  Widget signUpPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: SizedBox(
        height: Get.height * 0.51,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Create Account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            // const EmailTextField(),
            CustomTextField(
              hintText: "John@email.com",
              textController: _emailController,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              child: Row(
                children: [
                  CountryCodePicker(
                    onChanged: (value) {},
                    initialSelection: '+234',
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    // optional. aligns the flag and the Text left
                    alignLeft: false,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "mobile number",
                        hintStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
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
            const SizedBox(height: 10),
            // const PasswordTextField(),
            CustomTextField(
              hintText: "password",
              textController: _passwordController,
            ),
            const SizedBox(height: 10),
            // const ConfirmPassswordTextField(),
            CustomTextField(
              hintText: "confirm password",
              textController: _confirmPasswordController,
            ),
            const SizedBox(height: 25),
            CommonButton(
              ontap: () {
                Get.to(() => VerifyPhoneNumberScreen());
              },
              text: "Sign Up",
            ),
            const Spacer(),
            const Text(
              "By clicking start, you agree to our Terms and Conditions",
              style: TextStyle(
                fontSize: 9,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          CountryCodePicker(
            onChanged: (value) {
              print(value);
            },
            initialSelection: '+234',
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            // optional. aligns the flag and the Text left
            alignLeft: false,
          ),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "mobile number",
                hintStyle: const TextStyle(
                  fontSize: 12,
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
    );
  }
}

class VectorDiagram extends StatelessWidget {
  final RxInt currentPage;
  const VectorDiagram({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 400,
            color: AppColors.primaryColor,
            width: Get.width,
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/images/OBJECTS.png"),
          ),
          Positioned(
            bottom: 85,
            right: 60,
            child: Obx(
              () => AnimatedCrossFade(
                firstChild: Image.asset(
                  "assets/images/car.png",
                  width: 250,
                  height: 250,
                ),
                secondChild: Image.asset(
                  "assets/images/ecoLogo.png",
                  width: 250,
                  height: 250,
                ),
                crossFadeState: currentPage.value == 0
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
