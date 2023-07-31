import 'package:flutter/material.dart';

class AnimatedContainerExample extends StatefulWidget {
  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _isPressed = false;

  void _togglePress() {
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: _togglePress,
        child: AnimatedContainer(
          width: _isPressed ? 100.0 : 50.0,
          height: _isPressed ? 100.0 : 50.0,
          decoration: BoxDecoration(
            shape: _isPressed ? BoxShape.circle : BoxShape.rectangle,
            color: _isPressed ? Colors.blue : Colors.orange,
          ),
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: Center(child: Text('点击')),
        ),
      ),
    );
  }
}
