import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedAlignExample extends StatefulWidget {
  @override
  _AnimatedAlignExampleState createState() => _AnimatedAlignExampleState();
}

class _AnimatedAlignExampleState extends State<AnimatedAlignExample> {
  Alignment _alignment = Alignment.topLeft;
  List<Alignment> _alignmentList = [
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomLeft,
    Alignment.bottomRight
  ];

  void _setAlignment() {
    setState(() {
      _alignment = _alignmentList[Random().nextInt(_alignmentList.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _setAlignment(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: 200.0,
        height: 200.0,
        margin: EdgeInsets.only(top: 20),
        color: Colors.blue,
        child: AnimatedAlign(
          duration: Duration(milliseconds: 500),
          alignment: _alignment,
          child: Text(
            'Animated Align',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
