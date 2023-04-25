import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box/components/PhotoWaterMark/PhotoWatermark.dart';
import 'package:flutter_box/utils/RandomColor.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _homeNavData = [];

  void initState() {
    super.initState();
    _init();
  }

  void dispose() {
    super.dispose();
  }

  _init() {
    _homeNavData = [
      {
        'label': '水印相机',
        'callback': () => _takeWaterMark(context),
      },
      {
        'label': '秒表',
        'callback': () => _navTo('stopWatch'),
      },
      {
        'label': 'webview',
        'callback': () => _navTo('webview'),
      },
      {
        'label': 'permission',
        'callback': () => _navTo('permission'),
      },
      {
        'label': 'network',
        'callback': () => _navTo('networkStatus'),
      },
      {
        'label': 'videoPlayer',
        'callback': () => _navTo('videoPlayer'),
      },
      {
        'label': 'imageEdit',
        'callback': () => _navTo('imageEdit'),
      },
    ];
  }

  _takeWaterMark(context) async {
    List<CameraDescription> _cameras = await availableCameras(); // 获取可用相机列表

    return await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return PhotoWaterMark(
            cameras: _cameras,
          );
        },
        transitionsBuilder: ((context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: animation,
              child: child,
            )),
      ),
    );
  }

  void _navTo(to) {
    print(to);
    Navigator.of(context).pushNamed('/$to');
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Box'),
        backgroundColor: RandomColor.getColor(),
      ),
      body: Center(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
            ),
            itemCount: _homeNavData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _homeNavData[index]['callback'](),
                child: Container(
                  color: RandomColor.getColor().withOpacity(0.5),
                  alignment: Alignment.center,
                  child: Text(
                    _homeNavData[index]['label'],
                    style: TextStyle(
                      color: RandomColor.getColor(),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
