import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/pages/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: SplashScreen(),
    );
  }
}

class CustomShapeWidget extends StatelessWidget {
  const CustomShapeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RightBottomArchClipper(),
      child: Container(
        width: Get.width * 0.9,
        height: Get.height,
        color: Colors.black,
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
    const double cutoutWidth = 80; // Width of the arch
    const double cutoutHeight = 180; // Height of the arch
    const double archBottomOffset =
        150; // Distance from the bottom edge to the arch's base
    const double smoothRadius = 10; // Radius for the smooth curve at the bottom

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

    // Smooth curve transition
    path.quadraticBezierTo(
      size.width, // Start from the end of the arch
      size.height - smoothRadius, // Control point to create the smooth curve
      size.width - smoothRadius, // End X
      size.height, // End Y (bottom of the container)
    );

    // Bottom edge
    path.lineTo(0, size.height);

    // Left edge
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
