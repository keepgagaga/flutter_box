import 'package:flutter/material.dart';
import 'package:flutter_box/components/LongPressMenu.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: LongPressMenu(),
      ),
    );
  }
}
