import 'dart:math';

import 'package:flutter/material.dart';

class StopWatchWidget extends StatelessWidget {
  final Duration duration;
  final double radius;
  final Color? scaleColor;
  final Color? dotColor;

  const StopWatchWidget({
    super.key,
    required this.duration,
    required this.radius,
    this.scaleColor = Colors.red,
    this.dotColor = Colors.red,
  });

  Widget build(context) {
    return Container(
      child: CustomPaint(
        painter: StopWatchPainter(
          radius: 150,
          duration: duration,
          scaleColor: scaleColor,
          dotColor: dotColor,
        ),
        size: Size(300, 300),
      ),
    );
  }
}

class StopWatchPainter extends CustomPainter {
  final double radius;
  final Duration duration; // 时长
  final Color? scaleColor; // 刻度色
  final Color? dotColor;

  StopWatchPainter({
    required this.radius,
    required this.duration,
    this.scaleColor,
    this.dotColor,
  });

  final Paint scalePainter = Paint();
  final Paint indicatorPainter = Paint();

  TextStyle commonStyle = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w200,
    color: const Color(0xff343434),
  );
  TextStyle highlightStyle = TextStyle();

  void paint(Canvas canvas, Size size) {
    const double _kScaleWidthRate = 0.4 / 10;
    const double _kIndicatorRadiusRate = 0.4 / 15;
    final double scaleLineWidth = size.width * _kScaleWidthRate;
    final double indicatorRadius = size.width * _kIndicatorRadiusRate;

    canvas.translate(size.width / 2, size.height / 2); // tag1
    scalePainter
      ..color = scaleColor!
      ..style = PaintingStyle.stroke;
    indicatorPainter
      ..color = dotColor!
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 180; i++) {
      canvas.drawLine(Offset(size.width / 2, 0),
          Offset(size.width / 2 - scaleLineWidth, 0), scalePainter);
      canvas.rotate(pi / 180 * 2); //这里采用 rotate 整个 canvas 而不是单个线
    }

    TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    int minus = duration.inMinutes % 60;
    int second = duration.inSeconds % 60;
    int milliseconds = duration.inMilliseconds % 1000;
    String commonStr =
        '${minus.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}';
    String highlightStr = ".${(milliseconds ~/ 10).toString().padLeft(2, "0")}";

    void drawText(Canvas canvas) {
      textPainter.text = TextSpan(
          text: commonStr,
          style: commonStyle,
          children: [TextSpan(text: highlightStr, style: highlightStyle)]);
      textPainter.layout(); // 进行布局
      final double width = textPainter.size.width;
      final double height = textPainter.size.height;
      textPainter.paint(canvas, Offset(-width / 2, -height / 2));
    }

    drawText(canvas);

    double radians = (second * 1000 + milliseconds) / (60 * 1000) * 2 * pi;

    canvas.save();
    canvas.rotate(radians);

    canvas.drawCircle(
      Offset(
        0,
        -size.width / 2 + scaleLineWidth + indicatorRadius,
      ),
      indicatorRadius / 2,
      indicatorPainter,
    );
    canvas.restore();
  }

  bool shouldRepaint(covariant StopWatchPainter oldDelegate) {
    return oldDelegate.duration != duration ||
        oldDelegate.scaleColor != scaleColor;
  }
}
