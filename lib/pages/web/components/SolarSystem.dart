import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_box/utils/SizeFit.dart';

class SolarSystem extends StatefulWidget {
  final bool begin;
  const SolarSystem({Key? key, required this.begin}) : super(key: key);
  _SolarSystemState createState() => _SolarSystemState();
}

class _SolarSystemState extends State<SolarSystem>
    with TickerProviderStateMixin {
  late AnimationController _ctrl;

  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 3));

    if (widget.begin) {
      _ctrl.repeat();
    }
  }

  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    SizeFit.initialize(context);

    return Scaffold(
      body: Center(
        child: UnconstrainedBox(
          child: SizedBox(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 400.0.rpx,
                  height: 300.0.rpx,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(400.0.rpx / 2)),
                  ),
                ),
                CustomPaint(
                  painter: CirclePainter(_ctrl, _ctrl.isCompleted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  late final Animation<double> repaint;
  final bool isCompleted;

  CirclePainter(this.repaint, this.isCompleted) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFE8B98F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0.rpx;

    Path path = Path();
    var rect = Rect.fromCenter(
      center: Offset(0.0.rpx, 0.0.rpx),
      width: 300.0.rpx,
      height: 300.0.rpx,
    );
    path..arcTo(rect, 0, pi * 1.9999999, true); //这个问题还没解决
    canvas.drawPath(path, paint);
    PathMetrics pms = path.computeMetrics();
    if (!isCompleted) {
      pms.forEach((pm) {
        Tangent? tangent = pm.getTangentForOffset(pm.length * repaint.value);
        canvas.drawCircle(
            tangent!.position, 5, Paint()..color = Color(0xFFE8B98F));
      });
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
