import 'package:flutter/material.dart';

class AnimatedPaddingExample extends StatefulWidget {
  @override
  _AnimatedPaddingExampleState createState() => _AnimatedPaddingExampleState();
}

class _AnimatedPaddingExampleState extends State<AnimatedPaddingExample> {
  double _paddingValue = 0.0;

  void _togglePadding() {
    setState(() {
      _paddingValue = _paddingValue == 50.0 ? 0.0 : 50.0; // 切换内边距值
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePadding,
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
        ),
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        child: AnimatedPadding(
          padding: EdgeInsets.symmetric(horizontal: _paddingValue),
          duration: Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: Text(
            'Animated Padding',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
