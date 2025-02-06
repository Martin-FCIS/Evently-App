import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      routes: AppRoutes.routes,
      initialRoute: RoutesName.splash,
    );
  }
}