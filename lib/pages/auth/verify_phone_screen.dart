import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:rider/controller/auth_controller.dart';
import 'package:rider/controller/timer_controller.dart';
import 'package:rider/resources/color_resources.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  VerifyPhoneNumberScreen({super.key, this.email, required this.nextScreenMethod});
  final String? email;
  final VoidCallback nextScreenMethod;
  final _timeController = Get.put(TimerController());
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Enter Code",
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
      body: Obx(
        () => Stack(
          children: [
            if (_authController.isLoading.value)
              LinearProgressIndicator(color: AppColors.primaryColor),
            Opacity(
              opacity: _authController.isLoading.value ? 0.5 : 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Verify Email Address",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      "Kindly enter the OTP sent to $email",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 45),
                    Center(
                      child: Pinput(
                        closeKeyboardWhenCompleted: true,
                        onSubmitted: (value) async {
                          print("submitted $value");
                        },
                        onCompleted: (value) async {
                          print("completed $value");
                          await _authController.verifyOtp(
                              otpCode: value,
                              email: email ?? "",
                              whatNext: () {
                                nextScreenMethod();
                              });
                        },
                        focusedPinTheme: PinTheme(
                          height: 60,
                          width: 60,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                            border: Border.all(
                              width: 2,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 150),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Resend: code in: ",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Obx(
                          () => InkWell(
                            onTap: () async {
                              _timeController.startTimer();
                              await _authController.sendOtp();
                            },
                            child: Text(
                              _timeController.secondsLeft.value <= 0
                                  ? "Resend"
                                  : _timeController.secondsLeft.value
                                      .toString(),
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
