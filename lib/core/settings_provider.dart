import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String currentLangauge = "en";
  ThemeMode currentThemeMode = ThemeMode.light;

  changeCurrentLangauge(String newLangauge) {
    if (currentLangauge == newLangauge) return;
    currentLangauge = newLangauge;
    notifyListeners();
  }

  changeCurrentTheme(ThemeMode newTheme) {
    if (currentThemeMode == newTheme) return;
    currentThemeMode = newTheme;
    notifyListeners();
  }

  // String getBackgroundImage() {
  //   return currentThemeMode == ThemeMode.dark
  //       ? "assets/images/dark_bg.png"
  //       : "assets/images/bg3.png";
  // }

  // String getSplashScreenImage() {
  //   return currentThemeMode == ThemeMode.dark
  //       ? "assets/images/splashdark.png"
  //       : "assets/images/Group 8.png";
  // }

  // String getSephaP1Image() {
  //   return currentThemeMode == ThemeMode.dark
  //       ? "assets/images/head_sebha_dark.png"
  //       : "assets/images/head_sebha_logo.png";
  // }

  // String getSephaP2Image() {
  //   return currentThemeMode == ThemeMode.dark
  //       ? "assets/images/body_sebha_dark.png"
  //       : "assets/images/body_sebha_logo.png";
  // }

  isDark() {
    return (currentThemeMode == ThemeMode.dark);
  }
}
