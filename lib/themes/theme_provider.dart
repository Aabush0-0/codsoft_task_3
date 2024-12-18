import 'package:flutter/material.dart';
import 'package:music_app/themes/dark.dart';
import 'package:music_app/themes/light.dart';

class ThemeProvider extends ChangeNotifier {
  //light mode at initial
  ThemeData _themeData = lightMode;

  //
  ThemeData get themeData => _themeData;

  //is dark mode
  bool get isDarkMode => _themeData == darkMode;

  //set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    //update UI
    notifyListeners();
  }

  //toggle modes
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
