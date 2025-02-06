import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/models/onboarding/pages/start_screen.dart';
import 'package:event_app/models/splash/pages/splash_Screen.dart';
import 'package:flutter/cupertino.dart';

import '../../models/auth/pages/login_screen.dart';

class AppRoutes{
  static Map<String, Widget Function(BuildContext)> routes= {
    RoutesName.splash : (_) =>SplashScreen(),
    RoutesName.startScreen : (_) =>StartScreen(),
    RoutesName.loginScreen : (_) =>LoginScreen(),

  };
}