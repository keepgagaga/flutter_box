import 'dart:math';

import 'package:flutter/material.dart';

class RandomColor {
  static final Random _random = Random();

  static Color getColor() {
    return Color.fromRGBO(
        _random.nextInt(256), _random.nextInt(256), _random.nextInt(256), 1);
  }
}
