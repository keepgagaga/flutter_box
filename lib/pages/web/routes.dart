import 'package:flutter/material.dart';
import 'package:flutter_box/pages/web/Components.dart';
import 'package:flutter_box/pages/web/Home.dart';
import 'package:flutter_box/pages/web/Tools.dart';

class Routes {
  static const String HOME = '/';
  static const String COMPONENTS = '/components';
  static const String TOOLS = '/tools';

  static final Map<String, WidgetBuilder> routes = {
    // HOME: (context) => Home(),
    COMPONENTS: (context) => Components(),
    TOOLS: (context) => Tools(),
  };
}
