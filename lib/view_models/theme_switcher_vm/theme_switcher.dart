import 'package:flutter/cupertino.dart';

class ThemeSwitcher extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => this._isDark;

  set isDark(bool value) {
    this._isDark = value;
    notifyListeners();
  }
}
