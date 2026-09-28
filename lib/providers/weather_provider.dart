import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode;
  final SharedPreferences _prefs;

  ThemeProvider(this._prefs) {
    _themeMode = ThemeMode.values[_prefs.getInt('themeMode') ?? 0];
  }

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _prefs.setInt('themeMode', mode.index);
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    _prefs.setInt('themeMode', _themeMode.index);
    notifyListeners();
  }
}
