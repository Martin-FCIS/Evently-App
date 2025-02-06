import 'package:animate_do/animate_do.dart';
import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: FadeInDown(
          onFinish: (direction) {
            Future.delayed(
              Duration(seconds: 2),
                (){},
            );
          },
          child: Column(
            children: [
              Spacer(),
              Bounce(child: Image.asset(AppAssets.eventLogo)),
              Bounce(
                child: Text(
                  "Evently",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: GoogleFonts.jockeyOne().fontFamily,
                      color: theme.primaryColor),
                ),
              ),
              Spacer(),
              FadeInUp(
                  delay: Duration(seconds: 1),
                  child: Image.asset(AppAssets.routeLogo)),
            ],
          ),
        ),
      ),
    );
  }
}
