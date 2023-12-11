import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wattkeeperr/utils/themes.dart';

class ThemeController {
  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') == true
        ? ThemeMode.dark
        : prefs.getBool('isDark') == false
            ? ThemeMode.light
            : ThemeMode.system;
  }

  Future<ThemeData> getThemeData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') == true
        ? Themes().darkTheme
        : Themes().lightTheme;
  }

  Future<bool> isDarkStore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') ?? false;
  }

  Future<void> changeTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDarkMode);
  }
}
