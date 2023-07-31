import 'package:flutter/material.dart';
import 'package:flutter_box/pages/mobile/CompleteGuide.dart';
import 'package:flutter_box/pages/mobile/ImageEdit.dart';
import 'package:flutter_box/pages/mobile/NetworkStatus.dart';
import 'package:flutter_box/pages/mobile/PermissionPage.dart';
import 'package:flutter_box/pages/mobile/StopWatchPage.dart';
import 'package:flutter_box/pages/mobile/VideoPageView.dart';
import 'package:flutter_box/pages/mobile/WebViewPage.dart';

Map<String, WidgetBuilder> routes = {
  '/stopWatch': (context) => StopWatchPage(),
  '/networkStatus': (context) => NetworkStatus(),
  '/permission': (context) => PermissionPage(),
  '/webview': (context) => WebViewPage(),
  '/videoPlayer': (context) => VideoPageView(),
  '/imageEdit': (context) => ImageEdit(),
  '/canvas': (context) => CompleteGuide(begin: true),
};
