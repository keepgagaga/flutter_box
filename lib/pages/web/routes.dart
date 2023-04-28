import 'package:flutter/material.dart';
import 'package:flutter_box/pages/web/About.dart';
import 'package:flutter_box/pages/web/Components.dart';
import 'package:flutter_box/pages/web/Tools.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    "components": (context) => Components(),
    "tools": (context) => Tools(),
    "about": (context) => About(),
  };
}
