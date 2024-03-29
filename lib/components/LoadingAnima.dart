import 'package:flutter/material.dart';

class RotateLoadingPainter extends CustomPainter {
  RotateLoadingPainter({this.itemWidth = 33});
  // 颜色
  final List<Color> colors = const [
    Color(0xffF44336),
    Color(0xff5C6BC0),
    Color(0xffFFB74D),
    Color(0xff8BC34A)
  ];
  final double itemWidth; //色块宽
  final Paint _paint = Paint(); //画板
  final double span = 16; //色块间隔

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final double len = itemWidth / 2 + span / 2;

    // 绘制红色
    Offset centerA = Offset(-len, -len);
    drawItem(canvas, centerA, colors[0]);

    // 绘制蓝色
    Offset centerB = Offset(len, len);
    drawItem(canvas, centerB, colors[1]);

    // 绘制橙色
    Offset centerC = Offset(len, -len);
    drawItem(canvas, centerC, colors[2]);

    // 绘制绿色
    Offset centerD = Offset(-len, len);
    drawItem(canvas, centerD, colors[3]);
  }

  void drawItem(
    Canvas canvas,
    Offset center,
    Color color,
  ) {
    Rect rect =
        Rect.fromCenter(center: center, width: itemWidth, height: itemWidth);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(5)),
      _paint..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant RotateLoadingPainter oldDelegate) =>
      oldDelegate.itemWidth != itemWidth;
}
