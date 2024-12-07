import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.green,
        body:  CustomShapeWidget(),
      ),
    );
  }
}


class CustomShapeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RightBottomArchClipper(),
      child: Container(
        width: Get.width * 0.9,
        height: Get.height,
        color: Colors.white,
        child: Center(
          child: Text(
            'Hello!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class RightBottomArchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Arch dimensions
    final double cutoutWidth = 60; // Width of the arch
    final double cutoutHeight = 140; // Height of the arch
    final double archBottomOffset = 150; // Distance from the bottom edge to the arch's base

    // Start from the top-left corner
    path.moveTo(0, 0);

    // Top edge
    path.lineTo(size.width, 0);

    // Right edge down to arch's start
    path.lineTo(size.width, size.height - archBottomOffset - cutoutHeight / 2);

    // Arch on the right-bottom
    path.quadraticBezierTo(
      size.width - cutoutWidth, // Control point X
      size.height - archBottomOffset, // Control point Y
      size.width, // End point X
      size.height - archBottomOffset + cutoutHeight / 2, // End point Y
    );

    // Bottom edge
    path.lineTo(size.width, size.height);

    // Left edge
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
