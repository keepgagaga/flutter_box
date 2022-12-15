import 'package:flutter/material.dart';
import 'package:flutter_box/utils/SizeFit.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    SizeFit.initialize(context);
    return Scaffold(
      body: Container(
        width: 750.0.rpx,
        height: 750.0.rpx,
        child: Row(
          children: [
            HomeLeft(),
            HomeCenter(),
            HomeRight(),
          ],
        ),
      ),
    );
  }
}

class HomeLeft extends StatefulWidget {
  _HomeLeftState createState() => _HomeLeftState();
}

class _HomeLeftState extends State<HomeLeft> {
  List<Map> _icons = [
    {
      'id': 'avatar',
    },
    {
      'id': 'message',
    },
    {
      'id': 'contact',
    },
    {
      'id': 'favorite',
    },
    {
      'id': 'files',
    },
    {
      'id': 'friend_news',
    },
    {
      'id': 'video',
    },
    {
      'id': 'search',
    },
    {
      'id': 'miniprogram',
    },
    {
      'id': 'phone',
    },
    {
      'id': 'setting',
    },
  ];

  Widget build(BuildContext context) {
    return Container(
      width: 50.0.rpx,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _icons
            .map((e) => Icon(
                  Icons.ac_unit,
                  size: 30.0.rpx,
                ))
            .toList(),
      ),
    );
  }
}

class HomeCenter extends StatefulWidget {
  _HomeCenterState createState() => _HomeCenterState();
}

class _HomeCenterState extends State<HomeCenter> {
  List<Map> _messages = [
    {
      'id': '1',
      'type': 'single',
      'message': '你好，我是单聊',
    },
    {
      'id': '2',
      'type': 'group',
      'message': '你好，我是群聊',
    },
  ];

  Widget _search = Container();

  Widget build(BuildContext context) {
    return Container(
      width: 300.0.rpx,
      child: Column(
        children: [
          _search,
          ListView.builder(
              itemBuilder: (context, index) => Row(
                    children: [
                      Icon(Icons.abc_sharp),
                      Column(
                        children: [],
                      ),
                    ],
                  ))
        ],
      ),
    );
  }
}

class HomeRight extends StatefulWidget {
  _HomeRightState createState() => _HomeRightState();
}

class _HomeRightState extends State<HomeRight> {
  Widget build(BuildContext context) {
    return Container();
  }
}
