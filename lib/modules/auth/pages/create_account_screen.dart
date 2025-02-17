import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/core/widgets/custom_text_form_filed.dart';
import 'package:event_app/modules/auth/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_regx.dart';
import '../../../core/manager/app_provider.dart';
import '../../../core/widgets/custom_button.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.c_reg,
          ),
          iconTheme: IconThemeData(
            color: appProvider.themeMode == ThemeMode.light
                ? Colors.black
                : theme.primaryColor,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Consumer<AuthProvider>(
                  builder: (context, provider, child) {
                    return Form(
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
                                  fontFamily:
                                      GoogleFonts.jockeyOne().fontFamily,
                                  color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          CustomTextFormFiled(
                            controller: provider.nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Invalid Value";
                              } else {
                                return null;
                              }
                            },
                            hintText: AppLocalizations.of(context)!.c_name,
                            prefixIcon: Icon(
                              Icons.person_rounded,
                              color: appProvider.themeMode == ThemeMode.light
                                  ? Colors.grey
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CustomTextFormFiled(
                            controller: provider.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Invalid Value";
                              } else if (!AppRegx.emailRegex.hasMatch(value)) {
                                return "invalid Email";
                              } else {
                                return null;
                              }
                            },
                            hintText: AppLocalizations.of(context)!.l_email,
                            prefixIcon: Icon(
                              Icons.email_rounded,
                              color: appProvider.themeMode == ThemeMode.light
                                  ? Colors.grey
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CustomTextFormFiled(
                            controller: provider.passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Invalid Value";
                              } else if (value.length < 8) {
                                return "Password must be more than 8 characters";
                              } else {
                                return null;
                              }
                            },
                            hintText: AppLocalizations.of(context)!.l_password,
                            isPassword: true,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CustomTextFormFiled(
                            controller: provider.rePasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "invalid value";
                              } else if (value !=
                                  provider.passwordController.text) {
                                return "Password not match";
                              } else {
                                return null;
                              }
                            },
                            hintText: AppLocalizations.of(context)!.c_repass,
                            isPassword: true,
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          CustomButton(
                            text: AppLocalizations.of(context)!.l_createacc,
                            onTap: () {
                              provider.createAccount(context);
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                AppLocalizations.of(context)!.c_already,
                                style: theme.textTheme.bodyMedium,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, RoutesName.loginScreen);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.c_login,
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
