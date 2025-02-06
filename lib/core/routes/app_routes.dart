import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/models/splash/pages/splash_Screen.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes{
  static Map<String, Widget Function(BuildContext)> routes= {
    RoutesName.splash : (_) =>SplashScreen(),

  };
}