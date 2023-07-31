import 'package:flutter/material.dart';

class TweenAnimationBuilderExample extends StatefulWidget {
  @override
  _TweenAnimationBuilderExampleState createState() =>
      _TweenAnimationBuilderExampleState();
}

class _TweenAnimationBuilderExampleState
    extends State<TweenAnimationBuilderExample> {
  double _opacity = 0.5;

  void _toggleOpacity() {
    setState(() {
      _opacity = _opacity == 1 ? 0.0 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleOpacity(),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: Duration(seconds: 3),
        builder: (BuildContext context, double value, Widget? child) {
          return Opacity(
            opacity: value * _opacity,
            child: Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              child: Container(
                width: 200 * value,
                height: 200 * value,
                margin: EdgeInsets.only(top: 20),
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text(
                  'Animated Builder',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
