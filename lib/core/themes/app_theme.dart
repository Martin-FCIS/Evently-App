import 'package:event_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._();
  static ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor: AppColors.lightBg,
    primaryColor: AppColors.primamryColor,
    primaryColorLight:Colors.white,
    primaryColorDark: Colors.black,
    textTheme: TextTheme(
      bodySmall: TextStyle(color: Colors.black,fontSize: 14),
      bodyMedium: TextStyle(color: Colors.black,fontSize: 18),
      bodyLarge: TextStyle(color: Colors.black,fontSize: 20),
    )
  );
  static ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor: AppColors.darktBg,
    primaryColor: AppColors.primamryColor,
    primaryColorLight:Colors.black,
    primaryColorDark: Colors.white,
  textTheme: TextTheme(
  bodySmall: TextStyle(color: Colors.white,fontSize: 14),
  bodyMedium: TextStyle(color: Colors.white,fontSize: 18),
  bodyLarge: TextStyle(color: Colors.white,fontSize: 20),
  )
  );
}