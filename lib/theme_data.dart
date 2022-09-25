import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData green = ThemeData(primarySwatch: Colors.green, scaffoldBackgroundColor: Colors.green.shade50);
ThemeData red = ThemeData(primarySwatch: Colors.red, scaffoldBackgroundColor: Colors.red.shade50);

class ThemeDataChange with ChangeNotifier {
  //provider kısmı
  static bool _isGreen = true;

  bool get isGreen {
    return _isGreen;
  }

  ThemeData get themeColor {
    return _isGreen ? green : red;
  }

  void changeTheme() {
    _isGreen = !_isGreen;
    saveThemeToSharedPreferences(_isGreen);
    notifyListeners();
  }

  // sharedPreferences kısmı

  static late SharedPreferences _sharedpref;
  String themeDataKey = 'themeData';

  static Future<void> createSharedPrefObject() async {
    _sharedpref = await SharedPreferences.getInstance();
  }

  void saveThemeToSharedPreferences(bool value) {
    _sharedpref.setBool(themeDataKey, value);
  }

  Future<void> loadThemeFromSharedPref() async {
    //await createSharedPrefObject();

    _isGreen = _sharedpref.getBool(themeDataKey) ?? true;

    // if (_sharedpref.getBool(themeDataKey) == null) {
    //   _isGreen = true;
    // } else {
    //   _isGreen = _sharedpref.getBool(themeDataKey);
    // }
  }
}
