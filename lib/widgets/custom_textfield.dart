import 'package:flutter/material.dart';
import 'package:rider/resources/color_resources.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool? obscureText;
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
  double? height;
  BorderRadius? borderRadius;
  String? Function(String?)? validator;
  bool? readOnly;
  Function(String)? onChanged;
  CustomTextField({
    this.onChanged,
    this.obscureText,
    this.readOnly,
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
    this.height,
    this.borderRadius,
    required this.textController,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: bgColor,
      ),
      child: TextFormField(
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        keyboardType: textInputType,
        readOnly: readOnly ?? false,
        style: textStyle,
        validator: validator ??
            (value) {
              if (value?.isEmpty == true) {
                return " ";
              }
              return null;
            },
        controller: textController,
        decoration: InputDecoration(
          errorText: null,
          errorStyle: const TextStyle(fontSize: 0, height: 0),
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
                borderRadius: borderRadius ?? BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.primaryColor,
                ),
              ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
