import 'package:bodybuilderaiapp/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class FitnessLoadingIndicator extends StatefulWidget {
  const FitnessLoadingIndicator({super.key});

  @override
  State<FitnessLoadingIndicator> createState() => _FitnessLoadingIndicatorState();
}

class _FitnessLoadingIndicatorState extends State<FitnessLoadingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();


    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);


    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );


    _rotationAnimation = Tween<double>(begin: -math.pi, end: math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );


    _colorAnimation = ColorTween(begin: TColor.primaryColor1, end: TColor.secondaryColor1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value, 
            child: Transform.scale(
              scale: _scaleAnimation.value, 
              child: Icon(
                Icons.fitness_center,
                size: 80,
                color: _colorAnimation.value,
              ),
            ),
          );
        },
      ),
    );
  }
}
