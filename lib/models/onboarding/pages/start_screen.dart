import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInLeftBig(
                      child: Image.asset(
                        AppAssets.eventLogo,
                        width: 50,
                      )),
                  SizedBox(
                    width: size.width * 0.025,
                  ),
                  FadeInRightBig(
                    child: Text(
                      "Evently",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          fontFamily: GoogleFonts
                              .jockeyOne()
                              .fontFamily,
                          color: theme.primaryColor),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Expanded(
                  flex: 6,
                  child: Center(child: Image.asset(
                    AppAssets.startLight, width: double.infinity,
                    fit: BoxFit.fill,))),
              Spacer(),
              Text(
                AppLocalizations.of(context)!.start_title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts
                        .inter()
                        .fontFamily,
                    fontSize: 24,
                    color: theme.primaryColor),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                  AppLocalizations.of(context)!.start_desc,
                  style: theme.textTheme.bodyMedium
              ),
              SizedBox(height: size.height * 0.03),
              Expanded(
                child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.lang,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: GoogleFonts
                            .inter()
                            .fontFamily,
                        color: theme.primaryColor,
                      ),
                    ),
                    AnimatedToggleSwitch<String>.rolling(
                      current: provider.lang,
                      values: ["en", "ar"],
                      onChanged: (value) {
                        provider.changeLanguage();
                      },
                      iconList: [
                        Image.asset(AppAssets.americanIcon),
                        Image.asset(AppAssets.egyIcon),
                      ],
                      height: 40,
                      indicatorSize: Size(40, 40),
                      style: ToggleStyle(
                          backgroundColor: Colors.transparent,
                          indicatorColor: theme.primaryColor,
                          borderColor: theme.primaryColor),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: GoogleFonts
                            .inter()
                            .fontFamily,
                        color: theme.primaryColor,
                      ),
                    ),
                    AnimatedToggleSwitch<ThemeMode>.rolling(
                      current: provider.themeMode,
                      values: [ThemeMode.light, ThemeMode.dark],
                      onChanged: (value) {
                        provider.changeTheme();
                      },
                      iconList: [
                        Image.asset(AppAssets.sunIcon),
                        Image.asset(AppAssets.moonIcon,
                          color: provider.themeMode == ThemeMode.dark ? Colors
                              .white : null,),
                      ],
                      height: 40,
                      indicatorSize: Size(40, 40),
                      style: ToggleStyle(
                          backgroundColor: Colors.transparent,
                          indicatorColor: theme.primaryColor,
                          borderColor: theme.primaryColor),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomButton(text: AppLocalizations.of(context)!.l_start,
                   onTap:() {
                     Navigator.pushReplacementNamed(context, RoutesName.loginScreen);

                   },),
            ],
          ),
        ),
      ),
    );
  }
}
