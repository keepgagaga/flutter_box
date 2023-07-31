import 'package:flutter/material.dart';

class ThemeConfig with ChangeNotifier {
  ThemeConfig(this._themeData);

  ThemeData _themeData;

  ThemeData get getTheme => _themeData;

  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
