import 'package:flutter/material.dart';
import 'package:flutter_box/utils/RandomColor.dart';

class AppTitle extends StatefulWidget {
  _AppTitleState createState() => _AppTitleState();
}

class _AppTitleState extends State<AppTitle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation =
      Tween<double>(begin: 0.8, end: 1.2).animate(_controller);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget build(context) {
    return ScaleTransition(
      scale: _animation,
      child: Text(
        'Flutter Box',
        style: TextStyle(
          color: RandomColor.getColor(),
        ),
      ),
    );
  }
}
