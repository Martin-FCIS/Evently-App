import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier{
  ThemeMode themeMode=ThemeMode.light;
  String lang="en";
  void changeTheme(){
    if(themeMode==ThemeMode.light){
      themeMode=ThemeMode.dark;
    }
    else{
      themeMode=ThemeMode.light;
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
    String theme= prefs.getString("Theme")?? "light";
    if(theme=="light"){
      themeMode=ThemeMode.light;
    }
    else
    {
      themeMode=ThemeMode.dark;
    }

  }
  void changeLanguage(){
    if(lang=="en"){
      lang="ar";
    }
    else{
      lang="en";
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
   lang= prefs.getString("Lang")?? "en";
}
}