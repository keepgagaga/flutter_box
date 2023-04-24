import 'package:flutter/material.dart';
import 'package:flutter_box/components/StopWatch/StopWatch.dart';

class StopWatchPage extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop Watch'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: StopWatch(),
        ),
      ),
    );
  }
}
