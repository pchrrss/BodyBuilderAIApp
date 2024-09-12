import 'package:flutter/material.dart';

class TColor {
  static Color get primaryColor1 => const Color(0xFF3F51B5);
  static Color get primaryColor2 => const Color(0xFF303F9F);

  static Color get secondaryColor1 => const Color(0xFFE91E63);
  static Color get secondaryColor2 => const Color(0xFFC2185B);
  
  static List<Color> get primaryGradient => [primaryColor1, primaryColor2];
  static List<Color> get secondaryGradient => [secondaryColor1, secondaryColor2];

  static Color get black => const Color(0xFF000000);
  static Color get white => const Color(0xFFFFFFFF);
  static Color get grey => const Color(0xFF9E9E9E);
}