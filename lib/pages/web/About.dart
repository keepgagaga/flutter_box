import 'package:flutter/material.dart';

class About extends StatelessWidget {
  final String _aboutDes =
      '这是一个使用  Flutter Web 技术构建的网站，其实我也不知道写什么才好，后来想了想那就先罗列下目前 Flutter 在 Web 端的所有能力，看看能达到什么效果吧，另外还会有一些奇奇怪怪的东西出现，权当娱乐。';

  Widget build(context) {
    return Container(
      width: 400,
      alignment: Alignment.center,
      child: Text(_aboutDes),
    );
  }
}
