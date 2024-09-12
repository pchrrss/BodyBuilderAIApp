import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:flutter/material.dart';

class RoundTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hintText;
  final IconData icon;
  final IconData? suffixIcon;
  final bool obscureText;
  final EdgeInsets? margin;
  const RoundTextfield({super.key, this.controller, required this.hintText, required this.icon, this.margin, this.keyboardType, this.obscureText = false, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: TColor.lightGrey, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
          prefixIcon: Icon(icon, color: TColor.grey),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: TColor.grey) : null,
          hintStyle: TextStyle(color: TColor.grey, fontSize: 12),
        ),
      ),
    );
  }
}
