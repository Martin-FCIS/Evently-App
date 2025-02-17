import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../themes/app_colors.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String lang = "en";

  void changeTheme([ThemeMode? newThemeMode]) {
    if (newThemeMode != null) {
      themeMode = newThemeMode;
    } else {
      if (themeMode == ThemeMode.light) {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.light;
      }
    }
    saveTheme();
    notifyListeners();
  }

  Future<void> saveTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Theme", themeMode.name);
  }

  Future<void> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString("Theme") ?? "light";
    if (theme == "light") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }

  void changeLanguage([String? newLang]) {
    if (newLang != null) {
      lang = newLang;
    } else {
      if (lang == "en") {
        lang = "ar";
      } else {
        lang = "en";
      }
    }
    saveLang();
    notifyListeners();
  }

  Future<void> saveLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Lang", lang);
  }

  Future<void> getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang = prefs.getString("Lang") ?? "en";
  }

  void showSnackBar(
      {required BuildContext context,
      required String message,
      required bool showCloseIcon,
      bool isLoginOrResetPass = false,
      String userNameOrEmail = ""}) {
    final snackBar = SnackBar(
      content: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: !isLoginOrResetPass
            ? Text(message)
            : Row(children: [
                Text(message),
                SizedBox(
                  width: 10,
                ),
                Text(userNameOrEmail),
              ]),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      closeIconColor: Colors.red,
      showCloseIcon: showCloseIcon,
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
