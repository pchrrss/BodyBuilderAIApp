import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:flutter/material.dart';

enum RoundButtonType { bgGradient, textGradient }

class RoundButton extends StatelessWidget {
  final String title;
  final RoundButtonType type;
  final VoidCallback onPressed;
  const RoundButton({
    super.key,
    required this.title,
    this.type = RoundButtonType.bgGradient,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: TColor.primaryGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: type == RoundButtonType.bgGradient
            ? [
                BoxShadow(
                  color: TColor.primaryColor1.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 0.5,
                  offset: const Offset(0, 0.5),
                )
              ]
            : null,
      ),
      child: MaterialButton(
          onPressed: onPressed,
          height: 50,
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textColor: TColor.primaryColor1,
          minWidth: double.maxFinite,
          elevation: type == RoundButtonType.bgGradient ? 0 : 1,
          color: type == RoundButtonType.bgGradient ? Colors.transparent : TColor.white,
          child: type == RoundButtonType.bgGradient ?
          Text(title, style: TextStyle(color: TColor.white,fontWeight: FontWeight.bold)) : 
           ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: TColor.primaryGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
            },
            child: Text(
              title,
              style:
                  TextStyle(color: TColor.white, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
