import 'package:flutter/material.dart';

class ColorState with ChangeNotifier {
  bool _isLightGreen = false;

  bool get getIsLightGreen {
    return _isLightGreen;
  }

  Color get getColor {
    return _isLightGreen ? Colors.blue : Colors.green;
  }

  set setColor(bool value) {
    _isLightGreen = value;
    notifyListeners();
  }
}
