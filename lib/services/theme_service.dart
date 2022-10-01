import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService with ChangeNotifier {
  final SharedPreferences sharedPref;
  ThemeService(this.sharedPref);

  static const darkThemeKey = "dark_theme";

  bool _darkTheme = true;

  bool get darkTheme {
    return sharedPref.getBool(darkThemeKey) ?? _darkTheme;
  }

  set darkTheme(bool val) {
    _darkTheme = val;
    sharedPref.setBool(darkThemeKey, val);
    notifyListeners();
  }

  // bool get darkTheme => _darkTheme;      <- method without shared preference

  // set darkTheme(bool val) {
  //   _darkTheme = val;
  //   notifyListeners();
  // }
}
