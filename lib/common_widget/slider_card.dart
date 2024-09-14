import 'package:flutter/material.dart';
import 'package:bodybuilderaiapp/common/color_extension.dart';

class SliderCard extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final bool isSelected;
  final VoidCallback onTap;

  const SliderCard({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [TColor.secondaryColor1, TColor.primaryColor1]
                : TColor.primaryGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          border: isSelected
              ? Border.all(color: TColor.grey, width: 3)
              : null,
        ),
        padding: EdgeInsets.symmetric(
          vertical: media.width * 0.07,
          horizontal: 25,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: media.width * 0.75,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: media.width * 0.1),
            Text(
              title,
              style: TextStyle(
                color: TColor.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: media.width * 0.1,
              height: 1,
              color: TColor.white,
            ),
            SizedBox(height: media.width * 0.02),
            SizedBox(
              width: media.width * 0.6,
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.white,
                  fontSize: 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
