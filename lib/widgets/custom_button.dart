import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/resources/colors.dart';


// ignore: must_be_immutable
class CommonButton extends StatelessWidget {
  final String text;
  Color? bgColor;
  Color? textColor;
  final VoidCallback ontap;
  BoxBorder? border;
  CommonButton({
    super.key,
    required this.text,
    this.bgColor,
    required this.ontap,
    this.textColor,
    this.border,
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
          border: border,
          borderRadius: BorderRadius.circular(15),
          color: bgColor,
          gradient: bgColor == null ?  const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor,
               Color.fromARGB(255, 17, 99, 14),
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