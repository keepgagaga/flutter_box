import 'package:flutter/material.dart';
import 'package:flutter_box/components/InnerShadow.dart';

class InnerShadowExample extends StatefulWidget {
  _InnerShadowExampleState createState() => _InnerShadowExampleState();
}

class _InnerShadowExampleState extends State<InnerShadowExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _breatheController;
  late Animation<double> _breatheAnimation;

  @override
  void initState() {
    _breatheController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..addListener(() {
            setState(() {});
          });
    _breatheAnimation =
        Tween<double>(begin: 5, end: 40).animate(_breatheController);
    _breatheController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _breatheController.dispose();
    super.dispose();
  }

  Widget build(context) {
    return InnerShadow(
      color: Color(0xFF3DF30B),
      offset: Offset(15, 15),
      blur: _breatheAnimation.value,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(150),
        ),
      ),
    );
  }
}
