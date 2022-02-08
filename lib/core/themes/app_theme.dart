import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  const AppTheme._();

  static Color lightBackgrounColor = const Color(0xfff2f2f2);
  static Color lightPrimaryColor = const Color(0xfff2f2f2);
  //static Color lightAccentColor = Colors.blueGrey.shade200;
  static Color lightParticleColor = const Color(0x44948282);

  static Color darkBackgrounColor = const Color(0xff1A2127);
  static Color darkPrimaryColor = const Color(0xff1A2127);
  //static Color darkAccentColor = Colors.blueGrey.shade600;
  static Color darkParticleColor = const Color(0x441C2A30);

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    backgroundColor: lightBackgrounColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    backgroundColor: darkBackgrounColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static setStatusBarAndNavigationBarColor(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: themeMode == ThemeMode.light
            ? lightBackgrounColor
            : darkBackgrounColor,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }
}
