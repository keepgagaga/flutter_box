import 'package:flutter/material.dart';

class PhotoWaterMark extends StatefulWidget {
  _PhotoWaterMarkState createState() => _PhotoWaterMarkState();
}

class _PhotoWaterMarkState extends State<PhotoWaterMark>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App state: $state');
    super.didChangeAppLifecycleState(state);
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watermark'),
      ),
      body: Container(),
    );
  }
}
