import 'package:flutter/material.dart';
import 'package:flutter_box/pages/web/One.dart';
import 'package:flutter_box/pages/web/Three.dart';
import 'package:flutter_box/pages/web/Two.dart';

class RightContent extends StatefulWidget {
  final int navIndex;
  RightContent(this.navIndex);
  _RightContentState createState() => _RightContentState();
}

class _RightContentState extends State<RightContent> {
  List<Widget> _contents = [One(), Two(), Three()];

  Widget build(context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      child: Center(
        child: _contents[widget.navIndex],
      ),
    );
  }
}
