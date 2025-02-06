import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/manager/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider=Provider.of<AppProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                          fontFamily: GoogleFonts.jockeyOne().fontFamily,
                          color: theme.primaryColor),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Expanded(
                  flex: 6,
                  child: Center(child: Image.asset(AppAssets.startLight))),
              Spacer(),
              Text(
                "Personalize Your Experience",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 24,
                    color: theme.primaryColor),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                  "Choose your preferred theme and language to \nget started with a comfortable, tailored \nexperience that suits your style.",
                  style:theme.textTheme.bodyMedium
              ),
              SizedBox(height: size.height * 0.03),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Language",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: theme.primaryColor,
                      ),
                    ),
                    AnimatedToggleSwitch<String>.rolling(
                      current: "en",
                      values: ["en", "ar"],
                      onChanged: (value) {},
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Theme",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: GoogleFonts.inter().fontFamily,
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
                        Image.asset(AppAssets.moonIcon,color: provider.themeMode==ThemeMode.dark ? Colors.white :null,),
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
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              padding: EdgeInsets.all(16)),
                          onPressed: () {},
                          child: Text(
                            "Let's Start",
                            style: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
