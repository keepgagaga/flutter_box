import 'package:flutter/material.dart';
import 'package:flutter_box/utils/SizeFit.dart';

class RotateAnima extends StatefulWidget {
  _RotateAnimaState createState() => _RotateAnimaState();
}

class _RotateAnimaState extends State<RotateAnima>
    with TickerProviderStateMixin {
  //
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 8),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  void dispose() {
    super.dispose();
  }

  Widget build(context) {
    SizeFit.initialize(context);

    return Container(
      width: 350.0,
      height: 350.0,
      child: Stack(
        children: [
          Positioned(
            child: RotationTransition(
              turns: _animation,
              child: Image(
                image: AssetImage('assets/images/rotate_anima_1.png'),
                width: 350.0,
                height: 350.0,
              ),
            ),
          ),
          Positioned(
            top: 15.0,
            left: 15.0,
            child: RotationTransition(
              turns: _animation,
              child: Image(
                image: AssetImage('assets/images/rotate_anima_2.png'),
                width: 320.0,
                height: 320.0,
              ),
            ),
          ),
          Positioned(
            top: 40.0,
            left: 40.0,
            child: RotationTransition(
              turns: _animation,
              child: Image(
                image: AssetImage('assets/images/rotate_anima_3.png'),
                width: 270.0,
                height: 270.0,
              ),
            ),
          ),
          Positioned(
            top: 60.0,
            left: 60.0,
            child: RotationTransition(
              turns: _animation,
              child: Image(
                image: AssetImage('assets/images/rotate_anima_4.png'),
                width: 230.0,
                height: 230.0,
              ),
            ),
          ),
          Positioned(
            top: 125,
            left: 125,
            child: Icon(
              Icons.flutter_dash,
              color: Colors.white,
              size: 100,
            ),
          ),
        ],
      ),
    );
  }
}
