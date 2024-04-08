import 'package:flutter/material.dart';
import 'package:money_track/theme/theme.dart';
import 'package:provider/provider.dart';

enum ThemeType { Light, Dark, System }

class ThemeProvider extends ChangeNotifier {
  late ThemeData _themeData = lightMode;
  ThemeType _currentTheme = ThemeType.Light;

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.Light:
        _themeData = lightMode;
        break;
      case ThemeType.Dark:
        _themeData = darkMode;
        break;
      case ThemeType.System:
        _themeData = MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .platformBrightness ==
            Brightness.dark
            ? darkMode
            : lightMode;
        break;
    }
    _currentTheme = themeType;
    notifyListeners();
  }

  ThemeType getCurrentTheme() => _currentTheme;
}
