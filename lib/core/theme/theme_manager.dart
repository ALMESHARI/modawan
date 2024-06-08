import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeManager with ChangeNotifier {
  late ThemeMode _themeMode;

  ThemeManager() {
    final cached = Hive.box('settings').get('theme');
    if (cached != null) {
      _themeMode = cached == 'dark' ? ThemeMode.dark : ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
  }

  get themeMode => _themeMode;

  toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _updateTheme(_themeMode);
    notifyListeners();
  }

  _updateTheme(ThemeMode theme) {
    Hive.box('settings').put('theme', theme.toString().split('.')[1]);
  }
}
