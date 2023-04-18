import 'package:flutter/material.dart';

class RightContent extends StatefulWidget {
  final int navIndex;
  RightContent(this.navIndex);
  _RightContentState createState() => _RightContentState();
}

class _RightContentState extends State<RightContent> {
  Widget build(context) {
    return Container(
      child: Center(
        child: Text(widget.navIndex.toString()),
      ),
    );
  }
}
