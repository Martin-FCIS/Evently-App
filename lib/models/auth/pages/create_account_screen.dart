import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/manager/app_provider.dart';
import '../../../core/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.c_reg,
        ),

        leading: IconButton(onPressed: (){
          Navigator.pushReplacementNamed(context,RoutesName.loginScreen);
        }, icon: Icon(Icons.arrow_back,color:provider.themeMode == ThemeMode.light? Colors.black:theme.primaryColor,))
      ),
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
                          fontFamily: GoogleFonts.jockeyOne().fontFamily,
                          color: theme.primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: AppLocalizations.of(context)!.c_name,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
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
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.visibility_off)),
                      labelText: AppLocalizations.of(context)!.c_repass,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  CustomButton(
                    text: AppLocalizations.of(context)!.l_createacc,
                    onTap: () {},
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
