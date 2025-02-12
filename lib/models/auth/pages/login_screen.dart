import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:event_app/core/widgets/custom_text_form_filed.dart';
import 'package:event_app/models/auth/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Consumer<AuthProvider>(
                  builder: (context, provider, child) {
                    return   Form(
                      key: provider.formKey,
                      child: Column(
                        children: [
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
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          CustomTextFormFiled(
                            controller: provider.emailController,
                            validator: (value) {
                              if(value==null||value.isEmpty){
                                return "Invalid value";
                              }
                              else{
                                return null;
                              }
                            },
                            prefixIcon: Icon(Icons.email_rounded),
                            labelText: AppLocalizations.of(context)!.l_email,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CustomTextFormFiled(
                            controller: provider.passwordController,
                            validator: (value) {
                              if(value==null||value.isEmpty){
                                return "Invalid value";
                              }
                              else{
                                return null;
                              }
                            },
                            labelText: AppLocalizations.of(context)!.l_password,
                            isPassword: true,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.forgetPassScreen);
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
                            onTap: () {
                              if(provider.formKey.currentState!.validate()){
                                provider.login(context);
                              }
                            },
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
                                  Navigator.pushNamed(
                                      context, RoutesName.createAccountScreen);
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
                                      backgroundColor:
                                      appProvider.themeMode == ThemeMode.light
                                          ? Colors.white
                                          : theme.scaffoldBackgroundColor,
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
                                            fontFamily: GoogleFonts.inter().fontFamily,
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
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          AnimatedToggleSwitch<String>.rolling(
                            textDirection: TextDirection.ltr,
                            current: appProvider.lang,
                            values: ["en", "ar"],
                            onChanged: (value) {
                              appProvider.changeLanguage();
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
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          AnimatedToggleSwitch<ThemeMode>.rolling(
                            textDirection: TextDirection.ltr,
                            current: appProvider.themeMode,
                            values: [ThemeMode.light, ThemeMode.dark],
                            onChanged: (value) {
                              appProvider.changeTheme();
                            },
                            iconList: [
                              Image.asset(AppAssets.sunIcon),
                              Image.asset(
                                AppAssets.moonIcon,
                                color: appProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : null,
                              ),
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
                    );
                  },

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
