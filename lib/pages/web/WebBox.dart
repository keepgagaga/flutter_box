import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:universal_html/html.dart';

class WebBox extends StatefulWidget {
  _WebBoxState createState() => _WebBoxState();
}

class _WebBoxState extends State<WebBox> {
  void initState() {
    ui.platformViewRegistry.registerViewFactory(
        'WebBox',
        (int viewId) => IFrameElement()
          ..style.border = 'none'
          ..src = 'https://sand-web-box.vercel.app/#/');
    super.initState();
  }

  Widget build(context) {
    return Scaffold(
      body: Container(
        child: HtmlElementView(
          viewType: 'WebBox',
        ),
      ),
    );
  }
}
