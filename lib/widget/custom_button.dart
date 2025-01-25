import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/color_resources.dart';

// ignore: must_be_immutable
class CommonButton extends StatelessWidget {
  final String text;
  Color? bgColor;
  Color? textColor;
  final VoidCallback ontap;
  CommonButton({
    super.key,
    required this.text,
    this.bgColor,
    required this.ontap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 55,
        alignment: Alignment.center,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: bgColor,
          gradient: bgColor == null ?  LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor,
              const Color.fromARGB(255, 17, 99, 14),
            ],
          ) : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color:  textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}