import 'package:flutter/material.dart';
import 'package:flutter_box/utils/RandomColor.dart';

class One extends StatelessWidget {
  final List _navs = [
    {
      'label': 'WebBox',
      'des': 'load html',
      'path': '/webBox',
    },
  ];

  Widget build(context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            childAspectRatio: 1.0,
          ),
          itemCount: _navs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(_navs[index]['path']);
              },
              child: Container(
                color: RandomColor.getColor().withOpacity(0.5),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _navs[index]['label'],
                      style: TextStyle(
                        color: RandomColor.getColor(),
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      _navs[index]['des'],
                      style: TextStyle(
                        color: RandomColor.getColor(),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
