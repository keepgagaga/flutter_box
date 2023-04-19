import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box/components/PhotoWaterMark/PhotoWatermark.dart';

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

  Future<File> _takeWaterMark(context) async {
    return await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return PhotoWaterMark();
        },
        transitionsBuilder: ((context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: animation,
              child: child,
            )),
      ),
    );
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
            // GestureDetector(
            //   behavior: HitTestBehavior.opaque,
            //   onTap: () => _takeWaterMark,
            //   child: Icon(Icons.ac_unit),
            // ),
            IconButton(
                onPressed: () {
                  _takeWaterMark(context);
                },
                icon: Icon(Icons.image)),
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
