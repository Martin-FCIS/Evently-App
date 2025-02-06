import 'package:event_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._();
  static ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor: AppColors.lightBg,
    primaryColor: AppColors.primamryColor,
    primaryColorLight:Colors.white,
    primaryColorDark: Colors.black,
  );
  static ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor: AppColors.darktBg,
    primaryColor: AppColors.primamryColor,
    primaryColorLight:Colors.black,
    primaryColorDark: Colors.white,
  );
}