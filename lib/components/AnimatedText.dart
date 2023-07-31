import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AnimatedText extends StatefulWidget {
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  final List<Color> colors = [
    Color(0xFFF60C0C),
    Color(0xFFF3B913),
    Color(0xFFE7F716),
    Color(0xFF3DF30B),
    Color(0xFF0DF6EF),
    Color(0xFF0829FB),
    Color(0xFFB709F4),
  ];

  final List<double> pos = [
    1.0 / 7,
    2.0 / 7,
    3.0 / 7,
    4.0 / 7,
    5.0 / 7,
    6.0 / 7,
    1.0
  ];
  late AnimationController _ctrl;
  final Duration animDuration = const Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration);
    _ctrl.repeat();
  }

  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Paint getPaint() {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint.shader = ui.Gradient.linear(
      const Offset(0, 0),
      const Offset(100, 0),
      colors,
      pos,
      TileMode.mirror,
      Matrix4.rotationZ(pi / 6).storage, // 旋转变换
    );
    paint.maskFilter = MaskFilter.blur(BlurStyle.solid, 15 * _ctrl.value);
    return paint;
  }

  Widget build(context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        return Text(
          'Sand',
          style: TextStyle(
            fontSize: 120,
            foreground: getPaint(),
          ),
        );
      },
    );
  }
}
