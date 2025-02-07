import 'package:event_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._();
  static ThemeData lightTheme=ThemeData(
    appBarTheme: AppBarTheme(centerTitle: true,backgroundColor: AppColors.lightBg,titleTextStyle: TextStyle(color: Colors.black,fontSize: 25)),
    scaffoldBackgroundColor: AppColors.lightBg,
    primaryColor: AppColors.primamryColor,
    primaryColorLight:Colors.white,
    primaryColorDark: Colors.black,
    textTheme: TextTheme(
      bodySmall: TextStyle(color: Colors.black,fontSize: 14),
      bodyMedium: TextStyle(color: Colors.black,fontSize: 18),
      bodyLarge: TextStyle(color: Colors.black,fontSize: 20),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: BorderSide(color: Colors.grey)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: BorderSide(color: Colors.grey)),
    ),
  );
  static ThemeData darkTheme=ThemeData(
      appBarTheme: AppBarTheme(centerTitle: true,backgroundColor: AppColors.darktBg,titleTextStyle: TextStyle(color: AppColors.primamryColor,fontSize: 25)),
      scaffoldBackgroundColor: AppColors.darktBg,
    primaryColor: AppColors.primamryColor,
    primaryColorLight:Colors.black,
    primaryColorDark: Colors.white,
  textTheme: TextTheme(
  bodySmall: TextStyle(color: Colors.white,fontSize: 14),
  bodyMedium: TextStyle(color: Colors.white,fontSize: 18),
  bodyLarge: TextStyle(color: Colors.white,fontSize: 20),
  ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: BorderSide(color: AppColors.primamryColor)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: BorderSide(color: AppColors.primamryColor)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: BorderSide(color: AppColors.primamryColor)),
    )
  );
}