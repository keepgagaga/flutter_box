import 'package:flutter/material.dart';
import 'package:flutter_box/utils/RandomColor.dart';

class AppTitle extends StatefulWidget {
  _AppTitleState createState() => _AppTitleState();
}

class _AppTitleState extends State<AppTitle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

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
