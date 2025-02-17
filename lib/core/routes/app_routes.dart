import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/firebase_manager/models/event_model.dart';
import 'package:event_app/modules/auth/pages/create_account_screen.dart';
import 'package:event_app/modules/auth/pages/forget_password_screen.dart';
import 'package:event_app/modules/event/pages/create_event.dart';
import 'package:event_app/modules/event/pages/event_details.dart';
import 'package:event_app/modules/layout/pages/layout_screen.dart';
import 'package:event_app/modules/onboarding/pages/onboarding_screen.dart';
import 'package:event_app/modules/onboarding/pages/start_screen.dart';
import 'package:event_app/modules/splash/pages/splash_Screen.dart';
import 'package:flutter/cupertino.dart';

import '../../modules/auth/pages/login_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesName.splash: (_) => SplashScreen(),
    RoutesName.startScreen: (_) => StartScreen(),
    RoutesName.loginScreen: (_) => LoginScreen(),
    RoutesName.createAccountScreen: (_) => CreateAccountScreen(),
    RoutesName.forgetPassScreen: (_) => ForgetPasswordScreen(),
    RoutesName.layoutScreen: (_) => LayoutScreen(),
    RoutesName.createEventScreen: (context) {
      var event = ModalRoute.of(context)!.settings.arguments;
      if (event == null) {
        return CreateEvent();
      } else if (event is EventModel) {
        return CreateEvent(
          event: event,
        );
      } else {
        return CreateEvent();
      }
    },
    RoutesName.onboardingScreen: (_) => OnboardingScreen(),
    RoutesName.eventDetailsScreen: (context) {
      var event = ModalRoute.of(context)!.settings.arguments as EventModel;
      return EventDetails(
        event: event,
      );
    },
  };
}
