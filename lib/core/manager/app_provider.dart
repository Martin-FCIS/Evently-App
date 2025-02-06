import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  ThemeMode themeMode=ThemeMode.light;
  void changeTheme(){
    if(themeMode==ThemeMode.light){
      themeMode=ThemeMode.dark;
    }
    else{
      themeMode=ThemeMode.light;
    }
    notifyListeners();
  }
}