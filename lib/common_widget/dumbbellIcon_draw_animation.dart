import 'dart:ui';

import 'package:flutter/material.dart';

class DumbbellDrawingPainter extends CustomPainter {
  final double progress;

  DumbbellDrawingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final leftCirclePath = Path();
    leftCirclePath.addOval(Rect.fromCircle(
        center: Offset(size.width * 0.2, size.height * 0.5), radius: 10));

    final rightCirclePath = Path();
    rightCirclePath.addOval(Rect.fromCircle(
        center: Offset(size.width * 0.8, size.height * 0.5), radius: 10));

    final barPath = Path();
    barPath.addRect(Rect.fromLTWH(
        size.width * 0.3, size.height * 0.47, size.width * 0.4, 6));

    if (leftCirclePath.computeMetrics().isNotEmpty) {
      PathMetric leftCircleMetric = leftCirclePath.computeMetrics().first;
      Path extractedLeftCircle =
          leftCircleMetric.extractPath(0, leftCircleMetric.length * progress);
      canvas.drawPath(extractedLeftCircle, paint);
    }

    if (barPath.computeMetrics().isNotEmpty) {
      PathMetric barMetric = barPath.computeMetrics().first;
      Path extractedBar = barMetric.extractPath(0, barMetric.length * progress);
      canvas.drawPath(extractedBar, paint);
    }

    if (rightCirclePath.computeMetrics().isNotEmpty) {
      PathMetric rightCircleMetric = rightCirclePath.computeMetrics().first;
      Path extractedRightCircle = rightCircleMetric.extractPath(
          0, rightCircleMetric.length * progress);
      canvas.drawPath(extractedRightCircle, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DumbbellIconDrawAnimation extends StatefulWidget {
  const DumbbellIconDrawAnimation({super.key});

  @override
  State<DumbbellIconDrawAnimation> createState() =>
      _DumbbellIconDrawAnimationState();
}

class _DumbbellIconDrawAnimationState extends State<DumbbellIconDrawAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
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
          return CustomPaint(
            size: Size(100, 100),
            painter: DumbbellDrawingPainter(_controller.value),
          );
        },
      ),
    );
  }
}
