import 'package:flutter/material.dart';


Widget buildIconButton({
  required IconData icon,
  EdgeInsetsGeometry? margin,
  required VoidCallback onTap,
  double? height,
  double? width,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height ?? 45,
      width: width ?? 45,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(icon),
    ),
  );
}
