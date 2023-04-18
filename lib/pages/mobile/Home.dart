import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box/components/PhotoWaterMark.dart/PhotoWatermark.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _navTo(path) {
    if (path == 'photo') {
      Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
        return PhotoWaterMark();
      }));
    }
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Box'),
      ),
      body: Center(
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
          ),
          children: [
            GestureDetector(
              onTap: () => _navTo('photo'),
              child: Icon(Icons.ac_unit),
            ),
            Icon(Icons.airport_shuttle),
            Icon(Icons.all_inclusive),
            Icon(Icons.beach_access),
            Icon(Icons.cake),
            Icon(Icons.free_breakfast)
          ],
        ),
      ),
    );
  }
}
