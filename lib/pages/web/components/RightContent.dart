import 'package:flutter/material.dart';
import 'package:flutter_box/pages/web/About.dart';
import 'package:flutter_box/pages/web/components/SolarSystem.dart';

class RightContent extends StatefulWidget {
  final int navIndex;
  RightContent(this.navIndex);
  _RightContentState createState() => _RightContentState();
}

class _RightContentState extends State<RightContent> {
  List _widgets = [];

  @override
  void initState() {
    _widgets = [
      SolarSystem(begin: true),
      Text(widget.navIndex.toString()),
      About(),
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      alignment: Alignment.center,
      child: Center(
        child: _widgets[widget.navIndex],
      ),
    );
  }
}
