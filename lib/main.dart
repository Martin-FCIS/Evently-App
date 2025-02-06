import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      builder: (context, child) {
        var provider=Provider.of<AppProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          themeMode: provider.themeMode,
          darkTheme: AppTheme.darkTheme,
          routes: AppRoutes.routes,
          initialRoute: RoutesName.splash,
        );
      },

    );
  }
}