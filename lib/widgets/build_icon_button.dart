import 'package:flutter/material.dart';

Widget buildIconButton({
  required IconData icon,
  EdgeInsetsGeometry? margin,
  required VoidCallback onTap,
  double? height,
  double? width,
  BoxShape? shape,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? 45,
      width: width ?? 45,
      margin: margin,
      decoration: BoxDecoration(
        shape: shape ?? BoxShape.rectangle,
        borderRadius: shape != null ? null : BorderRadius.circular(12),
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
