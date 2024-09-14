import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:flutter/material.dart';

class TabButtom extends StatelessWidget {
  final IconData icon;
  final IconData selectIcon;
  final VoidCallback onTap;
  final bool isActive;
  const TabButtom({super.key, required this.icon, required this.selectIcon, required this.onTap, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? selectIcon : icon,
            color: isActive ? TColor.secondaryColor1 : Colors.grey,
            size: isActive ? 30 : 24,
          ),
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isActive ? TColor.secondaryGradient : [Colors.transparent, Colors.transparent],
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}