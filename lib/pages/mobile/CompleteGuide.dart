import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_box/utils/SizeFit.dart';

class CompleteGuide extends StatefulWidget {
  final bool begin;
  const CompleteGuide({Key? key, required this.begin}) : super(key: key);
  _CompleteGuideState createState() => _CompleteGuideState();
}

class _CompleteGuideState extends State<CompleteGuide>
    with TickerProviderStateMixin {
  late AnimationController _ctrl;
  late AnimationController _tickCtrl;
  bool _show = true;

  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _tickCtrl =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    if (widget.begin) {
      _ctrl.repeat();
    }

    Future.delayed(Duration(seconds: 3), () {
      _tickCtrl.forward();
      setState(() {
        _show = false;
      });
    });
  }

  void dispose() {
    _ctrl.dispose();
    _tickCtrl.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    SizeFit.initialize(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Anima'),
      ),
      body: Center(
        child: UnconstrainedBox(
          child: SizedBox(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 400.0.rpx,
                  height: 350.0.rpx,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(400.0.rpx / 2)),
                  ),
                ),
                CustomPaint(
                  painter: CirclePainter(_ctrl, _ctrl.isCompleted),
                ),
                CustomPaint(
                  painter: TickPainter(_tickCtrl, !_show),
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
        center: Offset(0.0.rpx, 0.0.rpx), width: 400.0.rpx, height: 400.0.rpx);
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

class TickPainter extends CustomPainter {
  late final Animation<double> repaint;
  final bool isCompleted;

  TickPainter(this.repaint, this.isCompleted) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xff23FF53)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 20.0.rpx;

    Path path = Path();
    path.moveTo(-70.0.rpx, -10.0.rpx);
    path.lineTo(-10.0.rpx, 50.0.rpx);
    path.lineTo(70.0.rpx, -60.0.rpx);
    PathMetrics pms = path.computeMetrics();
    if (isCompleted) {
      pms.forEach((pm) {
        canvas.drawPath(pm.extractPath(0, pm.length * repaint.value), paint);
      });
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BlurCirclePainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..blendMode = BlendMode.srcATop
      ..imageFilter = ImageFilter.blur(sigmaX: 10, sigmaY: 10)
      ..colorFilter = ColorFilter.mode(Color(0xff4B301C), BlendMode.srcOut);

    Path path = Path();
    var rect = Rect.fromCenter(
        center: Offset(0.0.rpx, 0.0.rpx), width: 390.0.rpx, height: 330.0.rpx);
    path..arcTo(rect, 0, pi * 1.9999999, true);
    canvas.drawPath(path, paint);
  }

  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
