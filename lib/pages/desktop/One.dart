import 'package:flutter/material.dart';
import 'package:flutter_box/utils/RandomColor.dart';

class One extends StatelessWidget {
  final List _navs = [
    {
      'label': 'decompress',
      'path': '/decompress',
    },
  ];

  Widget build(context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1.0,
      ),
      itemCount: _navs.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, _navs[index]['path']);
        },
        child: Container(
          color: RandomColor.getColor(),
          alignment: Alignment.center,
          child: Text(_navs[index]['label']),
        ),
      ),
    );
  }
}
