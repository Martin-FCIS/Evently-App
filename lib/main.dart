import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/core/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider()..getTheme()..getLang(),
      builder: (context, child) {
        var appProvider=Provider.of<AppProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          locale: Locale(appProvider.lang),
          theme: AppTheme.lightTheme,
          themeMode: appProvider.themeMode,
          darkTheme: AppTheme.darkTheme,
          routes: AppRoutes.routes,
          initialRoute: RoutesName.splash,
        );
      },

    );
  }
}