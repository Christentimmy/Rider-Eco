

import 'package:flutter/material.dart';

Map<String, Color> carColors = {
  "black": Colors.black,
  "white": Colors.white,
  "red": Colors.red,
  "blue": Colors.blue,
  "green": Colors.green,
  "yellow": Colors.yellow,
  "gray": Colors.grey,
  "silver": Colors.blueGrey,
  "gold": const Color(0xFFFFD700),
  "brown": const Color(0xFF8B4513),
  "orange": Colors.orange,
  "purple": Colors.purple,
  "pink": Colors.pink,
  "beige": const Color(0xFFF5F5DC),
  "maroon": const Color(0xFF800000),
  "navy": const Color(0xFF000080),
  "teal": Colors.teal,
  "cyan": Colors.cyan,
  "lime": Colors.lime,
  "indigo": Colors.indigo,
};

Color? getCarColor(String colorName) {
  return carColors[colorName.toLowerCase()];
}
