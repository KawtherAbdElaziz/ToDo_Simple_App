import 'package:flutter/material.dart';

class ApplicationThemeManager {
  static Color primaryColor = const Color(0xffffffff);
  static Color primaryDarkColor = const Color(0xff141922);
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
            fontFamily: "Poppins",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff5D9CEC),
        selectedIconTheme: IconThemeData(color: Color(0xff5D9CEC), size: 35),
        unselectedIconTheme: IconThemeData(color: Color(0xffC8C9CB), size: 28),
        unselectedItemColor: Color(0xffC8C9CB),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(fontSize: 12)),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontFamily: "Poppins",
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff)),
      bodyLarge: TextStyle(
          color: Color(0xff5D9CEC),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins"),
      bodyMedium: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          // fontWeight: FontWeight.w500,
          color: Color(0xff242424)),
      bodySmall: TextStyle(
          fontFamily: "Poppins",
          fontSize: 12,
          // fontWeight: FontWeight.w500,
          color: Color(0xff242424)),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryDarkColor,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
            fontFamily: "Poppins",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff000000))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff5D9CEC),
        selectedIconTheme: IconThemeData(color: Color(0xff5D9CEC)),
        unselectedIconTheme: IconThemeData(color: Color(0xffC8C9CB)),
        unselectedItemColor: Color(0xffC8C9CB),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(fontSize: 12)),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontFamily: "Poppins",
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff)),
      bodyLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xff5D9CEC),
          fontSize: 18,
          fontFamily: "Poppins"),
      bodyMedium: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          // fontWeight: FontWeight.w500,
          color: Color(0xffffffff)),
      bodySmall: TextStyle(
          fontFamily: "Poppins",
          fontSize: 12,
          // fontWeight: FontWeight.w500,
          color: Color(0xffffffff)),
    ),
  );
}
