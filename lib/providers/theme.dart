import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  // default
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    init();
  }

  ThemeMode get themeMode => _themeMode;
  ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
  ThemeData get darkTheme => ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  set themeMode(ThemeMode mode) {
    _themeMode = mode;

    saveCurrentTheme();

    notifyListeners();
  }

  Future<void> saveCurrentTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('theme', ThemeMode.values.indexOf(_themeMode));
  }

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      _themeMode = ThemeMode.values[prefs.getInt('theme')];
    } catch (e) {
      await saveCurrentTheme();
    }

    notifyListeners();
  }
}
