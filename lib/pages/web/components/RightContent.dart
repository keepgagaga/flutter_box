import 'package:flutter/material.dart';
import 'package:flutter_box/pages/web/About.dart';

class RightContent extends StatefulWidget {
  final int navIndex;
  RightContent(this.navIndex);
  _RightContentState createState() => _RightContentState();
}

class _RightContentState extends State<RightContent> {
  @override
  void initState() {
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
        child:
            widget.navIndex == 2 ? About() : Text(widget.navIndex.toString()),
      ),
    );
  }
}
