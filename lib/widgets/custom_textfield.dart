import 'package:flutter/material.dart';
import 'package:rider/resources/colors.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String hintText;
  IconData? suffixIcon;
  IconData? prefixIcon;
  VoidCallback? onSuffixClick;
  TextInputType? textInputType;
  TextStyle? textStyle;
  final TextEditingController textController;
  Color? bgColor;
  TextStyle? hintStyle;
  InputBorder? enabledBorder;
  InputBorder? focusedBorder;
  CustomTextField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.onSuffixClick,
    this.textInputType,
    this.textStyle,
    this.bgColor,
    this.hintStyle,
    this.enabledBorder,
    this.focusedBorder,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: bgColor,
      ),
      child: TextFormField(
        keyboardType: textInputType,
        style: textStyle,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: Colors.grey,
                )
              : null,
          suffixIcon: IconButton(
            onPressed: onSuffixClick,
            icon: Icon(
              suffixIcon,
              color: Colors.grey,
            ),
          ),
          hintStyle: hintStyle ??
              const TextStyle(
                fontSize: 12,
                color: Color.fromARGB(218, 158, 158, 158),
              ),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.grey,
                ),
              ),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 2,
                  color: AppColors.primaryColor,
                ),
              ),
        ),
      ),
    );
  }
}
