
import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.system;

  get themeMode => _themeMode;

  toggleTheme(){
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}