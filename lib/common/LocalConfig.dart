import 'package:flutter/material.dart';

class LocalConfig with ChangeNotifier {
  LocalConfig(this._localData);

  Locale _localData;

  Locale get getLocal => _localData;

  void setLocal(Locale local) {
    _localData = local;
    notifyListeners();
  }
}
