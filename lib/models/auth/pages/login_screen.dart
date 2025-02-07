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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Bounce(child: Image.asset(AppAssets.eventLogo)),
                  Bounce(
                    child: Text(
                      "Evently",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: GoogleFonts
                              .jockeyOne()
                              .fontFamily,
                          color: theme.primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_rounded),
                        labelText: AppLocalizations.of(context)!.l_email,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.visibility_off)),
                      labelText: AppLocalizations.of(context)!.l_password,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context,
                                RoutesName.forgetPassScreen);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.l_forget,
                            style: theme.textTheme.bodyLarge!.copyWith(
                                color: theme.primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: theme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  CustomButton(
                    text: AppLocalizations.of(context)!.l_login,
                    onTap: () {},
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        AppLocalizations.of(context)!.l_donthaveacc,
                        style: theme.textTheme.bodyMedium,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context,
                              RoutesName.createAccountScreen);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.l_createacc,
                          style: theme.textTheme.bodyLarge!.copyWith(
                              color: theme.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                            color: theme.primaryColor,
                            endIndent: 20,
                            indent: 20,
                          )),
                      Text(
                        AppLocalizations.of(context)!.l_or,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: theme.primaryColor),
                      ),
                      Expanded(
                          child: Divider(
                            color: theme.primaryColor,
                            endIndent: 20,
                            indent: 20,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: provider.themeMode ==
                                  ThemeMode.light ? Colors.white : theme
                                  .scaffoldBackgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(color: theme.primaryColor)),
                              padding: EdgeInsets.all(16)),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAssets.googleIcon,
                                width: 25,
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Text(
                                AppLocalizations.of(context)!.l_google,
                                style: TextStyle(
                                    fontFamily: GoogleFonts
                                        .inter()
                                        .fontFamily,
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.04,),
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
          ),
        ),
      ),
    );
  }
}
