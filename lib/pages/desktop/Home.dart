import 'package:flutter/material.dart';
import 'package:flutter_box/pages/desktop/LeftArea.dart';
import 'package:flutter_box/pages/desktop/One.dart';
import 'package:flutter_box/pages/desktop/Three.dart';
import 'package:flutter_box/pages/desktop/Two.dart';
import 'package:flutter_box/utils/SizeFit.dart';
import 'package:window_manager/window_manager.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WindowListener {
  int _contentType = 0;
  List<Widget> _contents = [One(), Two(), Three()];

  @override
  void initState() {
    windowManager.addListener(this);
    _init();
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    // 添加此行以覆盖默认关闭处理程序
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  void _onNavChange(index) {
    setState(() {
      _contentType = index;
    });
  }

  Widget build(BuildContext context) {
    SizeFit.initialize(context);
    Size size = MediaQuery.of(context).size;
    double leftW = 70;
    double rightW = (size.width - leftW) < 480 ? 480 : (size.width - leftW);

    return Scaffold(
      body: Container(
        child: Row(
          children: [
            LeftArea(
              width: leftW,
              onNavChange: _onNavChange,
            ),
            Container(
              width: rightW,
              height: size.height,
              alignment: Alignment.center,
              child: _contents[_contentType],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onWindowEvent(String eventName) {
    // print('[WindowManager] onWindowEvent: $eventName');
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Are you sure you want to close this window?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await windowManager.destroy();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void onWindowFocus() {
    setState(() {});
  }

  @override
  void onWindowBlur() {
    // do something
  }

  @override
  void onWindowMaximize() {
    // do something
  }

  @override
  void onWindowUnmaximize() {
    // do something
  }

  @override
  void onWindowMinimize() {
    // do something
  }

  @override
  void onWindowRestore() {
    // do something
  }

  @override
  void onWindowResize() {
    // do something
  }

  @override
  void onWindowMove() {
    // do something
  }

  @override
  void onWindowEnterFullScreen() {
    // do something
  }

  @override
  void onWindowLeaveFullScreen() {
    // do something
  }
}
