import 'dart:math';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Widget build(context) {
    return Container(
      width: 300,
      height: 800,
      child: Column(
        children: [
          buildStopWatchPanel(),
          buildRecordPanel(),
          buildTools(),
        ],
      ),
    );
  }

  Widget buildStopWatchPanel() {
    return Container(
      height: 300,
      child: StopWatchWidget(
        duration: Duration(seconds: 1),
        radius: 150,
        themeColor: Colors.red,
        scaleColor: Colors.blue,
        textStyle: TextStyle(),
      ),
    );
  }

  Widget buildRecordPanel() {
    return Expanded(
      child: Container(
        color: Colors.red,
      ),
    );
  }

  Widget buildTools() {
    return Container(
      height: 80,
      color: Colors.yellow,
    );
  }
}

class StopWatchPainter extends CustomPainter {
  final Paint scalePainter = Paint();

  TextStyle commonStyle = TextStyle();
  TextStyle highlightStyle = TextStyle();

  void paint(Canvas canvas, Size size) {
    const double _kScaleWidthRate = 0.4 / 10;
    final double scaleLineWidth = size.width * _kScaleWidthRate;

    canvas.translate(size.width / 2, size.height / 2); // tag1
    scalePainter
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 180; i++) {
      canvas.drawLine(Offset(size.width / 2, 0),
          Offset(size.width / 2 - scaleLineWidth, 0), scalePainter);
      canvas.rotate(pi / 180 * 2); //这里采用 rotate 整个 canvas 而不是单个线
    }

    TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final Duration duration =
        Duration(minutes: 0, seconds: 4, milliseconds: 650);

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
  }

  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class StopWatchWidget extends StatelessWidget {
  final Duration duration;
  final double radius;
  final Color themeColor;
  final Color scaleColor;
  final TextStyle textStyle;

  const StopWatchWidget(
      {super.key,
      required this.duration,
      required this.radius,
      required this.themeColor,
      required this.scaleColor,
      required this.textStyle});

  Widget build(context) {
    return Container(
      child: CustomPaint(
        painter: StopWatchPainter(),
        size: Size(300, 300),
      ),
    );
  }
}
