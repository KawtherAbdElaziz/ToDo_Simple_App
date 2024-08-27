// import 'package:flutter/material.dart';

// class SettingsProvider extends ChangeNotifier {
//   String currentLangauge = "en";
//   ThemeMode currentThemeMode = ThemeMode.light;

//   changeCurrentLangauge(String newLangauge) {
//     if (currentLangauge == newLangauge) return;
//     currentLangauge = newLangauge;
//     notifyListeners();
//   }

//   changeCurrentTheme(ThemeMode newTheme) {
//     if (currentThemeMode == newTheme) return;
//     currentThemeMode = newTheme;
//     notifyListeners();
//   }

//   // String getBackgroundImage() {
//   //   return currentThemeMode == ThemeMode.dark
//   //       ? "assets/images/dark_bg.png"
//   //       : "assets/images/bg3.png";
//   // }

//   // String getSplashScreenImage() {
//   //   return currentThemeMode == ThemeMode.dark
//   //       ? "assets/images/splashdark.png"
//   //       : "assets/images/Group 8.png";
//   // }

//   // String getSephaP1Image() {
//   //   return currentThemeMode == ThemeMode.dark
//   //       ? "assets/images/head_sebha_dark.png"
//   //       : "assets/images/head_sebha_logo.png";
//   // }

//   // String getSephaP2Image() {
//   //   return currentThemeMode == ThemeMode.dark
//   //       ? "assets/images/body_sebha_dark.png"
//   //       : "assets/images/body_sebha_logo.png";
//   // }

//   isDark() {
//     return (currentThemeMode == ThemeMode.dark);
//   }

// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String _currentLanguage = "en";
  ThemeMode _currentThemeMode = ThemeMode.light;

  SettingsProvider() {
    _loadPreferences();
  }

  String get currentLanguage => _currentLanguage;

  ThemeMode get currentThemeMode => _currentThemeMode;

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString('language') ?? 'en';
    _currentThemeMode = ThemeMode.values[prefs.getInt('themeMode') ?? 0];
    notifyListeners();
  }

  void _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', _currentLanguage);
    await prefs.setInt('themeMode', _currentThemeMode.index);
  }

  void changeCurrentLanguage(String newLanguage) {
    if (_currentLanguage == newLanguage) return;
    _currentLanguage = newLanguage;
    _savePreferences();
    notifyListeners();
  }

  void changeCurrentTheme(ThemeMode newTheme) {
    if (_currentThemeMode == newTheme) return;
    _currentThemeMode = newTheme;
    _savePreferences();
    notifyListeners();
  }

  String getSplashScreenImage() {
    return currentThemeMode == ThemeMode.dark
        ? "assets/images/splashdark 1@3x.png"
        : "assets/images/splash@3x.png";
  }

  bool isDark() {
    return (_currentThemeMode == ThemeMode.dark);
  }
}
