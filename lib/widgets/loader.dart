import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CarLoader extends StatelessWidget {
  const CarLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/images/carloader.json",
      height: 30,
      delegates: LottieDelegates(
        values: [
          ValueDelegate.color(
            const ['**'], 
            value: Colors.white,
          ),
        ],
      ),
    );
  }
}
