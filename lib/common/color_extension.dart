import 'package:flutter/material.dart';

class TColor {
  static Color get primaryColor1 => const Color(0xFF4E6069);
  static Color get primaryColor2 => const Color(0xFF14202E);

  static Color get secondaryColor1 => const Color(0xFFFF6F61);
  static Color get secondaryColor2 => const Color(0xFFFFA69E);
  
  static List<Color> get primaryGradient => [primaryColor1, primaryColor2];
  static List<Color> get secondaryGradient => [secondaryColor1, secondaryColor2];

  static Color get black => const Color(0xFF000000);
  static Color get white => const Color(0xFFFFFFFF);
  static Color get grey => const Color(0xFF4F4F4F);
  static Color get lightGrey => const Color(0xFFE0E0E0);
}